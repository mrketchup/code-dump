//
//  CardGameViewController.m
//  Matchismo
//
//  Created by Matt Jones on 5/6/13.
//  Copyright (c) 2013 Mattjones. All rights reserved.
//

#import "PlayingCardGameViewController.h"
#import "PlayingCardDeck.h"
#import "CardMatchingGame.h"
#import "GameResult.h"

@interface PlayingCardGameViewController ()

@end

@implementation PlayingCardGameViewController

@synthesize gameResult = _gameResult;
@synthesize game = _game;

- (CardMatchingGame *)game {
    if (!_game) {
        _game =
        [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                          usingDeck:[[PlayingCardDeck alloc]
                                                     init]];
        _game.matchCount = 2;
    }
    return _game;
}

- (GameResult *)gameResult {
    if (!_gameResult) _gameResult = [[GameResult alloc] init];
    _gameResult.gameType = @"Match";
    return _gameResult;
}

- (void)updateUI {
    [super updateUI];
    
    for (UIButton *cardButton in self.cardButtons) {
        [cardButton setBackgroundImage:[UIImage imageNamed:@"cardfront.png"]
                              forState:UIControlStateSelected|UIControlStateDisabled];
    }
}

@end
