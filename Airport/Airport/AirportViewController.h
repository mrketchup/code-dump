//
//  DetailViewController.h
//  Airport
//
//  Created by Matt Jones on 8/7/13.
//  Copyright (c) 2013 Mattjones. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Airport;


/**
 * The AirportViewController class. It shows a bunch of details about an
 * airport.
 * @author Matt Jones
 */
@interface AirportViewController : UITableViewController

/** The airport where the info comes from. */
@property (nonatomic, strong) Airport *airport;

@end
