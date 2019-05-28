//
//  Post.m
//  APIHW
//
//  Created by Kozaderov Ivan on 06/05/2019.
//  Copyright © 2019 n1ke71. All rights reserved.
//

#import "Post.h"
#import "PhotoAttachment.h"
#import "PostedPhotoAttachment.h"

@implementation Post

- (id)initWithServerResponse:(NSDictionary *)responseObject
{
    self = [super initWithServerResponse:responseObject];
    if (self) {
        self.postID = [[responseObject objectForKey:@"id"] integerValue];
        self.fromID = [[responseObject objectForKey:@"from_id"] integerValue];
        self.date = [[responseObject objectForKey:@"date"] integerValue];
        self.text = [responseObject objectForKey:@"text"];
        self.text = [self.text stringByReplacingOccurrencesOfString:@"<br>" withString:@"\n"];
        self.attachments = [NSMutableArray array];
        NSArray *attachments = [responseObject objectForKey:@"attachments"];
        
        for (NSDictionary *dict in attachments) {
            NSString *type = [dict objectForKey:@"type"];
            if ([type isEqualToString:@"photo"]) {
                PhotoAttachment *photoAttachment = [[PhotoAttachment alloc] initWithServerResponse:[dict objectForKey:@"photo"]];
                [self.attachments addObject:photoAttachment];
                
            } else if ([type isEqualToString:@"posted_photo"]) {
                PostedPhotoAttachment *postedPhotoAttachment = [[PostedPhotoAttachment alloc] initWithServerResponse:[dict objectForKey:@"posted_photo"]];
                [self.attachments addObject:postedPhotoAttachment];
                
            } else if ([type isEqualToString:@"video"]) {
                
            } else if ([type isEqualToString:@"audio"]) {
                
            } else if ([type isEqualToString:@"doc"]) {
                
            }
        }
        
        NSDictionary *comments = [responseObject objectForKey:@"comments"];
        self.commentsNumber = [[comments objectForKey:@"count"] integerValue];
        NSDictionary *likes = [responseObject objectForKey:@"likes"];
        self.likesNumber = [[likes objectForKey:@"count"] integerValue];
        NSDictionary *reposts= [responseObject objectForKey:@"reposts"];
        self.repostsNumber = [[reposts objectForKey:@"count"] integerValue];
        
    }
    return self;
}

- (NSString *) stringFromDateNumber:(NSInteger) number {
    NSDate *postDate = [NSDate dateWithTimeIntervalSince1970:number];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"dd/MM/YYYY"];
    NSString *dateString = [formatter stringFromDate:postDate];
    return dateString;
}
@end
