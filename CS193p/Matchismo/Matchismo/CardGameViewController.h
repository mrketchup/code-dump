//
//  CardGameViewController.h
//  Matchismo
//
//  Created by Matt Jones on 5/8/13.
//  Copyright (c) 2013 Mattjones. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CardMatchingGame;
@class GameResult;

@interface CardGameViewController : UIViewController

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *flipLabel;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *playLabel;
@property (strong, nonatomic) CardMatchingGame *game;
@property (nonatomic) NSUInteger flipCount;
@property (strong, nonatomic) GameResult *gameResult;

- (IBAction)flipCard:(UIButton *)sender;
- (IBAction)deal;
- (void)updateUI;
- (void)cardMatch:(NSNotification *)notification;
- (void)cardMismatch:(NSNotification *)notification;

@end
