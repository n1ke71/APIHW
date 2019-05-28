//
//  User.h
//  APIHW
//
//  Created by Kozaderov Ivan on 05/05/2019.
//  Copyright © 2019 n1ke71. All rights reserved.
//

#import "ServerObject.h"

NS_ASSUME_NONNULL_BEGIN

@interface User : ServerObject

@property (strong ,nonatomic) NSString *firstName;
@property (strong ,nonatomic) NSString *lastName;
@property (strong ,nonatomic) NSString *city;
@property (strong ,nonatomic) NSString *country;
@property (strong ,nonatomic) NSURL *imageURL;

@end

NS_ASSUME_NONNULL_END
