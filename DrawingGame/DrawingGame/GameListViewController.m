//
//  GameListViewController.m
//  DrawingGame
//
//  Created by Matt Jones on 4/25/13.
//  Copyright (c) 2013 Jones Brothers. All rights reserved.
//

#import "GameListViewController.h"

@interface GameListViewController ()
@property (nonatomic, strong) NSArray *gameList;
@end

@implementation GameListViewController

- (NSArray *)gameList {
    if (!_gameList) {
        _gameList = @[@"Draw Game", @"Caption Game"];
    }
    return _gameList;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
    return [self.gameList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"gamelistcell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier
                                                            forIndexPath:indexPath];
    
    cell.textLabel.text = self.gameList[indexPath.row];
    
    return cell;
}

#pragma mark - Table view delegate

- (void)      tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        [self performSegueWithIdentifier:@"draw" sender:self];
    } else {
        [self performSegueWithIdentifier:@"caption" sender:self];
    }
}

@end
