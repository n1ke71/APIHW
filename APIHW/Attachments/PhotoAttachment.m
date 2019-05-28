//
//  PhotoAttachment.m
//  APIHW
//
//  Created by Kozaderov Ivan on 06/05/2019.
//  Copyright © 2019 n1ke71. All rights reserved.
//

#import "PhotoAttachment.h"

@implementation PhotoAttachment

- (id)initWithServerResponse:(NSDictionary *)responseObject
{
    self = [super initWithServerResponse:responseObject];
    if (self) {
        self.objectID = [[responseObject objectForKey:@"id"] integerValue];
        self.ownerID = [[responseObject objectForKey:@"owner_id"] integerValue];
        self.sizes = [NSArray arrayWithArray:[responseObject objectForKey:@"sizes"]];
        for (NSDictionary *dictionary in self.sizes) {
            NSString *photoType = [dictionary objectForKey:@"type"];
            if ([photoType isEqualToString:@"w"]) {
                NSString *urlString = [dictionary objectForKey:@"url"];;
                if (urlString) {
                    self.imageURL = [NSURL URLWithString:urlString];
                }
            }
        }
        
    }
    return self;
}
@end
