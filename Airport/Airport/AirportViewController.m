//
//  DetailViewController.m
//  Airport
//
//  Created by Matt Jones on 8/7/13.
//  Copyright (c) 2013 Mattjones. All rights reserved.
//

#import "AirportViewController.h"
#import "BackgroundLayer.h"
#import "Airport.h"
#import "AirportViewHeaderView.h"
#import "Weather.h"
#import "AirportStatus.h"
#import "AirportViewCell.h"

// Constants
static NSUInteger const NUM_ROWS = 6;
static NSString * const REUSE_ID = @"Cell";
static NSString * const VISIBILITY = @"Visibility";
static NSString * const CLOUDS = @"Clouds";
static NSString * const WIND = @"Wind";
static NSString * const STATUS = @"Status";
static NSString * const DELAY = @"Delay";
static NSString * const UPDATED = @"Updated";
static NSString * const VISIBILITY_FORMAT = @"%.2f mi";
static NSString * const NONE = @"None";
static NSString * const NAME_FORMAT = @"%@ Airport";
static NSString * const TEMPERATURE_FORMAT = @"%.0f°";
static NSString * const WIND_DIR_IMAGE = @"airport_dir_ring.png";
static NSString * const CLOUD_FULL_IMAGE = @"airport_cloud_full.png";
static NSString * const CLOUD_3QRT_IMAGE = @"airport_cloud_3_quarter.png";
static NSString * const CLOUD_HALF_IMAGE = @"airport_cloud_half.png";
static NSString * const CLOUD_1QRT_IMAGE = @"airport_cloud_1_quarter.png";


#pragma mark - Private Interface

@interface AirportViewController () <UITableViewDataSource,
                                     UITableViewDelegate>
@end


@implementation AirportViewController


#pragma mark - View Lifecyle

/* Load up the gradient into the bg. */
- (void)viewDidLoad {
    UIView *view = [[UIView alloc] initWithFrame:self.tableView.frame];
    CAGradientLayer *bgLayer = [BackgroundLayer gradient];
    bgLayer.frame = view.bounds;
    [view.layer insertSublayer:bgLayer atIndex:0];
    self.tableView.backgroundView = view;
}


#pragma mark - UITableViewDataSource Methods

/* Only one. */
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

/* A row for every piece of useful info. */
- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
    return NUM_ROWS;
}

/* Show the proper info by which row it is. */
- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AirportViewCell *cell =
    [tableView dequeueReusableCellWithIdentifier:REUSE_ID
                                    forIndexPath:indexPath];
    
    switch (indexPath.row) {
        case 0:
            cell.attributeLabel.text = VISIBILITY;
            cell.valueLabel.text = [NSString stringWithFormat:VISIBILITY_FORMAT,
                                    self.airport.status.weather.visibility];
            break;
        case 1:
            cell.attributeLabel.text = CLOUDS;
            cell.valueLabel.text = self.airport.status.weather.weather;
            break;
        case 2:
            cell.attributeLabel.text = WIND;
            cell.valueLabel.text = self.airport.status.weather.wind;
            break;
        case 3:
            cell.attributeLabel.text = STATUS;
            if (self.airport.status.isDelay) {
                cell.valueLabel.text = self.airport.status.type;
            } else {
                cell.valueLabel.text = self.airport.status.reason;
            }
            break;
        case 4:
            cell.attributeLabel.text = DELAY;
            if (self.airport.status.isDelay) {
                cell.valueLabel.text = self.airport.status.avgDelay;
            } else {
                cell.valueLabel.text = NONE;
            }
            break;
        case 5:
            cell.attributeLabel.text = UPDATED;
            cell.valueLabel.text = self.airport.status.weather.timeUpdated;
            break;
        default:
            break;
    }
    
    
    return cell;
}


#pragma mark - UITableViewDelegate Methods

/*
 * Load up the custom view. Do the rotation fun for the wind direction. Pick the
 * right circle image.
 */
- (UIView *) tableView:(UITableView *)tableView
viewForHeaderInSection:(NSInteger)section {
    CGRect frame = CGRectMake(0, 0, tableView.frame.size.width,
                              AIRPORT_VIEW_HEADER_HEIGHT);
    AirportViewHeaderView *view = [[AirportViewHeaderView alloc]
                                   initWithFrame:frame];
    view.iataLabel.text = self.airport.IATA;
    view.nameLabel.text = [NSString stringWithFormat:NAME_FORMAT,
                           self.airport.name];
    view.temperatureLabel.text = [NSString stringWithFormat:TEMPERATURE_FORMAT,
                                  self.airport.status.weather.temperature];
    
    if ([self.airport.status.weather.weather isEqualToString:@"Overcast"] ||
        [self.airport.status.weather.weather isEqualToString:@"Fog"]) {
        view.cloudImage.image = [UIImage imageNamed:CLOUD_FULL_IMAGE];
    } else if ([self.airport.status.weather.weather
                isEqualToString:@"Mostly Cloudy"]) {
        view.cloudImage.image = [UIImage imageNamed:CLOUD_3QRT_IMAGE];
    } else if ([self.airport.status.weather.weather
                isEqualToString:@"Partly Cloudy"]) {
        view.cloudImage.image = [UIImage imageNamed:CLOUD_HALF_IMAGE];
    } else if ([self.airport.status.weather.weather isEqualToString:@"Fair"]) {
        view.cloudImage.image = [UIImage imageNamed:CLOUD_1QRT_IMAGE];
    }
    
    view.windDirectionImage.image = [UIImage imageNamed:WIND_DIR_IMAGE];
    view.windDirectionImage.layer.anchorPoint = CGPointMake(0.5, 0.5);
    CGFloat angle = -1 * M_PI_4 * self.airport.status.weather.windDirection;
    view.windDirectionImage.transform = CGAffineTransformMakeRotation(angle);
    view.windDirectionImage.center = view.cloudImage.center;
    
    return view;
}

/* The suggested height for the header. */
- (CGFloat)    tableView:(UITableView *)tableView
heightForHeaderInSection:(NSInteger)section {
    return AIRPORT_VIEW_HEADER_HEIGHT;
}

@end
