//
//  PhotoAttachment.h
//  APIHW
//
//  Created by Kozaderov Ivan on 06/05/2019.
//  Copyright © 2019 n1ke71. All rights reserved.
//

#import "Attachment.h"

NS_ASSUME_NONNULL_BEGIN

@interface PhotoAttachment : Attachment

@property (strong, nonatomic) NSArray *sizes;
@property (strong, nonatomic) NSURL *imageURL;

@end

NS_ASSUME_NONNULL_END
