//
//  ServerManager.m
//  APIHW
//
//  Created by Kozaderov Ivan on 05/05/2019.
//  Copyright © 2019 n1ke71. All rights reserved.
//

#import "ServerManager.h"
#import "AFNetworking.h"
#import "AccessToken.h"
#import "User.h"
#import "Post.h"
#import "GroupInfo.h"
#import "Comment.h"
#import "Video.h"

@implementation ServerManager

#pragma mark - SessionManager

const NSString *userID = @"XXXXX";

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSURL *baseURL = [NSURL URLWithString:@"https://api.vk.com/method/"];
        self.sessionManager = [[AFHTTPSessionManager alloc]initWithBaseURL:baseURL];
    }
    return self;
}

#pragma mark - ServerManager

+ (ServerManager *) sharedManager {
    static ServerManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[ServerManager alloc]init];
    });
    return manager;
}

#pragma mark - API

- (void) getFriendsWithOffset:(NSInteger)offset
                        count:(NSInteger)count
                    onSuccess:(void(^)(NSArray *friends)) success
                    onFailure:(void(^)(NSError *error, NSInteger statusCode)) failure {

    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                                userID,@"user_id",
                                @"name" ,@"order",
                                @(count),@"count",
                                @(offset),@"offset",
                                @"photo_50,city,country",@"fields",
                                @"nom",@"name_case",
                                self.accessToken.token ,@"access_token",
                                self.accessToken.version,@"v"
                                , nil];
    
    [self.sessionManager GET:@"friends.get"
                  parameters:parameters
                    progress:nil
                     success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                         //NSLog(@"%@",responseObject);
                         NSDictionary *dicts = [responseObject objectForKey:@"response"];
                         NSArray *items = [dicts objectForKey:@"items"];
                         NSMutableArray *objectsArray = [NSMutableArray array];
                         
                         for (NSDictionary *dict in items) {
                             User *user = [[User alloc]initWithServerResponse:dict];
                             [objectsArray addObject:user];
                         }
                         if (success) {
                             success(objectsArray);
                         }
                     }
                     failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                         NSLog(@"Error: %@",error);
                         if (failure) {
                             
                             NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)task.response;
                             NSInteger statusCode = httpResponse.statusCode;
                             failure(error,statusCode);
                         }
                     }];

}

- (void) getGroupWall:(NSString *)groupID
           withOffset:(NSInteger)offset
                count:(NSInteger)count
            onSuccess:(void(^)(NSArray *posts)) success
            onFailure:(void(^)(NSError *error, NSInteger statusCode)) failure {
    
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                                groupID ,@"owner_id",
                                @"https://vk.com/", @"domain",
                                @(count), @"count",
                                @(offset), @"offset",
                                @"all", @"filter",
                                @(0), @"extended",
                                @"about",@"fields",
                                self.accessToken.token, @"access_token",
                                self.accessToken.version, @"v" ,nil];
    
    if (![groupID hasPrefix:@"-"]) { //58860049
        groupID = [@"-" stringByAppendingString:groupID];
    }
    
    [self.sessionManager GET:@"wall.get"
                  parameters:parameters
                    progress:^(NSProgress * _Nonnull downloadProgress) {
                        
                    }
                     success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                         // NSLog(@"%@",responseObject);
                         NSDictionary *dicts = [responseObject objectForKey:@"response"];
                         NSArray *items = [dicts objectForKey:@"items"];
                         NSMutableArray *objectsArray = [NSMutableArray array];
                         
                         for (NSDictionary *dict in items) {
                             Post *post = [[Post alloc]initWithServerResponse:dict];
                             [objectsArray addObject:post];
                         }
                         if (success) {
                             success(objectsArray);
                         }
                     }
                     failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                         NSLog(@"Error: %@",error);
                         if (failure) {
                             
                             NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)task.response;
                             NSInteger statusCode = httpResponse.statusCode;
                             failure(error,statusCode);
                         }
                     }];
    
}

