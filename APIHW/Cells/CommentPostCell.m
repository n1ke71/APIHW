//
//  CommentPostCell.m
//  APIHW
//
//  Created by Kozaderov Ivan on 27/05/2019.
//  Copyright © 2019 n1ke71. All rights reserved.
//

#import "CommentPostCell.h"
#import "ServerManager.h"
#import "User.h"
#import "Post.h"

@implementation CommentPostCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)commentPostAction:(UIButton *)sender {
    
    if (![self.commentPostText.text isEqualToString:@""]) {
        
        [[ServerManager sharedManager]postCommentText:self.commentPostText.text
                                          onGroupWall:@"-58860049" toPost:self.post.postID onSuccess:^(long comment_id) {
                                              
                                          } onFailure:^(NSError * _Nonnull error, NSInteger statusCode) {
                                              NSLog(@"error:%@ statusCode:%ld",[error localizedDescription],statusCode);
                                          }];
        
    }
    
}
@end
