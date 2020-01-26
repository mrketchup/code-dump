//
//  Game.m
//  DrawingGame
//
//  Created by Matt Jones on 5/23/13.
//  Copyright (c) 2013 Jones Brothers. All rights reserved.
//

#import "Game.h"

@implementation Game

- (NSMutableArray *)players {
    if (!_players) {
        _players = [[NSMutableArray alloc] init];
    }
    return _players;
}

- (NSMutableArray *)playersReady {
    if (!_playersReady) {
        _playersReady = [[NSMutableArray alloc] init];
    }
    return _playersReady;
}

- (id)initWithGameID:(NSUInteger)gameID round:(NSInteger)round {
    self = [super init];
    if (self) {
        _gameID = gameID;
        _round = round;
    }
    return self;
}

@end
