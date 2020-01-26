//
//  GameSettings.m
//  Matchismo
//
//  Created by Matt Jones on 5/9/13.
//  Copyright (c) 2013 Mattjones. All rights reserved.
//

#import "GameSettings.h"

@implementation GameSettings

#define GAME_SETTINGS @"game_settings"
#define MATCHBONUS @"match_bonus"
#define MISMATCHPENALTY @"mismatch_penalty"
#define FLIPCOST @"flip_cost"

+ (NSDictionary *)gameSettings {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults dictionaryForKey:GAME_SETTINGS];
}

+ (int)getIntForKey:(NSString *)key withDefaultInt:(int)defaultValue {
    NSDictionary *settings = [GameSettings gameSettings];
    if (!settings) return defaultValue;
    if (![[settings allKeys] containsObject:key]) return defaultValue;
    return [settings[key] intValue];
}

+ (void)setInt:(int)value forKey:(NSString *)key {
    NSMutableDictionary *settings = [[GameSettings gameSettings] mutableCopy];
    if (!settings) {
        settings = [[NSMutableDictionary alloc] init];
    }
    settings[key] = @(value);
    [[NSUserDefaults standardUserDefaults] setObject:settings
                                              forKey:GAME_SETTINGS];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (NSInteger)matchBonus {
    return [GameSettings getIntForKey:MATCHBONUS withDefaultInt:4];
}

+ (NSInteger)mismatchPenalty {
    return [GameSettings getIntForKey:MISMATCHPENALTY withDefaultInt:2];
}

+ (NSInteger)flipCost {
    return [GameSettings getIntForKey:FLIPCOST withDefaultInt:1];
}

+ (void)setMatchBonus:(NSInteger)matchBonus {
    [GameSettings setInt:matchBonus forKey:MATCHBONUS];
}

+ (void)setMismatchPenalty:(NSInteger)mismatchPenalty {
    [GameSettings setInt:mismatchPenalty forKey:MISMATCHPENALTY];
}

+ (void)setFlipCost:(NSInteger)flipCost {
    [GameSettings setInt:flipCost forKey:FLIPCOST];
}

@end
