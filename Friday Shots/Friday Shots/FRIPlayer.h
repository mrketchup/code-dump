//
//  FRIPlayer.h
//  Friday Shots
//
//  Created by Matt Jones on 3/26/14.
//  Copyright (c) 2014 Mattjones. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface FRIPlayer : MTLModel <MTLJSONSerializing>

@property (nonatomic, strong, readonly) NSNumber *playerID;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSNumber *height;
@property (nonatomic, strong) NSNumber *weight;
@property (nonatomic, strong, readonly) NSArray *shotIDs;
@property (nonatomic, strong, readonly) NSNumber *hits;
@property (nonatomic, strong, readonly) NSNumber *accuracy;
@property (nonatomic, strong, readonly) NSNumber *totalWinnings;

@end
