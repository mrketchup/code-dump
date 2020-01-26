//
//  Deck.h
//  Matchismo
//
//  Created by Matt Jones on 5/6/13.
//  Copyright (c) 2013 Mattjones. All rights reserved.
//

@class Card;

@interface Deck : NSObject

- (void)addCard:(Card *)card atTop:(BOOL)atTop;
- (Card *)drawRandomCard;

@end
