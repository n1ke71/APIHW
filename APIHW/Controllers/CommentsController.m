//
//  CommentsController.m
//  APIHW
//
//  Created by Kozaderov Ivan on 22/05/2019.
//  Copyright © 2019 n1ke71. All rights reserved.
//

#import "CommentsController.h"
#import "TitleCommentCell.h"
#import "Post.h"
#import "User.h"
#import "UIImageView+AFNetworking.h"
#import "Comment.h"
#import "ServerManager.h"
#import "CommentCell.h"
#import "CommentPostCell.h"

@interface CommentsController ()
@property (strong ,nonatomic) NSMutableArray *commentsArray;
@end

@implementation CommentsController

static NSInteger commentsInRequest = 10;

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self.tableView registerClass:[TitleCommentCell class] forCellReuseIdentifier:@"TitleCommentCell"];
        [self.tableView registerClass:[CommentCell class] forCellReuseIdentifier:@"CommentCell"];
        [self.tableView registerClass:[CommentPostCell class] forCellReuseIdentifier:@"CommentPostCell"];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"Posts";
    self.navigationController.navigationBar.prefersLargeTitles = YES;
    self.tableView.estimatedRowHeight = 44.f;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.commentsArray = [NSMutableArray array];
    [self getCommentsFromServer];
}
#pragma mark - API

- (void)getCommentsFromServer {
    
    [[ServerManager sharedManager] getCommentsFromWall:@"-58860049"
                                                postID:self.post.postID
                                            withOffset:[self.commentsArray count]
                                                 count:commentsInRequest
                                             onSuccess:^(NSArray * _Nonnull comments) {
                                                 [self.commentsArray addObjectsFromArray:comments];
                                                 [self.tableView reloadData];
                                           } onFailure:^(NSError * _Nonnull error, NSInteger statusCode) {
                                                  NSLog(@"error:%@ statusCode:%ld",[error localizedDescription],statusCode);
                                           }];
}

#pragma mark - TableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }
    if (section == 1) {
        return [self.commentsArray count];
    }
    if (section == 2) {
        return 1;
    }
    return 1;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TitleCommentCell *titleCommentCell = [tableView dequeueReusableCellWithIdentifier:@"TitleCommentCell" forIndexPath:indexPath];
    CommentCell *commentCell = [tableView dequeueReusableCellWithIdentifier:@"CommentCell" forIndexPath:indexPath];
    CommentPostCell *commentPostCell = [tableView dequeueReusableCellWithIdentifier:@"CommentPostCell" forIndexPath:indexPath];
    
    if (indexPath.section == 0) {
        titleCommentCell.postAuthorNameLabel.text = [self.post.author description];
        titleCommentCell.postDateLabel.text = [self.post stringFromDateNumber:self.post.date];
        titleCommentCell.postTextLabel.text = self.post.text;
        titleCommentCell.postLikesLabel.text = [@(self.post.likesNumber) stringValue];
        titleCommentCell.postRepostsLabel.text = [@(self.post.repostsNumber) stringValue];
        titleCommentCell.postCommentsLabel.text = [@(self.post.commentsNumber) stringValue];
        
        NSURLRequest *request = [NSURLRequest requestWithURL:self.post.author.imageURL];
        __weak TitleCommentCell *weakCell = titleCommentCell;
        
        [weakCell.postAuthorUIImage setImageWithURLRequest:request
                                               placeholderImage:nil
                                                        success:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, UIImage * _Nonnull image) {
                                                            weakCell.postAuthorUIImage.image = image;
                                                            [weakCell layoutSubviews];
                                                        }
                                                        failure:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, NSError * _Nonnull error) {
                                                            
                                                        }];
        
        return weakCell;

    }
    if (indexPath.section == 1) {
        Comment *comment = [self.commentsArray objectAtIndex:indexPath.row];
        commentCell.commentLabel.text = comment.text;
        return commentCell;
    }
    if (indexPath.section == 2) {
        commentPostCell.post = self.post;
        return commentPostCell;
    }
    return titleCommentCell;
}


@end
