//
//  FRIPlayerTableViewController.m
//  Friday Shots
//
//  Created by Matt Jones on 3/26/14.
//  Copyright (c) 2014 Mattjones. All rights reserved.
//

#import "FRIPlayerTableViewController.h"
#import "FRIPlayer.h"
#import "FRIAPIClient.h"

@interface FRIPlayerTableViewController ()
@property (nonatomic, strong) NSArray *players;
@end

@implementation FRIPlayerTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[FRIAPIClient sharedClient] getAllPlayersWithSuccess:^(NSArray *players) {
        
        self.players = players;
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0]
                      withRowAnimation:UITableViewRowAnimationAutomatic];
        
    } failure:^(NSError *error) {
        NSLog(@"%@", error);
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.players count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"player_cell"
                                                            forIndexPath:indexPath];
    FRIPlayer *player = self.players[indexPath.row];
    cell.textLabel.text = player.name;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"$%@", player.totalWinnings];
    
    return cell;
}

@end
