//
//  PlayingCard.h
//  Matchismo
//
//  Created by Matt Jones on 5/6/13.
//  Copyright (c) 2013 Mattjones. All rights reserved.
//

#import "Card.h"

@interface PlayingCard : Card

@property (strong, nonatomic) NSString *suit;
@property (nonatomic) NSUInteger rank;

+ (NSArray *)validSuits;
+ (NSUInteger)maxRank;

@end
