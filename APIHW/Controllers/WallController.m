//
//  WallController.m
//  APIHW
//
//  Created by Kozaderov Ivan on 06/05/2019.
//  Copyright © 2019 n1ke71. All rights reserved.
//

#import "WallController.h"
#import "ServerManager.h"
#import "Post.h"
#import "User.h"
#import "GroupInfo.h"
#import "UIImageView+AFNetworking.h"
#import "WallCell.h"
#import "TitleWallCell.h"
#import "MessageViewController.h"
#import "CommentsController.h"

@interface WallController () <WallCellDelegate>
@property (strong ,nonatomic) NSMutableArray *postsArray;
@property (strong ,nonatomic) NSMutableArray *usersArray;
@property (strong ,nonatomic) GroupInfo *groupInfo;
@property (strong ,nonatomic) User *user;
@property (strong ,nonatomic) Post *post;
@end

@implementation WallController

static NSInteger postsInRequest = 5;

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self.tableView registerClass:[WallCell class] forCellReuseIdentifier:@"WallCell"];
        [self.tableView registerClass:[TitleWallCell class] forCellReuseIdentifier:@"TitleWallCell"];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"Wall";
    self.navigationController.navigationBar.prefersLargeTitles = YES;
    self.tableView.estimatedRowHeight = 44.f;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.postsArray = [NSMutableArray array];
    self.usersArray = [NSMutableArray array];
    [self getGroupInfoFromServer];
    [self getPostsFromServer];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self getUsersFromServer];
    });
}

#pragma mark - API

- (void) getPostsFromServer {
    
    [[ServerManager sharedManager]
     getGroupWall:@"-58860049"
     withOffset:[self.postsArray count]
     count:postsInRequest
     onSuccess:^(NSArray * _Nonnull posts) {
         
         [self.postsArray addObjectsFromArray:posts];
         [self.tableView reloadData];
         
     }
     onFailure:^(NSError * _Nonnull error, NSInteger statusCode) {
         NSLog(@"error:%@ statusCode:%ld",[error localizedDescription],statusCode);
     }];
    
}

- (void) getUsersFromServer{
    for (Post *post in self.postsArray) {
        [[ServerManager sharedManager]
         getUserWithID:post.fromID onSuccess:^(User * _Nonnull user) {
             post.author = user;
         } onFailure:^(NSError * _Nonnull error, NSInteger statusCode) {
             NSLog(@"error:%@ statusCode:%ld",[error localizedDescription],statusCode);
         }];
    }
}

- (void) getGroupInfoFromServer{
    [[ServerManager sharedManager] getGroupInfo:@"" onSuccess:^(GroupInfo * _Nonnull groupInfo) {
        self.groupInfo = groupInfo;
        [self.tableView reloadData];
    } onFailure:^(NSError * _Nonnull error, NSInteger statusCode) {
        NSLog(@"error:%@ statusCode:%ld",[error localizedDescription],statusCode);
    }];
}

#pragma mark - TableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    if (section == 0) {
        return 1;
    } else {
        return [self.postsArray count] + 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WallCell *wallCell = [tableView dequeueReusableCellWithIdentifier:@"WallCell" forIndexPath:indexPath];
    wallCell.delegate = self;
    TitleWallCell *titleWallCell = [tableView dequeueReusableCellWithIdentifier:@"TitleWallCell" forIndexPath:indexPath];
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    [wallCell.loadingIndicator startAnimating];
    
    if (indexPath.section == 0) {
        titleWallCell.groupNameLabel.text = self.groupInfo.name;
        titleWallCell.groupDescriptionLabel.text = self.groupInfo.groupDescription;
        titleWallCell.groupImageView.image = [self downloadImageWithURL:self.groupInfo.imageURL];
        return titleWallCell;
        
    }
    if (indexPath.section == 1) {
        if (indexPath.row == [self.postsArray count]) {
            cell.textLabel.text = @"LOAD MORE";
            cell.textLabel.textAlignment = NSTextAlignmentCenter;
            cell.imageView.image = nil;
            return cell;
        } else {
            Post *post = [self.postsArray objectAtIndex:indexPath.row];
            wallCell.post = post;
            wallCell.postLabel.text = post.text;
            wallCell.likeLabel.text = [@(post.likesNumber) stringValue];
            wallCell.commentLabel.text = [@(post.commentsNumber) stringValue];
            wallCell.repostLabel.text = [@(post.repostsNumber) stringValue];
            wallCell.dateLabel.text = [post stringFromDateNumber:post.date];
            wallCell.authorNameLabel.text = [post.author description];
//            UIImage *authorImage = [self downloadImageWithURL:post.author.imageURL];
//            if (authorImage) {
//                [wallCell.authorButton setBackgroundImage:authorImage forState:UIControlStateNormal];
//                [wallCell.loadingIndicator stopAnimating];
//            }


            NSURLRequest *request = [NSURLRequest requestWithURL:post.author.imageURL];
            __weak WallCell *weakCell = wallCell;

            [wallCell.authorButton.imageView setImageWithURLRequest:request
                                               placeholderImage:nil
                                                        success:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, UIImage * _Nonnull image) {
                                                            [wallCell.authorButton setBackgroundImage:image forState:UIControlStateNormal];
                                                            [wallCell.loadingIndicator stopAnimating];
                                                            [weakCell layoutSubviews];
                                                        }
                                                        failure:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, NSError * _Nonnull error) {

                                                        }];

            return wallCell;
        }
    } else {
        return cell;
    }
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == [self.postsArray count]) {
        [self getPostsFromServer];
    } else {
        
        Post *post = [self.postsArray objectAtIndex:indexPath.row];
        self.post = post;
        [self performSegueWithIdentifier:@"CommentsController" sender:self];
    }

    
}
#pragma mark - UIImageView+AFNetworking

- (UIImage *)downloadImageWithURL:(NSURL *)imageURL {
    
    UIImageView *imageView = [[UIImageView alloc]init];
    __weak UIImageView *weakImageView = imageView;
    weakImageView.image = nil;

        [imageView setImageWithURLRequest:[NSURLRequest requestWithURL:imageURL]
                         placeholderImage:nil
                                  success:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, UIImage * _Nonnull image) {
                                      weakImageView.image = image;
                                  }
                                  failure:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, NSError * _Nonnull error) {
                                      //NSLog(@"%@",[error localizedDescription]);
                                  }];
    return weakImageView.image;
}
#pragma mark - WallCellDelegate
- (void) didSelectPostAndAuthor:(Post *)post {
    self.post = post;
    self.user = post.author;
}
#pragma mark - Segue
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.destinationViewController isKindOfClass:[MessageViewController class]]) {
        MessageViewController *messageViewController = segue.destinationViewController;
        messageViewController.user = self.user;
        messageViewController.post = self.post;
    }
    if ([segue.destinationViewController isKindOfClass:[CommentsController class]]) {
        CommentsController *commentsController = segue.destinationViewController;
        commentsController.post = self.post;
    }
}

@end
