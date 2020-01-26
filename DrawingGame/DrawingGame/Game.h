//
//  Game.h
//  DrawingGame
//
//  Created by Matt Jones on 5/23/13.
//  Copyright (c) 2013 Jones Brothers. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Game : NSObject

@property (nonatomic, readonly) NSUInteger gameID;
@property (nonatomic, strong) NSMutableArray *players;
@property (nonatomic, readonly) NSInteger round;
@property (nonatomic, strong) NSMutableArray *playersReady;

- (id)initWithGameID:(NSUInteger)gameID round:(NSInteger)round;

@end
