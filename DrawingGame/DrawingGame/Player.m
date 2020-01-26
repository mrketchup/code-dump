//
//  Player.m
//  DrawingGame
//
//  Created by Matt Jones on 5/23/13.
//  Copyright (c) 2013 Jones Brothers. All rights reserved.
//

#import "Player.h"

@implementation Player

- (id)initWithEmail:(NSString *)email username:(NSString *)username {
    self = [super init];
    if (self) {
        _email = email;
        _username = username;
    }
    return self;
}

@end
