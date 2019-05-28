//
//  GroupInfo.m
//  APIHW
//
//  Created by Kozaderov Ivan on 12/05/2019.
//  Copyright © 2019 n1ke71. All rights reserved.
//

#import "GroupInfo.h"

@implementation GroupInfo

- (id)initWithServerResponse:(NSDictionary *)responseObject
{
    self = [super initWithServerResponse:responseObject];
    if (self) {
        
        self.name = [responseObject objectForKey:@"name"];
        self.groupDescription = [responseObject objectForKey:@"description"];
        NSString *urlString = [responseObject objectForKey:@"photo_100"];
        if (urlString) {
            self.imageURL = [NSURL URLWithString:urlString];
        }
    }
    return self;
}
@end
