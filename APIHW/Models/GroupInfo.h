//
//  GroupInfo.h
//  APIHW
//
//  Created by Kozaderov Ivan on 12/05/2019.
//  Copyright © 2019 n1ke71. All rights reserved.
//

#import "ServerObject.h"

NS_ASSUME_NONNULL_BEGIN

@interface GroupInfo : ServerObject

@property (strong ,nonatomic) NSString *name;
@property (strong ,nonatomic) NSString *groupDescription;
@property (strong ,nonatomic) NSURL *imageURL;

@end

NS_ASSUME_NONNULL_END
