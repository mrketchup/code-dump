//
//  SetCardGameViewController.m
//  Matchismo
//
//  Created by Matt Jones on 5/8/13.
//  Copyright (c) 2013 Mattjones. All rights reserved.
//

#import "SetCardGameViewController.h"
#import "CardMatchingGame.h"
#import "SetCardDeck.h"
#import "SetCard.h"
#import "GameResult.h"

@interface SetCardGameViewController ()

@end

@implementation SetCardGameViewController

@synthesize game = _game;
@synthesize gameResult = _gameResult;

- (CardMatchingGame *)game {
    if (!_game) {
        _game =
        [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                          usingDeck:[[SetCardDeck alloc]
                                                     init]];
        _game.matchCount = 3;
    }
    return _game;
}

- (GameResult *)gameResult {
    if (!_gameResult) _gameResult = [[GameResult alloc] init];
    _gameResult.gameType = @"Set";
    return _gameResult;
}

- (void)updateUI {
    [super updateUI];
    
    for (UIButton *cardButton in self.cardButtons) {
        Card *card = [self.game cardAtIndex:[self.cardButtons
                                             indexOfObject:cardButton]];
        
        NSAttributedString *title = [[NSAttributedString alloc] initWithString:card.contents];
        if ([card isKindOfClass:[SetCard class]]) {
            SetCard *setCard = (SetCard *)card;
            title = [self updateAttributedString:title withAttributesOfCard:setCard];
        }
        [cardButton setAttributedTitle:title forState:UIControlStateNormal];
        
        cardButton.alpha = card.isUnplayable ? 0.0 : 1.0;
        if (card.isFaceUp) {
            [cardButton setBackgroundColor:[UIColor colorWithWhite:0.75
                                                             alpha:1.0]];
        } else {
            [cardButton setBackgroundColor:[UIColor clearColor]];
        }
    }
}

- (NSAttributedString *)updateAttributedString:(NSAttributedString *)string
                          withAttributesOfCard:(SetCard *)card {
    NSMutableAttributedString *mutable = [string mutableCopy];
    NSRange range = [[mutable string] rangeOfString:card.contents];
    if (range.location != NSNotFound) {
        NSString *symbol = card.symbol;
        
        NSMutableDictionary *attributes = [[NSMutableDictionary alloc] init];
        
        if ([card.color isEqualToString:@"red"]) {
            attributes[NSForegroundColorAttributeName] = [UIColor redColor];
        } else if ([card.color isEqualToString:@"green"]) {
            attributes[NSForegroundColorAttributeName] = [UIColor greenColor];
        } else if ([card.color isEqualToString:@"blue"]) {
            attributes[NSForegroundColorAttributeName] = [UIColor blueColor];
        }
        
        if ([card.shading isEqualToString:@"solid"]) {
            [attributes setObject:@(-5) forKey:NSStrokeWidthAttributeName];
        } else if ([card.shading isEqualToString:@"striped"]) {
            NSDictionary *strokeDict =
            @{ NSStrokeWidthAttributeName : @(-5),
               NSStrokeColorAttributeName : attributes[NSForegroundColorAttributeName],
               NSForegroundColorAttributeName : [attributes[NSForegroundColorAttributeName]
                                                 colorWithAlphaComponent:0.3]
               };
            
            [attributes addEntriesFromDictionary:strokeDict];
        } else if ([card.shading isEqualToString:@"open"]) {
            attributes[NSStrokeWidthAttributeName] = @(5);
        }
        
        symbol = [symbol stringByPaddingToLength:card.number
                                      withString:symbol
                                 startingAtIndex:0];
        [mutable replaceCharactersInRange:range
                     withAttributedString:[[NSAttributedString alloc] initWithString:symbol
                                                                          attributes:attributes]];
    }
    
    return mutable;
}

- (void)cardMatch:(NSNotification *)notification {
    NSDictionary *info = notification.userInfo;
    NSArray *cards = info[NOTIFICATION_CARDS];
    NSString *text = [NSString stringWithFormat:@"Matched %@!",
                      [cards componentsJoinedByString:@" & "]];
    [self updatePlayLabelToText:text withCards:cards];
}

- (void)cardMismatch:(NSNotification *)notification {
    NSDictionary *info = notification.userInfo;
    NSArray *cards = info[NOTIFICATION_CARDS];
    NSString *text = [NSString stringWithFormat:@"%@ don’t match!",
                      [cards componentsJoinedByString:@" & "]];
    [self updatePlayLabelToText:text withCards:cards];
}

- (void)cardFlip:(NSNotification *)notification {
    NSDictionary *info = notification.userInfo;
    SetCard *card = info[NOTIFICATION_CARD];
    NSString *text = [NSString stringWithFormat:@"Selected %@.", card];
    [self updatePlayLabelToText:text withCards:@[card]];
}

- (void)updatePlayLabelToText:(NSString *)text withCards:(NSArray *)cards {
    NSAttributedString *lastFlip = [[NSAttributedString alloc]
                                    initWithString:text];
    
    for (Card *card in cards) {
        if ([card isKindOfClass:[SetCard class]]) {
            SetCard *setCard = (SetCard *)card;
            lastFlip = [self updateAttributedString:lastFlip
                               withAttributesOfCard:setCard];
        }
    }
    
    self.playLabel.attributedText = lastFlip;
}

@end
