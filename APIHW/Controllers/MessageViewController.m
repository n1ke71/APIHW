//
//  MessageViewController.m
//  APIHW
//
//  Created by Kozaderov Ivan on 13/05/2019.
//  Copyright © 2019 n1ke71. All rights reserved.
//

#import "MessageViewController.h"
#import "MessageCell.h"
#import "User.h"
#import "UIImageView+AFNetworking.h"

@interface MessageViewController ()

@end

@implementation MessageViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self.tableView registerClass:[MessageCell class] forCellReuseIdentifier:@"MessageCell"];
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"Message";
    self.navigationController.navigationBar.prefersLargeTitles = YES;
    self.tableView.estimatedRowHeight = 44.f;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MessageCell *messageCell = [tableView dequeueReusableCellWithIdentifier:@"MessageCell" forIndexPath:indexPath];
    messageCell.user = self.user;
    messageCell.post = self.post;
    messageCell.messageNameLabel.text = [self.user description];
    messageCell.messageImageView.image = [self downloadImageWithURL:self.user.imageURL];
    messageCell.messageDescriptionLabel.text = [NSString stringWithFormat:@"%@,%@",self.user.city,self.user.country];
    return messageCell;
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
