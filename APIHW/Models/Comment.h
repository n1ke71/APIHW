//
//  Comment.h
//  APIHW
//
//  Created by Kozaderov Ivan on 24/05/2019.
//  Copyright © 2019 n1ke71. All rights reserved.
//

#import "ServerObject.h"

NS_ASSUME_NONNULL_BEGIN

@interface Comment : ServerObject
@property (assign, nonatomic) NSInteger commentID;
@property (assign, nonatomic) NSInteger fromID;
@property (assign ,nonatomic) NSInteger date;
@property (strong, nonatomic) NSString *text;
@end

NS_ASSUME_NONNULL_END
