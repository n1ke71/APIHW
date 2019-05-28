//
//  Post.h
//  APIHW
//
//  Created by Kozaderov Ivan on 06/05/2019.
//  Copyright © 2019 n1ke71. All rights reserved.
//

#import "ServerObject.h"

NS_ASSUME_NONNULL_BEGIN
@class User;
@interface Post : ServerObject

@property (assign, nonatomic) NSInteger postID;
@property (assign, nonatomic) NSInteger fromID;
@property (assign ,nonatomic) NSInteger date;
@property (strong, nonatomic) NSString *text;
@property (assign ,nonatomic) NSInteger commentsNumber;
@property (assign ,nonatomic) NSInteger likesNumber;
@property (assign ,nonatomic) NSInteger repostsNumber;
@property (strong, nonatomic) NSMutableArray *attachments;
@property (strong, nonatomic) User *author;
- (NSString *) stringFromDateNumber:(NSInteger) number;
@end

NS_ASSUME_NONNULL_END
