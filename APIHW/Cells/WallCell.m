//
//  WallCell.m
//  APIHW
//
//  Created by Kozaderov Ivan on 06/05/2019.
//  Copyright © 2019 n1ke71. All rights reserved.
//

#import "WallCell.h"

@implementation WallCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
}

- (IBAction)authorAction:(UIButton *)sender {
    
    [self.delegate didSelectPostAndAuthor:self.post];
    
}
@end
