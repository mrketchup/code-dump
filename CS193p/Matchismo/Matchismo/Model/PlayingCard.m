//
//  PlayingCard.m
//  Matchismo
//
//  Created by Matt Jones on 5/6/13.
//  Copyright (c) 2013 Mattjones. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard

@synthesize suit = _suit;

- (NSString *)contents {
    NSArray *rankStrings = [PlayingCard rankStrings];
    return [rankStrings[self.rank] stringByAppendingString:self.suit];
}

- (void)setSuit:(NSString *)suit {
    if ([[PlayingCard validSuits] containsObject:suit]) {
        _suit = suit;
    }
}

- (NSString *)suit {
    return _suit ? _suit : @"?";
}

- (void)setRank:(NSUInteger)rank {
    if (rank <= [PlayingCard maxRank]) {
        _rank = rank;
    }
}

- (NSInteger)match:(NSArray *)otherCards {
    int score = 0;
    
    if ([otherCards count] == 1) {
        id otherCard = [otherCards lastObject];
        if ([otherCard isKindOfClass:[PlayingCard class]]) {
            PlayingCard *card = (PlayingCard *)otherCard;
            if (self.rank == card.rank) {
                score = 5;
            } else if ([self.suit isEqualToString:card.suit]) {
                score = 1;
            }
        }
    }
    
    return score;
}

+ (NSArray *)validSuits {
    static NSArray *validSuits = nil;
    if (!validSuits) validSuits = @[@"♥",@"♦",@"♠",@"♣"];
    return validSuits;
}

+ (NSArray *)rankStrings {
    static NSArray *rankStrings = nil;
    if (!rankStrings) {
        rankStrings = @[@"?", @"A", @"2", @"3", @"4", @"5", @"6", @"7", @"8",
                        @"9", @"10", @"J", @"Q", @"K"];
    }
    return rankStrings;
}

+ (NSUInteger)maxRank {
    return [self rankStrings].count-1;
}

@end
