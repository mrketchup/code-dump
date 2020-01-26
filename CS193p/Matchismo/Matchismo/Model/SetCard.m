//
//  SetCard.m
//  Matchismo
//
//  Created by Matt Jones on 5/8/13.
//  Copyright (c) 2013 Mattjones. All rights reserved.
//

#import "SetCard.h"

@implementation SetCard

@synthesize color = _color;
@synthesize symbol = _symbol;
@synthesize shading = _shading;

- (NSString *)color {
    return _color ? _color : @"?";
}

- (void)setColor:(NSString *)color {
    if ([[SetCard validColors] containsObject:color]) _color = color;
}

- (NSString *)symbol {
    return _symbol ? _symbol : @"?";
}

- (void)setSymbol:(NSString *)symbol {
    if ([[SetCard validSymbols] containsObject:symbol]) _symbol = symbol;
}

- (NSString *)shading {
    return _shading ? _shading : @"?";
}

- (void)setShading:(NSString *)shading {
    if ([[SetCard validShadings] containsObject:shading]) _shading = shading;
}

- (void)setNumber:(NSUInteger)number {
    if (number <= [SetCard maxNumber]) _number = number;
}

- (NSString *)contents {
    return [NSString stringWithFormat:@"%@:%@:%@:%d", self.symbol, self.color, self.shading, self.number];
}

- (int)match:(NSArray *)otherCards {
    int score = 0;
    
    if ([otherCards count] == 2) {
        NSMutableSet *colors = [[NSMutableSet alloc] init];
        NSMutableSet *symbols = [[NSMutableSet alloc] init];
        NSMutableSet *shadings = [[NSMutableSet alloc] init];
        NSMutableSet *numbers = [[NSMutableSet alloc] init];
        
        [colors addObject:self.color];
        [symbols addObject:self.symbol];
        [shadings addObject:self.shading];
        [numbers addObject:@(self.number)];
        
        for (id otherCard in otherCards) {
            if ([otherCard isKindOfClass:[SetCard class]]) {
                SetCard *card = (SetCard *)otherCard;
                [colors addObject:card.color];
                [symbols addObject:card.symbol];
                [shadings addObject:card.shading];
                [numbers addObject:@(card.number)];
            }
        }
        
        if (([colors count] == 1 || [colors count] == 3)
            && ([symbols count] == 1 || [symbols count] == 3)
            && ([shadings count] == 1 || [shadings count] == 3)
            && ([numbers count] == 1 || [numbers count] == 3)) {
            score = 5;
        }
    }
    
    return score;
}

+ (NSArray *)validColors {
    return @[@"red", @"green", @"blue"];
}

+ (NSArray *)validSymbols {
    return @[@"●", @"▲", @"■"];
}

+ (NSArray *)validShadings {
    return @[@"solid", @"open", @"striped"];
}

+ (NSUInteger)maxNumber {
    return 3;
}

@end
