//
//  RootViewController.h
//  Project Euler
//
//  Created by Matt Jones on 12/3/10.
//  Copyright 2010 Mr Mustard Media. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RootViewController : UITableViewController 
{
	IBOutlet NSMutableArray *solved;
	IBOutlet NSMutableArray *unsolved;
}

@property (nonatomic, strong) IBOutlet NSMutableArray *solved;
@property (nonatomic, strong) IBOutlet NSMutableArray *unsolved;

@end