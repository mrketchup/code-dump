//
//  GameResult.m
//  Matchismo
//
//  Created by Matt Jones on 5/9/13.
//  Copyright (c) 2013 Mattjones. All rights reserved.
//

#import "GameResult.h"

@interface GameResult()
@property (readwrite, nonatomic) NSDate *start;
@property (readwrite, nonatomic) NSDate *end;
@end

@implementation GameResult

#define ALL_RESULTS_KEY @"GameResult_All"
#define START_KEY @"StartDate"
#define END_KEY @"EndDate"
#define SCORE_KEY @"Score"
#define GAME_KEY @"Game"

+ (NSArray *)allGameResults {
    NSMutableArray *allGameResults = [[NSMutableArray alloc] init];
    
    for (id plist in [[[NSUserDefaults standardUserDefaults]
                       dictionaryForKey:ALL_RESULTS_KEY] allValues]) {
        GameResult *result = [[GameResult alloc] initFromPropertyList:plist];
        [allGameResults addObject:result];
    }
    
    return allGameResults;
}

- (id)initFromPropertyList:(id)plist {
    self = [self init];
    if (self) {
        if ([plist isKindOfClass:[NSDictionary class]]) {
            NSDictionary *resultDictionary = (NSDictionary *)plist;
            _start = resultDictionary[START_KEY];
            _end = resultDictionary[END_KEY];
            _score = [resultDictionary[SCORE_KEY] intValue];
            _gameType = resultDictionary[GAME_KEY];
            if (!_start || !_end) self = nil;
        }
    }
    return self;
}

- (void)synchronize {
    NSMutableDictionary *defaults = [[[NSUserDefaults standardUserDefaults]
                                      dictionaryForKey:ALL_RESULTS_KEY]
                                     mutableCopy];
    if (!defaults) {
        defaults = [[NSMutableDictionary alloc] init];
    }
    
    defaults[[self.start description]] = [self asPropertyList];
    [[NSUserDefaults standardUserDefaults] setObject:defaults
                                              forKey:ALL_RESULTS_KEY];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (id)asPropertyList {
    return @{ START_KEY : self.start,
              END_KEY : self.end,
              SCORE_KEY : @(self.score),
              GAME_KEY : self.gameType };
}

- (id)init {
    self = [super init];
    if (self) {
        _start = [NSDate date];
        _end = _start;
    }
    return self;
}

- (NSTimeInterval)duration {
    return [self.end timeIntervalSinceDate:self.start];
}

- (void)setScore:(int)score {
    _score = score;
    self.end = [NSDate date];
    [self synchronize];
}

- (NSComparisonResult)compareScore:(GameResult *)aGameResult {
    return ([@(aGameResult.score) compare:@(self.score)]);
}

@end
