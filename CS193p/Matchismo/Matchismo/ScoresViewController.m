//
//  ScoresViewController.m
//  Matchismo
//
//  Created by Matt Jones on 5/9/13.
//  Copyright (c) 2013 Mattjones. All rights reserved.
//

#import "ScoresViewController.h"
#import "GameResult.h"

@interface ScoresViewController () <UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITextView *display;
@property (strong, nonatomic) NSArray *allGameResults;
@end

@implementation ScoresViewController

- (void)updateUI {
    NSString *displayText = @"";
    for (GameResult *result in self.allGameResults) {
        displayText = [displayText stringByAppendingFormat:@"%@: %d, (%@, %gs)\n",
                       result.gameType ? result.gameType : @"Card Matching",
                       result.score,
                       [NSDateFormatter localizedStringFromDate:result.end
                                                      dateStyle:NSDateFormatterShortStyle
                                                      timeStyle:NSDateFormatterShortStyle],
                       round(result.duration)];
    }
    self.display.text = displayText;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.allGameResults = [[GameResult allGameResults]
                           sortedArrayUsingSelector:@selector(compareScore:)];
    [self.tableView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
    return section == 0 ? [self.allGameResults count] : 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"scorecell"];
    GameResult *result = self.allGameResults[indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%d", result.score];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ (%@, %gs)",
                                 result.gameType,
                                 [NSDateFormatter localizedStringFromDate:result.end
                                                                dateStyle:NSDateFormatterShortStyle
                                                                timeStyle:NSDateFormatterNoStyle],
                                 round(result.duration)];
    return cell;
}

@end
