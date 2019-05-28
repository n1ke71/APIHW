//
//  ServerObject.h
//  APIHW
//
//  Created by Kozaderov Ivan on 05/05/2019.
//  Copyright © 2019 n1ke71. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ServerObject : NSObject

- (id)initWithServerResponse:(NSDictionary *)responseObject;

@end

NS_ASSUME_NONNULL_END
