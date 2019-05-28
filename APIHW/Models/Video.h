//
//  Video.h
//  APIHW
//
//  Created by Kozaderov Ivan on 27/05/2019.
//  Copyright © 2019 n1ke71. All rights reserved.
//

#import "ServerObject.h"

NS_ASSUME_NONNULL_BEGIN

@interface Video : ServerObject
@property (assign, nonatomic) NSInteger videoID;
@property (assign, nonatomic) NSInteger ownerID;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *videoDescription;
@property (strong, nonatomic) NSString *player;

@end

NS_ASSUME_NONNULL_END
