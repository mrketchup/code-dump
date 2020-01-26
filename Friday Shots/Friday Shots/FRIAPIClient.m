//
//  FRIAPIClient.m
//  Friday Shots
//
//  Created by Matt Jones on 3/26/14.
//  Copyright (c) 2014 Mattjones. All rights reserved.
//

#import "FRIAPIClient.h"
#import <Mantle/Mantle.h>
#import "FRIPlayer.h"

@implementation FRIAPIClient

+ (id)alloc
{
	return [self sharedClient];
}

+ (instancetype)sharedClient
{
    static FRIAPIClient *client = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSURL *url = [NSURL URLWithString:@"http://samjones.pythonanywhere.com/api"];
        client = [[super alloc] initWithBaseURL:url];
        if (client)
        {
            
            AFJSONResponseSerializer *serializer = (AFJSONResponseSerializer *)client.responseSerializer;
            NSSet *contentTypes = serializer.acceptableContentTypes;
            serializer.acceptableContentTypes = [contentTypes setByAddingObject:@"text/html"];
        }
    });
    
    return client;
}

- (NSURLSessionDataTask *)getAllPlayersWithSuccess:(void (^)(NSArray *))success
                                           failure:(void (^)(NSError *))failure
{
    return [self GET:@"players" parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSMutableArray *players = [NSMutableArray new];
        for (NSDictionary *dict in responseObject)
        {
            [players addObject:[MTLJSONAdapter modelOfClass:[FRIPlayer class]
                                         fromJSONDictionary:dict
                                                      error:NULL]];
        }
        
        success(players);
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        if (failure)
        {
            failure(error);
        }
        
    }];
}

@end
