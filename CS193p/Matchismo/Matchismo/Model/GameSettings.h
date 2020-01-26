//
//  GameSettings.h
//  Matchismo
//
//  Created by Matt Jones on 5/9/13.
//  Copyright (c) 2013 Mattjones. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GameSettings : NSObject

+ (NSInteger)matchBonus;
+ (NSInteger)mismatchPenalty;
+ (NSInteger)flipCost;
+ (void)setMatchBonus:(NSInteger)matchBonus;
+ (void)setMismatchPenalty:(NSInteger)mismatchPenalty;
+ (void)setFlipCost:(NSInteger)flipCost;

@end
