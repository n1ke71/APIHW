//
//  ServerManager.h
//  APIHW
//
//  Created by Kozaderov Ivan on 05/05/2019.
//  Copyright © 2019 n1ke71. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class AFHTTPSessionManager;
@class AccessToken;
@class User;
@class GroupInfo;
@interface ServerManager : NSObject

@property (strong, nonatomic)AFHTTPSessionManager *sessionManager;
@property (strong, nonatomic)AccessToken *accessToken;

+ (ServerManager *) sharedManager;

- (void) getFriendsWithOffset:(NSInteger)offset
                        count:(NSInteger)count
                    onSuccess:(void(^)(NSArray *friends)) success
                    onFailure:(void(^)(NSError *error, NSInteger statusCode)) failure;

- (void) getGroupWall:(NSString *)groupID
           withOffset:(NSInteger)offset
                count:(NSInteger)count
            onSuccess:(void(^)(NSArray *friends)) success
            onFailure:(void(^)(NSError *error, NSInteger statusCode)) failure;

- (void) getUserWithID:(NSInteger)identifier
             onSuccess:(void(^)(User *user)) success
             onFailure:(void(^)(NSError *error, NSInteger statusCode)) failure;

- (void) getGroupInfo:(NSString *)groupID
            onSuccess:(void(^)(GroupInfo *groupInfo)) success
            onFailure:(void(^)(NSError *error, NSInteger statusCode)) failure;

- (void) sendMessage:(NSString *) messageText
              toUser:(NSInteger ) userId
           onSuccess:(void(^)(NSInteger comment_id)) success
           onFailure:(void(^)(NSError *error, NSInteger statusCode)) failure;

- (void) getCommentsFromWall:(NSString *)groupID
                      postID:(NSInteger )postID
                  withOffset:(NSInteger)offset
                       count:(NSInteger)count
                   onSuccess:(void(^)(NSArray *comments)) success
                   onFailure:(void(^)(NSError *error, NSInteger statusCode)) failure;

- (void) postCommentText:(NSString *) text
             onGroupWall:(NSString *) groupID
                  toPost:(NSInteger ) postID
               onSuccess:(void(^)(long comment_id)) success
               onFailure:(void(^)(NSError *error, NSInteger statusCode)) failure;

- (void) getVideosFromWall:(NSString *)groupID
                withOffset:(NSInteger)offset
                     count:(NSInteger)count
                 onSuccess:(void(^)(NSArray *videos)) success
                 onFailure:(void(^)(NSError *error, NSInteger statusCode)) failure;
@end

NS_ASSUME_NONNULL_END
