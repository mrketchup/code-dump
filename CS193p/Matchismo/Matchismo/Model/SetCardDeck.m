//
//  SetCardDeck.m
//  Matchismo
//
//  Created by Matt Jones on 5/8/13.
//  Copyright (c) 2013 Mattjones. All rights reserved.
//

#import "SetCardDeck.h"
#import "SetCard.h"

@implementation SetCardDeck

- (id)init {
    self = [super init];
    
    if (self) {
        for (NSString *color in [SetCard validColors]) {
            for (NSString *symbol in [SetCard validSymbols]) {
                for (NSString *shading in [SetCard validShadings]) {
                    for (int n = 1; n <= [SetCard maxNumber]; n++) {
                        SetCard *card = [[SetCard alloc] init];
                        card.color = color;
                        card.symbol = symbol;
                        card.shading = shading;
                        card.number = n;
                        [self addCard:card atTop:YES];
                    }
                }
            }
        }
    }
    
    return self;
}

@end
