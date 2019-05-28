//
//  User.m
//  APIHW
//
//  Created by Kozaderov Ivan on 05/05/2019.
//  Copyright © 2019 n1ke71. All rights reserved.
//

#import "User.h"

@implementation User

- (id)initWithServerResponse:(NSDictionary *)responseObject
{
    self = [super initWithServerResponse:responseObject];
    if (self) {
        self.firstName = [responseObject objectForKey:@"first_name"];
        self.lastName = [responseObject objectForKey:@"last_name"];
        NSDictionary *city = [responseObject objectForKey:@"city"];
        self.city = [city objectForKey:@"title"];
        NSDictionary *country = [responseObject objectForKey:@"country"];
        self.country = [country objectForKey:@"title"];
        NSString *urlString = [responseObject objectForKey:@"photo_50"];
        if (urlString) {
            self.imageURL = [NSURL URLWithString:urlString];
        }
    }
    return self;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"%@ %@", self.firstName,self.lastName];
}

@end
