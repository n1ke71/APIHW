//
//  CommentPostCell.h
//  APIHW
//
//  Created by Kozaderov Ivan on 27/05/2019.
//  Copyright © 2019 n1ke71. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class User,Post;
@interface CommentPostCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UITextView *commentPostText;
- (IBAction)commentPostAction:(UIButton *)sender;
@property (strong, nonatomic)  User *user;
@property (strong, nonatomic)  Post *post;
@end

NS_ASSUME_NONNULL_END
