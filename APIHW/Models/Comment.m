//
//  Comment.m
//  APIHW
//
//  Created by Kozaderov Ivan on 24/05/2019.
//  Copyright © 2019 n1ke71. All rights reserved.
//

#import "Comment.h"

@implementation Comment

- (id)initWithServerResponse:(NSDictionary *)responseObject
{
    self = [super initWithServerResponse:responseObject];
    if (self) {
        self.commentID = [[responseObject objectForKey:@"id"] integerValue];
        self.fromID = [[responseObject objectForKey:@"from_id"] integerValue];
        self.date = [[responseObject objectForKey:@"date"] integerValue];
        self.text = [responseObject objectForKey:@"text"];
    }
    return self;
}
@end
