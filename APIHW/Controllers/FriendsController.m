//
//  FriendsController.m
//  APIHW
//
//  Created by Kozaderov Ivan on 05/05/2019.
//  Copyright © 2019 n1ke71. All rights reserved.
//

#import "FriendsController.h"
#import "ServerManager.h"
#import "User.h"
#import "UIImageView+AFNetworking.h"
#import "FriendsCell.h"

@interface FriendsController ()
@property (strong ,nonatomic) NSMutableArray *friendsArray;
@end

@implementation FriendsController

static NSInteger friendsInRequest = 10;

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self.tableView registerClass:[FriendsCell class] forCellReuseIdentifier:@"FriendsCell"];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.prefersLargeTitles = YES;
    self.friendsArray = [NSMutableArray array];
    [self getFriendsFromServer];
}

#pragma mark - API

- (void) getFriendsFromServer {
    
    [[ServerManager sharedManager]
     getFriendsWithOffset:[self.friendsArray count]
     count:friendsInRequest
     onSuccess:^(NSArray * _Nonnull friends) {
         
         [self.friendsArray addObjectsFromArray:friends];
         
         NSMutableArray *newPaths = [NSMutableArray array];
         for (int i = (int)[self.friendsArray count] - (int)[friends count]; i < [self.friendsArray count] ; i++) {
             [newPaths addObject:[NSIndexPath indexPathForRow:i inSection:0]];
         }
         [self.tableView beginUpdates];
         [self.tableView insertRowsAtIndexPaths:newPaths withRowAnimation:UITableViewRowAnimationTop];
         [self.tableView endUpdates];
     }
     onFailure:^(NSError * _Nonnull error, NSInteger statusCode) {
         NSLog(@"error:%@ statusCode:%ld",[error localizedDescription],statusCode);
     }];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.friendsArray count] + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    FriendsCell *friendsCell = [tableView dequeueReusableCellWithIdentifier:@"FriendsCell"];

    if (indexPath.row == [self.friendsArray count]) {
        cell.textLabel.text = @"LOAD MORE";
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.imageView.image = nil;
    } else{
        User *friend = [self.friendsArray objectAtIndex:indexPath.row];
        friendsCell.friendNameLabel.text = [NSString stringWithFormat:@"%@ %@",friend.firstName,friend.lastName];
        
        NSURLRequest *request = [NSURLRequest requestWithURL:friend.imageURL];
        __weak FriendsCell *weakCell = friendsCell;
        
        weakCell.friendImageView.image = nil;
        
        [weakCell.friendImageView setImageWithURLRequest:request
                              placeholderImage:nil
                                       success:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, UIImage * _Nonnull image) {
                                           weakCell.friendImageView.layer.cornerRadius = 15.f;
                                           weakCell.friendImageView.image = image;
                                           [weakCell layoutSubviews];
                                       }
                                       failure:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, NSError * _Nonnull error) {
                                           
                                       }];
        return weakCell;
    }
    
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == [self.friendsArray count]) {
        [self getFriendsFromServer];
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
@end
