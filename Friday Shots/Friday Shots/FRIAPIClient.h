//
//  FRIAPIClient.h
//  Friday Shots
//
//  Created by Matt Jones on 3/26/14.
//  Copyright (c) 2014 Mattjones. All rights reserved.
//

#import "AFHTTPSessionManager.h"

@interface FRIAPIClient : AFHTTPSessionManager

+ (instancetype)sharedClient;

- (NSURLSessionDataTask *)getAllPlayersWithSuccess:(void (^)(NSArray *players))success
                                           failure:(void (^)(NSError *error))failure;

@end
