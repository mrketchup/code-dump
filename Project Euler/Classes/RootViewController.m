//
//  RootViewController.m
//  Project Euler
//
//  Created by Matt Jones on 12/3/10.
//  Copyright 2010 Mr Mustard Media. All rights reserved.
//

#import "RootViewController.h"
#import "ProblemViewController.h"
#import "Importer.h"


@implementation RootViewController

@synthesize solved, unsolved;

#pragma mark -
#pragma mark View lifecycle

- (void)populateLists
{
	solved = [[NSMutableArray alloc] init];
	unsolved = [[NSMutableArray alloc] init];
	NSMutableArray *s = [Importer getSolved];
	NSMutableArray *u = [Importer getUnsolved];
	
	for (int i=0; i<[u count]; i++) 
	{
		Problem *p = [u objectAtIndex:i];
		ProblemViewController *pvc = [[ProblemViewController alloc] initWithProblem:p];
		[solved addObject:pvc];
	}
	
	for (int i=0; i<[s count]; i++) 
	{
		Problem *p = [s objectAtIndex:i];
		ProblemViewController *pvc = [[ProblemViewController alloc] initWithProblem:p];
		[unsolved addObject:pvc];
	}
}

- (void)awakeFromNib
{
	[self populateLists];
	
	UIBarButtonItem *temp = [[UIBarButtonItem alloc] init];
	temp.title = @"Back";
	self.navigationItem.backBarButtonItem = temp;
	
	self.title = @"Project Euler";
}


#pragma mark -
#pragma mark Table view data source

// Customize the number of sections in the table view.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0)
	{
		return [solved count];
	}

	return [unsolved count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
	NSArray *sections = @[[NSString stringWithFormat:@"Unsolved (%d)",[solved count]],
						 [NSString stringWithFormat:@"Solved (%d)",[unsolved count]]];
	return [sections objectAtIndex:section];
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
	// Configure the cell.
	ProblemViewController *pvc;
	if (indexPath.section == 0) 
	{
		pvc = [solved objectAtIndex:indexPath.row];
	}
	else 
	{
		pvc = [unsolved objectAtIndex:indexPath.row];
	}
	
	cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	cell.textLabel.text = pvc.problem.title;
	cell.detailTextLabel.numberOfLines = 10;
	cell.detailTextLabel.text = pvc.problem.subtitle;

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	ProblemViewController *pvc;
	if (indexPath.section == 0) 
	{
		pvc = [solved objectAtIndex:indexPath.row];
	}
	else 
	{
		pvc = [unsolved objectAtIndex:indexPath.row];
	}
	
	NSString *st = pvc.problem.subtitle;
	CGSize constraint = CGSizeMake(320.0f, 20000.0f);
	CGSize size = [st sizeWithFont:[UIFont systemFontOfSize:16.0f] constrainedToSize:constraint lineBreakMode:NSLineBreakByWordWrapping];
	
	return size.height + 30.0f;
}


#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ProblemViewController *target;
	if (indexPath.section == 0) 
	{
		target = [solved objectAtIndex:indexPath.row];
	}
	else 
	{
		target = [unsolved objectAtIndex:indexPath.row];
	}
	[[self navigationController] pushViewController:target animated:YES];
}


#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}



@end