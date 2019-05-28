//
//  Video.m
//  APIHW
//
//  Created by Kozaderov Ivan on 27/05/2019.
//  Copyright © 2019 n1ke71. All rights reserved.
//

#import "Video.h"

@implementation Video

- (id)initWithServerResponse:(NSDictionary *)responseObject
{
    self = [super initWithServerResponse:responseObject];
    if (self) {
        self.videoID = [[responseObject objectForKey:@"id"] integerValue];
        self.ownerID = [[responseObject objectForKey:@"owner_id"] integerValue];
        self.title = [responseObject objectForKey:@"title"];
        self.videoDescription = [responseObject objectForKey:@"description"];
        self.player = [responseObject objectForKey:@"player"];
    }
    return self;
}
@end