- (void) getUserWithID:(NSInteger)identifier
             onSuccess:(void(^)(User *user)) success
             onFailure:(void(^)(NSError *error, NSInteger statusCode)) failure {
    
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                                @(identifier),@"user_id",
                                @"first_name,photo_50,last_name,city,country",@"fields",
                                @"nom",@"name_case",
                                self.accessToken.token ,@"access_token",
                                self.accessToken.version,@"v"
                                , nil];
    
    [self.sessionManager GET:@"users.get"
                  parameters:parameters
                    progress:^(NSProgress * _Nonnull downloadProgress) {
                        
                    }
                     success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                         //NSLog(@"%@",responseObject);
                         NSArray *array = [responseObject objectForKey:@"response"];
                         NSDictionary *dict = nil;
                         User *user = nil;
                         if ([array count] > 0) {
                             dict = [array firstObject];
                             user = [[User alloc]initWithServerResponse:dict];
                         }

                         if (success) {
                             success(user);
                         }
                     }
                     failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                         NSLog(@"Error: %@",error);
                         if (failure) {
                             
                             NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)task.response;
                             NSInteger statusCode = httpResponse.statusCode;
                             failure(error,statusCode);
                         }
                     }];
}

- (void) getGroupInfo:(NSString *)groupID
            onSuccess:(void(^)(GroupInfo *groupInfo)) success
            onFailure:(void(^)(NSError *error, NSInteger statusCode)) failure {
    
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                                @"iosdevcourse,-58860049" ,@"group_ids",
                                groupID ,@"group_id",
                                @"name,description,photo_100",@"fields",
                                self.accessToken.token, @"access_token",
                                self.accessToken.version, @"v" ,nil];
    
    if (![groupID hasPrefix:@"-"]) { //58860049
        groupID = [@"-" stringByAppendingString:groupID];
    }
    
    [self.sessionManager GET:@"groups.getById"
                  parameters:parameters
                    progress:nil
                     success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                         //NSLog(@"%@",responseObject);
                         NSArray *groups = [responseObject objectForKey:@"response"];
                         GroupInfo *groupInfo = nil;
                         for (NSDictionary *dict in groups) {
                             groupInfo = [[GroupInfo alloc]initWithServerResponse:dict];
                         }
                         
                         if (success) {
                             success(groupInfo);
                         }
                     }
                     failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                         NSLog(@"Error: %@",error);
                         if (failure) {
                             
                             NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)task.response;
                             NSInteger statusCode = httpResponse.statusCode;
                             failure(error,statusCode);
                         }
                     }];
    
}

- (void) sendMessage:(NSString *) messageText
             toUser:(NSInteger ) userId
               onSuccess:(void(^)(NSInteger comment_id)) success
               onFailure:(void(^)(NSError *error, NSInteger statusCode)) failure {
    
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                                @(userId) ,@"user_id",
                                messageText,@"message",
                                self.accessToken.token, @"access_token",
                                self.accessToken.version, @"v" ,nil];
    
    [self.sessionManager POST:@"messages.send"
                   parameters:parameters
                     progress:nil
                      success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                            NSLog(@"%@",responseObject);
                    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

- (void) getCommentsFromWall:(NSString *)groupID
                      postID:(NSInteger )postID
                  withOffset:(NSInteger)offset
                       count:(NSInteger)count
                   onSuccess:(void(^)(NSArray *comments)) success
                   onFailure:(void(^)(NSError *error, NSInteger statusCode)) failure {
    
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                                groupID ,@"owner_id",
                                @(postID),@"post_id",
                                @(1),@"need_likes",
                                @"",@"start_comment_id",
                                @(offset), @"offset",
                                @(count), @"count",
                                @"desc",@"sort",
                                @(0),@"preview_length",
                                @(1),@"extended",
                                @"",@"fields",
                                @"",@"comment_id",
                                @"10",@"thread_items_count",
                                self.accessToken.token, @"access_token",
                                self.accessToken.version, @"v" ,nil];
    
    if (![groupID hasPrefix:@"-"]) { //58860049
        groupID = [@"-" stringByAppendingString:groupID];
    }
    
    [self.sessionManager GET:@"wall.getComments"
                  parameters:parameters
                    progress:nil
                     success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                         //NSLog(@"%@",responseObject);
                         NSDictionary *dicts = [responseObject objectForKey:@"response"];
                         NSArray *items = [dicts objectForKey:@"items"];
                         NSMutableArray *objectsArray = [NSMutableArray array];
                         
                         for (NSDictionary *dict in items) {
                             Comment *comment = [[Comment alloc]initWithServerResponse:dict];
                             [objectsArray addObject:comment];
                         }
                         if (success) {
                             success(objectsArray);
                         }
                     }
                     failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                         NSLog(@"Error: %@",error);
                         if (failure) {
                             
                             NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)task.response;
                             NSInteger statusCode = httpResponse.statusCode;
                             failure(error,statusCode);
                         }
                     }];
    
}


