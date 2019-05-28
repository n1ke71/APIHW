//
//  AccessToken.m
//  APIHW
//
//  Created by Kozaderov Ivan on 05/05/2019.
//  Copyright © 2019 n1ke71. All rights reserved.
//

#import "AccessToken.h"

@implementation AccessToken

static NSString *APIVersion = @"5.95";

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.version = APIVersion;
    }
    return self;
}
@end
