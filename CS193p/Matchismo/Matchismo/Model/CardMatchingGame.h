//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by Matt Jones on 5/7/13.
//  Copyright (c) 2013 Mattjones. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Deck;
@class Card;

@interface CardMatchingGame : NSObject

@property (nonatomic, readonly) NSInteger score;
@property (nonatomic) NSInteger matchCount;

extern NSString *MATCH_NOTIFICATION;
extern NSString *MISMATCH_NOTIFICATION;
extern NSString *FLIP_NOTIFICATION;
extern NSString *NOTIFICATION_CARD;
extern NSString *NOTIFICATION_CARDS;
extern NSString *NOTIFICATION_POINTS;

- (id)initWithCardCount:(NSUInteger)cardCount usingDeck:(Deck *)deck;
- (void)flipCardAtIndex:(NSUInteger)index;
- (Card *)cardAtIndex:(NSUInteger)index;

@end