- (void) postCommentText:(NSString *) text
             onGroupWall:(NSString *) groupID
                  toPost:(NSInteger ) postID
               onSuccess:(void(^)(NSInteger comment_id)) success
               onFailure:(void(^)(NSError *error, NSInteger statusCode)) failure {
    
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                                groupID ,@"owner_id",
                                @(postID),@"post_id",
                                text,@"message",
                                self.accessToken.token, @"access_token",
                                self.accessToken.version, @"v" ,nil];
    
    if (![groupID hasPrefix:@"-"]) { //58860049
        groupID = [@"-" stringByAppendingString:groupID];
    }
    
    [self.sessionManager POST:@"wall.createComment"
                   parameters:parameters
                     progress:nil
                      success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                          
                          //NSLog(@"%@",responseObject);
                          NSDictionary *dictionary = [responseObject objectForKey:@"response"];
                          NSInteger commentId = [[dictionary objectForKey:@"comment_id"] integerValue];
                          if (success) {
                              success(commentId);
                          }
                      }
                      failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                          
                          NSLog(@"Error: %@",error);
                          if (failure) {
                              
                              NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)task.response;
                              NSInteger statusCode = httpResponse.statusCode;
                              failure(error,statusCode);
                              
                          }
                      }];
    
}

- (void) getVideosFromWall:(NSString *)groupID
                  withOffset:(NSInteger)offset
                       count:(NSInteger)count
                   onSuccess:(void(^)(NSArray *videos)) success
                   onFailure:(void(^)(NSError *error, NSInteger statusCode)) failure {
    
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                                groupID ,@"owner_id",
                                @"",@"videos",
                                @"",@"album_id",
                                @(offset), @"offset",
                                @(count), @"count",
                                @(1),@"extended",
                                self.accessToken.token, @"access_token",
                                self.accessToken.version, @"v" ,nil];
    
    if (![groupID hasPrefix:@"-"]) { //58860049
        groupID = [@"-" stringByAppendingString:groupID];
    }
    
    [self.sessionManager GET:@"video.get"
                  parameters:parameters
                    progress:nil
                     success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                         //NSLog(@"%@",responseObject);
                         NSDictionary *dicts = [responseObject objectForKey:@"response"];
                         NSArray *items = [dicts objectForKey:@"items"];
                         NSMutableArray *objectsArray = [NSMutableArray array];
                         
                         for (NSDictionary *dict in items) {
                             Video *video = [[Video alloc]initWithServerResponse:dict];
                             [objectsArray addObject:video];
                         }
                         if (success) {
                             success(objectsArray);
                         }
                     }
                     failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                         NSLog(@"Error: %@",error);
                         if (failure) {
                             
                             NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)task.response;
                             NSInteger statusCode = httpResponse.statusCode;
                             failure(error,statusCode);
                         }
                     }];
    
}

@end
