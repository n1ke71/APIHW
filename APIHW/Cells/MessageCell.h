//
//  MessageCell.h
//  APIHW
//
//  Created by Kozaderov Ivan on 13/05/2019.
//  Copyright © 2019 n1ke71. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class User,Post;
@interface MessageCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *messageImageView;
@property (weak, nonatomic) IBOutlet UILabel *messageNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *messageDescriptionLabel;
@property (weak, nonatomic) IBOutlet UITextView *messageTextView;
@property (strong, nonatomic)  User *user;
@property (strong, nonatomic)  Post *post;
- (IBAction)messageSendAction:(UIButton *)sender;

@end

NS_ASSUME_NONNULL_END
