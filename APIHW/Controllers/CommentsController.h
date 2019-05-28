//
//  CommentsController.h
//  APIHW
//
//  Created by Kozaderov Ivan on 22/05/2019.
//  Copyright © 2019 n1ke71. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class Post;
@interface CommentsController : UITableViewController
@property (strong ,nonatomic) Post *post;
@end

NS_ASSUME_NONNULL_END
