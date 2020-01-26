//
//  CardGameViewController.m
//  Matchismo
//
//  Created by Matt Jones on 5/8/13.
//  Copyright (c) 2013 Mattjones. All rights reserved.
//

#import "CardGameViewController.h"
#import "Card.h"
#import "CardMatchingGame.h"
#import "GameResult.h"

@interface CardGameViewController ()

@end

@implementation CardGameViewController

- (void)setCardButtons:(NSArray *)cardButtons {
    _cardButtons = cardButtons;
    [self updateUI];
}

- (void)setFlipCount:(NSUInteger)flipCount {
    _flipCount = flipCount;
    self.flipLabel.text = [NSString stringWithFormat:@"Flips: %d", flipCount];
}

- (GameResult *)gameResult {
    if (!_gameResult) _gameResult = [[GameResult alloc] init];
    return _gameResult;
}

- (IBAction)flipCard:(UIButton *)sender {
    int i = [self.cardButtons indexOfObject:sender];
    [self.game flipCardAtIndex:i];
    self.flipCount++;
    self.gameResult.score = self.game.score;
    [self updateUI];
}

- (IBAction)deal {
    self.game = nil;
    self.flipCount = 0;
    self.playLabel.text = @"";
    self.gameResult = nil;
    [self updateUI];
}

- (void)updateUI {
    for (UIButton *cardButton in self.cardButtons) {
        Card *card = [self.game cardAtIndex:[self.cardButtons
                                             indexOfObject:cardButton]];
        [cardButton setTitle:card.contents forState:UIControlStateSelected];
        [cardButton setTitle:card.contents
                    forState:UIControlStateSelected|UIControlStateDisabled];
        cardButton.selected = card.isFaceUp;
        cardButton.enabled = !card.isUnplayable;
        cardButton.alpha = card.isUnplayable ? 0.3 : 1.0;
    }
    
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d",
                            self.game.score];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc addObserver:self
           selector:@selector(cardMatch:)
               name:MATCH_NOTIFICATION
             object:nil];
    [nc addObserver:self
           selector:@selector(cardMismatch:)
               name:MISMATCH_NOTIFICATION
             object:nil];
    [nc addObserver:self
           selector:@selector(cardFlip:)
               name:FLIP_NOTIFICATION
             object:nil];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)cardMatch:(NSNotification *)notification {
    NSDictionary *info = notification.userInfo;
    NSArray *cards = info[NOTIFICATION_CARDS];
    int points = [info[NOTIFICATION_POINTS] intValue];
    self.playLabel.text =
    [NSString stringWithFormat:@"Matched %@ for %d points!",
     [cards componentsJoinedByString:@"& "], points];
}

- (void)cardMismatch:(NSNotification *)notification {
    NSDictionary *info = notification.userInfo;
    NSArray *cards = info[NOTIFICATION_CARDS];
    int points = [info[NOTIFICATION_POINTS] intValue];
    self.playLabel.text =
    [NSString stringWithFormat:@"%@ don’t match! %d point penalty!",
     [cards componentsJoinedByString:@"& "], points];
}

- (void)cardFlip:(NSNotification *)notification {
    NSDictionary *info = notification.userInfo;
    Card *card = info[NOTIFICATION_CARD];
    self.playLabel.text = [NSString stringWithFormat:@"Flipped up %@", card];
}

@end
