//
//  TitleWallCell.h
//  APIHW
//
//  Created by Kozaderov Ivan on 08/05/2019.
//  Copyright © 2019 n1ke71. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TitleWallCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *groupNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *groupDescriptionLabel;
@property (weak, nonatomic) IBOutlet UIImageView *groupImageView;

@end

NS_ASSUME_NONNULL_END
