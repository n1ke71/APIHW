//
//  PostedPhotoAttachment.h
//  APIHW
//
//  Created by Kozaderov Ivan on 06/05/2019.
//  Copyright © 2019 n1ke71. All rights reserved.
//

#import "Attachment.h"

NS_ASSUME_NONNULL_BEGIN

@interface PostedPhotoAttachment : Attachment
@property (strong, nonatomic) NSArray *sizes;
@property (strong, nonatomic) NSURL *imageURL;
@property (strong ,nonatomic) NSURL *photo130;
@property (strong ,nonatomic) NSURL *photo604;
@end

NS_ASSUME_NONNULL_END
