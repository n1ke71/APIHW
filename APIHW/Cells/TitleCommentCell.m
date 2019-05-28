//
//  TitleCommentCell.m
//  APIHW
//
//  Created by Kozaderov Ivan on 22/05/2019.
//  Copyright © 2019 n1ke71. All rights reserved.
//

#import "TitleCommentCell.h"

@implementation TitleCommentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.isLike = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)postLikeAction:(UIButton *)sender {
    
    
    if (self.isLike) {
        [sender setImage:[UIImage imageNamed:@"redLike.png"] forState:UIControlStateNormal];
        self.isLike = NO;
    } else {
       [sender setImage:[UIImage imageNamed:@"like.png"] forState:UIControlStateNormal];
        self.isLike = YES;
    }
    
    
}
@end
