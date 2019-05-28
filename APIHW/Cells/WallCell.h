//
//  WallCell.h
//  APIHW
//
//  Created by Kozaderov Ivan on 06/05/2019.
//  Copyright © 2019 n1ke71. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class Post;
@protocol WallCellDelegate;

@interface WallCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *authorButton;
@property (weak, nonatomic) IBOutlet UILabel *authorNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *postLabel;
@property (weak, nonatomic) IBOutlet UIButton *likeButton;
@property (weak, nonatomic) IBOutlet UIButton *commentButton;
@property (weak, nonatomic) IBOutlet UIButton *repostButton;
@property (weak, nonatomic) IBOutlet UILabel *likeLabel;
@property (weak, nonatomic) IBOutlet UILabel *commentLabel;
@property (weak, nonatomic) IBOutlet UILabel *repostLabel;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loadingIndicator;
@property (strong ,nonatomic) Post *post;
@property (weak,nonatomic) id <WallCellDelegate> delegate;

- (IBAction)authorAction:(UIButton *)sender;

@end
#pragma mark - WallCellDelegate
@protocol WallCellDelegate <NSObject>
- (void) didSelectPostAndAuthor:(Post *)post ;
@end

NS_ASSUME_NONNULL_END
