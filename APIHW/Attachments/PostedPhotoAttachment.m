//
//  PostedPhotoAttachment.m
//  APIHW
//
//  Created by Kozaderov Ivan on 06/05/2019.
//  Copyright © 2019 n1ke71. All rights reserved.
//

#import "PostedPhotoAttachment.h"

@implementation PostedPhotoAttachment

- (id)initWithServerResponse:(NSDictionary *)responseObject
{
    self = [super initWithServerResponse:responseObject];
    if (self) {
        self.objectID = [[responseObject objectForKey:@"id"] integerValue];
        self.ownerID = [[responseObject objectForKey:@"owner_id"] integerValue];
        NSString *urlString = [responseObject objectForKey:@"photo_604"];
        if (urlString) {
            self.photo604 = [NSURL URLWithString:urlString];
        }
    }
    return self;
}
@end
