//
//  AccessToken.h
//  APIHW
//
//  Created by Kozaderov Ivan on 05/05/2019.
//  Copyright © 2019 n1ke71. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AccessToken : NSObject

@property (strong, nonatomic) NSString *token;
@property (strong, nonatomic) NSDate *expirationDate;
@property (strong, nonatomic) NSString *userID;
@property (strong, nonatomic) NSString *version;
@end

NS_ASSUME_NONNULL_END
