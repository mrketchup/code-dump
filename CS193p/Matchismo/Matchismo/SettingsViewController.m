//
//  SettingsViewController.m
//  Matchismo
//
//  Created by Matt Jones on 5/9/13.
//  Copyright (c) 2013 Mattjones. All rights reserved.
//

#import "SettingsViewController.h"
#import "GameSettings.h"

@interface SettingsViewController ()
@property (weak, nonatomic) IBOutlet UILabel *matchBonusLabel;
@property (weak, nonatomic) IBOutlet UILabel *mismatchPenaltyLabel;
@property (weak, nonatomic) IBOutlet UILabel *flipCostLabel;
@property (weak, nonatomic) IBOutlet UISlider *matchBonusSlider;
@property (weak, nonatomic) IBOutlet UISlider *mismatchPenaltySlider;
@property (weak, nonatomic) IBOutlet UISlider *flipCostSlider;
@end

@implementation SettingsViewController

- (IBAction)matchBonusSliderChanged:(UISlider *)sender {
    [self setLabel:self.matchBonusLabel forSlider:sender];
    [GameSettings setMatchBonus:floor(sender.value)];
}

- (IBAction)mismatchPenaltySliderChanged:(UISlider *)sender {
    [self setLabel:self.mismatchPenaltyLabel forSlider:sender];
    [GameSettings setMismatchPenalty:floor(sender.value)];
}

- (IBAction)flipCostSliderChanged:(UISlider *)sender {
    [self setLabel:self.flipCostLabel forSlider:sender];
    [GameSettings setFlipCost:floor(sender.value)];
}

- (void)setLabel:(UILabel *)label forSlider:(UISlider *)slider {
    int sliderValue;
    sliderValue = lroundf(slider.value);
    [slider setValue:sliderValue animated:NO];
    label.text = [NSString stringWithFormat:@"%d", sliderValue];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.matchBonusSlider.value = [GameSettings matchBonus];
    self.mismatchPenaltySlider.value = [GameSettings mismatchPenalty];
    self.flipCostSlider.value = [GameSettings flipCost];
    
    [self setLabel:self.matchBonusLabel forSlider:self.matchBonusSlider];
    [self setLabel:self.mismatchPenaltyLabel forSlider:self.mismatchPenaltySlider];
    [self setLabel:self.flipCostLabel forSlider:self.flipCostSlider];
}

@end
