//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Matt Jones on 5/7/13.
//  Copyright (c) 2013 Mattjones. All rights reserved.
//

#import "CardMatchingGame.h"
#import "Card.h"
#import "Deck.h"
#import "GameSettings.h"

@interface CardMatchingGame()
@property (strong, nonatomic) NSMutableArray *cards;
@property (nonatomic) NSInteger score;
@end

NSString *MATCH_NOTIFICATION = @"match_notification";
NSString *MISMATCH_NOTIFICATION = @"mismatch_notification";
NSString *FLIP_NOTIFICATION = @"flip_notification";
NSString *NOTIFICATION_CARD = @"notification_card";
NSString *NOTIFICATION_CARDS = @"notification_cards";
NSString *NOTIFICATION_POINTS = @"notification_points";

@implementation CardMatchingGame

- (NSMutableArray *)cards {
    if (!_cards) {
        _cards = [[NSMutableArray alloc] init];
    }
    return _cards;
}

- (void)setMatchCount:(NSInteger)matchCount {
    _matchCount = MIN(MAX(matchCount, 2), 3);;
}

- (id)initWithCardCount:(NSUInteger)cardCount usingDeck:(Deck *)deck {
    self = [super init];
    
    if (self) {
        for (int i=0; i<cardCount; i++) {
            Card *card = [deck drawRandomCard];
            if (card) {
                self.cards[i] = card;
            } else {
                self = nil;
            }
        }
        
        _matchCount = 2;
    }
    
    return self;
}

- (Card *)cardAtIndex:(NSUInteger)index {
    return (index < [self.cards count]) ? self.cards[index] : nil;
}

- (void)flipCardAtIndex:(NSUInteger)index {
    Card *card = [self cardAtIndex:index];
    if (!card.isUnplayable) {
        if (!card.isFaceUp) {
            NSMutableArray *otherCards = [[NSMutableArray alloc] init];
            for (Card *otherCard in self.cards) {
                if (otherCard.isFaceUp && !otherCard.isUnplayable) {
                    [otherCards addObject:otherCard];
                    
                }
            }
            
            NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
            if ([otherCards count] + 1 == self.matchCount) {
                int matchScore = [card match:otherCards];
                if (matchScore) {
                    for (Card *otherCard in otherCards) {
                        otherCard.unplayable = YES;
                    }
                    
                    card.unplayable = YES;
                    self.score += matchScore * [GameSettings matchBonus];
                    
                    [otherCards addObject:card];
                    NSDictionary *info =
                    @{NOTIFICATION_CARDS: otherCards,
                      NOTIFICATION_POINTS: [NSNumber numberWithInt:matchScore]};
                    [nc postNotificationName:MATCH_NOTIFICATION
                                      object:self
                                    userInfo:info];
                } else {
                    for (Card *otherCard in otherCards) {
                        otherCard.faceUp = NO;
                    }
                    
                    self.score -= [GameSettings mismatchPenalty];
                    
                    [otherCards addObject:card];
                    NSDictionary *info =
                    @{ NOTIFICATION_CARDS: otherCards,
                       NOTIFICATION_POINTS: [NSNumber numberWithInt:
                                             [GameSettings mismatchPenalty]]};
                    [nc postNotificationName:MISMATCH_NOTIFICATION
                                      object:self
                                    userInfo:info];
                }
            } else {
                [nc postNotificationName:FLIP_NOTIFICATION
                                  object:self
                                userInfo:@{NOTIFICATION_CARD: card}];
            }
            
            self.score -= [GameSettings flipCost];
        }
        card.faceUp = !card.isFaceUp;
    }
}

@end
