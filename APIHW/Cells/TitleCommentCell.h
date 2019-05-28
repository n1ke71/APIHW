//
//  TitleCommentCell.h
//  APIHW
//
//  Created by Kozaderov Ivan on 22/05/2019.
//  Copyright © 2019 n1ke71. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TitleCommentCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *postAuthorUIImage;
@property (weak, nonatomic) IBOutlet UILabel *postAuthorNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *postDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *postTextLabel;
@property (weak, nonatomic) IBOutlet UILabel *postLikesLabel;
@property (weak, nonatomic) IBOutlet UILabel *postCommentsLabel;
@property (weak, nonatomic) IBOutlet UILabel *postRepostsLabel;
@property (assign, nonatomic)BOOL isLike;
- (IBAction)postLikeAction:(UIButton *)sender;

@end

NS_ASSUME_NONNULL_END
