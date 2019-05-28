//
//  MessageCell.m
//  APIHW
//
//  Created by Kozaderov Ivan on 13/05/2019.
//  Copyright © 2019 n1ke71. All rights reserved.
//

#import "MessageCell.h"
#import "ServerManager.h"
#import "User.h"
#import "Post.h"
@implementation MessageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)messageSendAction:(UIButton *)sender {
    
    if (![self.messageTextView.text isEqualToString:@""]) {
        [[ServerManager sharedManager]sendMessage:self.messageTextView.text toUser:self.post.fromID
                                        onSuccess:^(NSInteger comment_id) {
                                            
                                        } onFailure:^(NSError * _Nonnull error, NSInteger statusCode) {
                                            NSLog(@"error:%@ statusCode:%ld",[error localizedDescription],statusCode);
                                        }];
    }
}
@end
