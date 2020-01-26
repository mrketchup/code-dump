//
//  MasterViewController.m
//  Airport
//
//  Created by Matt Jones on 8/7/13.
//  Copyright (c) 2013 Mattjones. All rights reserved.
//

#import "AirportTableViewController.h"
#import "Weather.h"
#import "AirportStatusFetcher.h"
#import "Airport.h"
#import "BackgroundLayer.h"
#import "AirportSaveManager.h"
#import "AirportTableViewCell.h"
#import "AirportStatus.h"
#import "Colors.h"
#import "AirportTableViewHeaderView.h"
#import "NearbyAirportsFetcher.h"

// Constants
static NSString * const DETAIL_SEGUE_ID = @"showDetail";
static NSString * const POPUP_TITLE = @"Add an Airport";
static NSString * const POPUP_MESSAGE = @"Enter the location identifier for "
                                         "your favorite Airport.";
static NSString * const POPUP_CANCEL = @"Cancel";
static NSString * const POPUP_OK = @"OK";
static NSUInteger const MY_AIRPORTS_SECTION = 0;
static NSUInteger const NEARBY_AIRPORTS_SECTION = 1;
static NSString * const MY_AIRPORTS_TITLE = @"My Airports";
static NSString * const AIRPORTS_NEARBY_TITLE = @"Airports Nearby";
static NSString * const REUSE_ID = @"Cell";
static NSString * const NAME_FORMAT = @"%@ Airport";
static NSString * const LOCATION_FORMAT = @"%@, %@";
static NSString * const TEMPERATURE_FORMAT = @"%.0f°";
static NSString * const VISIBILITY_FORMAT = @"%.1f";
static NSString * const WIND_DIR_IMAGE = @"airport_dir_ring_small.png";
static NSString * const CLOUD_FULL_IMAGE = @"airport_cloud_full.png";
static NSString * const CLOUD_3QRT_IMAGE = @"airport_cloud_3_quarter.png";
static NSString * const CLOUD_HALF_IMAGE = @"airport_cloud_half.png";
static NSString * const CLOUD_1QRT_IMAGE = @"airport_cloud_1_quarter.png";
static NSString * const DELAY_FORMAT = @"%@: %@";
static NSString * const ALERT_IMAGE = @"airport_alert.png";
static NSUInteger const OK_INDEX = 1;
static NSString * const ZIP_KEY = @"ZIP";


#pragma mark - Private Interface

@interface AirportTableViewController () <UIAlertViewDelegate,
                                          AirportStatusFetcherDelegate,
                                          UITableViewDataSource,
                                          UITableViewDelegate,
                                          CLLocationManagerDelegate,
                                          NearbyAirportsFetcherDelegate>
@property (strong, nonatomic) NSMutableArray *airports;
@property (strong, nonatomic) NSMutableArray *nearbyAirports;
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) Airport *addAirport;
@property (strong, nonatomic) NSMutableArray *nearbyIATAs;
@end

@implementation AirportTableViewController


#pragma mark - Synthesis Override

/* Lazy load. */
- (NSMutableArray *)airports {
    if (!_airports) {
        _airports = [[NSMutableArray alloc] init];
    }
    return _airports;
}

/* Lazy load. */
- (NSMutableArray *)nearbyAirports {
    if (!_nearbyAirports) {
        _nearbyAirports = [[NSMutableArray alloc] init];
    }
    return _nearbyAirports;
}

/* Lazy load. Set the accuracy and delegate. */
- (CLLocationManager *)locationManager {
    if (!_locationManager) {
        _locationManager = [[CLLocationManager alloc] init];
        _locationManager.desiredAccuracy = kCLLocationAccuracyKilometer;
        _locationManager.delegate = self;
    }
    return _locationManager;
}


#pragma mark - View Lifecyle

/*
 * Apply the gradient background. Load the saved list and find user's location.
 */
- (void)viewDidLoad {
    UIView *view = [[UIView alloc] initWithFrame:self.tableView.frame];
    CAGradientLayer *bgLayer = [BackgroundLayer gradient];
    bgLayer.frame = view.bounds;
    [view.layer insertSublayer:bgLayer atIndex:0];
    self.tableView.backgroundView = view;
    
    self.airports = [AirportSaveManager getSavedAirports];
    [self.locationManager startUpdatingLocation];
}

/* Refresh the statuses of all the airports. */
- (void)viewWillAppear:(BOOL)animated {
    for (Airport *airport in self.airports) {
        AirportStatusFetcher *fetch =
        [[AirportStatusFetcher alloc] initWithAirport:airport delegate:self];
        [fetch fetchStatus];
    }
    
    for (Airport *airport in self.nearbyAirports) {
        AirportStatusFetcher *fetch =
        [[AirportStatusFetcher alloc] initWithAirport:airport delegate:self];
        [fetch fetchStatus];
    }
}

/* Make sure the AirportViewController has the airport. */
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:DETAIL_SEGUE_ID]) {
        UITableViewCell *cell = sender;
        NSIndexPath *path = [self.tableView indexPathForCell:cell];
        
        Airport *a;
        if (path.section == 0) {
            a = self.airports[path.row];
        } else {
            a = self.nearbyAirports[path.row];
        }
        
        [segue.destinationViewController setAirport:a];
    }
}


#pragma mark - IB Actions

/* Called by the + button. Gives a text entry popup. */
- (IBAction)addAirport:(UIBarButtonItem *)sender {
    UIAlertView *popup = [[UIAlertView alloc] initWithTitle:POPUP_TITLE
                                                    message:POPUP_MESSAGE
                                                   delegate:self
                                          cancelButtonTitle:POPUP_CANCEL
                                          otherButtonTitles:POPUP_OK, nil];
    popup.alertViewStyle = UIAlertViewStylePlainTextInput;
    [popup show];
}


#pragma mark - UITableViewDataSource Methods

/* My Airports + Airports Nearby = 2 */
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

/* Get the sizes right. */
- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
    if (section == MY_AIRPORTS_SECTION) {
        return [self.airports count];
    } else {
        return [self.nearbyAirports count];
    }
}

/* Get the section titles right. */
- (NSString *)tableView:(UITableView *)tableView
titleForHeaderInSection:(NSInteger)section {
    if (section == MY_AIRPORTS_SECTION) {
        return MY_AIRPORTS_TITLE;
    } else {
        return AIRPORTS_NEARBY_TITLE;
    }
}

/*
 * Gets the correct airport for the section then fills out all the labels. Does
 * a rotation transformation with the airport's wind direction. Figures out the
 * proper middle circle. Shows delay info and alert image if there is a delay.
 */
- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AirportTableViewCell *cell =
    [tableView dequeueReusableCellWithIdentifier:REUSE_ID
                                    forIndexPath:indexPath];
    
    Airport *a;
    if (indexPath.section == MY_AIRPORTS_SECTION) {
        a = self.airports[indexPath.row];
    } else {
        a = self.nearbyAirports[indexPath.row];
    }
    
    cell.iataLabel.text = a.IATA;
    cell.nameLabel.text = [NSString stringWithFormat:NAME_FORMAT, a.name];
    cell.locationLabel.text = [NSString stringWithFormat:LOCATION_FORMAT,
                               a.city, a.state];
    cell.temperatureLabel.text = [NSString stringWithFormat:TEMPERATURE_FORMAT,
                                  a.status.weather.temperature];
    cell.visibilityLabel.text = [NSString stringWithFormat:VISIBILITY_FORMAT,
                                 a.status.weather.visibility];
    
    if ([a.status.weather.weather isEqualToString:@"Overcast"] ||
        [a.status.weather.weather isEqualToString:@"Fog"]) {
        cell.cloudImage.image = [UIImage imageNamed:CLOUD_FULL_IMAGE];
    } else if ([a.status.weather.weather isEqualToString:@"Mostly Cloudy"]) {
        cell.cloudImage.image = [UIImage imageNamed:CLOUD_3QRT_IMAGE];
    } else if ([a.status.weather.weather isEqualToString:@"Partly Cloudy"]) {
        cell.cloudImage.image = [UIImage imageNamed:CLOUD_HALF_IMAGE];
    } else if ([a.status.weather.weather isEqualToString:@"Fair"]) {
        cell.cloudImage.image = [UIImage imageNamed:CLOUD_1QRT_IMAGE];
    }
    
    cell.windDirectionImage.image = [UIImage imageNamed:WIND_DIR_IMAGE];
    cell.windDirectionImage.layer.anchorPoint = CGPointMake(0.5, 0.5);
    CGFloat angle = -1 * M_PI_4 * a.status.weather.windDirection;
    cell.windDirectionImage.transform = CGAffineTransformMakeRotation(angle);
    cell.windDirectionImage.center = cell.cloudImage.center;
    
    if (a.status.isDelay) {
        cell.delayLabel.text = [NSString stringWithFormat:DELAY_FORMAT,
                                a.status.reason, a.status.avgDelay];
        cell.delayImage.image = [UIImage imageNamed:ALERT_IMAGE];
    }
    
    return cell;
}

/* Can only edit My Airports. */
- (BOOL)    tableView:(UITableView *)tableView
canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return indexPath.section == MY_AIRPORTS_SECTION;
}

/* Remove the airport from everywhere and do a nice animation. */
- (void) tableView:(UITableView *)tableView
commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
 forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        Airport *a = self.airports[indexPath.row];
        [self.airports removeObject:a];
        [AirportSaveManager removeAirport:a];
        [self.tableView deleteRowsAtIndexPaths:@[indexPath]
                              withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}


#pragma mark - UITableViewDelegate Methods

/* Replace the header views with the custom one. */
- (UIView *) tableView:(UITableView *)tableView
viewForHeaderInSection:(NSInteger)section {
    CGRect frame = CGRectMake(0, 0, tableView.frame.size.width,
                              AIRPORT_TABLE_VIEW_HEADER_HEIGHT);
    AirportTableViewHeaderView *view = [[AirportTableViewHeaderView alloc]
                                        initWithFrame:frame];
    view.titleLabel.text = [self tableView:tableView
                   titleForHeaderInSection:section];
    return view;
}

/* Suggested height for the custom header. */
- (CGFloat)    tableView:(UITableView *)tableView
heightForHeaderInSection:(NSInteger)section {
    return AIRPORT_TABLE_VIEW_HEADER_HEIGHT;
}


#pragma mark - UIAlertViewDelegate Methods

/* Start the fetch process if the user tapped OK. Make sure IATA is upcase. */
- (void)        alertView:(UIAlertView *)alertView
didDismissWithButtonIndex:(NSInteger)buttonIndex {
    if (buttonIndex == OK_INDEX) {
        self.addAirport = [[Airport alloc] init];
        self.addAirport.IATA = [[alertView textFieldAtIndex:0].text
                                uppercaseString];
        AirportStatusFetcher *fetch =
        [[AirportStatusFetcher alloc] initWithAirport:self.addAirport
                                             delegate:self];
        [fetch fetchStatus];
    }
}


#pragma mark - AirportStatusFetcherDelegate Methods

/* If it is the airport being added, nil it. */
- (void)airportStatusFetcher:(AirportStatusFetcher *)fetcher
            didFailWithError:(NSError *)error {
    NSLog(@"%@", error);
    
    if ([self.addAirport isEqual:fetcher.airport]) {
        self.addAirport = nil;
    }    
}

/*
 * If it is the airport being added, add it everywhere and give a nice
 * animation. If it is a match for a nearby airport, add it. Otherwise, search
 * through the airports and update when there is a match.
 */
- (void)airportStatusFetcher:(AirportStatusFetcher *)fetcher
              didFetchStatus:(AirportStatus *)status
                  forAirport:(Airport *)airport {
    if ([self.addAirport isEqual:airport]) {
        [self.airports addObject:airport];
        [AirportSaveManager saveAirport:airport];
        self.addAirport = nil;
        
        NSIndexPath *path =
        [NSIndexPath indexPathForItem:([self.airports count] - 1)
                            inSection:MY_AIRPORTS_SECTION];
        [self.tableView insertRowsAtIndexPaths:@[path]
                              withRowAnimation:UITableViewRowAnimationAutomatic];
    } else if ([self.nearbyIATAs containsObject:airport.IATA]) {
        [self.nearbyAirports addObject:airport];
        [self.nearbyIATAs removeObject:airport.IATA];
        
        NSIndexPath *path =
        [NSIndexPath indexPathForItem:([self.nearbyAirports count] - 1)
                            inSection:NEARBY_AIRPORTS_SECTION];
        [self.tableView insertRowsAtIndexPaths:@[path]
                              withRowAnimation:UITableViewRowAnimationAutomatic];
    } else {
        for (Airport *a in self.airports) {
            if ([airport isEqual:a]) {
                a.status = status;
                break;
            }
        }
        
        [self.tableView reloadData];
    }
}


#pragma mark - CLLocationManagerDelegate Methods

/* Reverse geocode the ZIP and fetch the nearby airports. */
- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray *)locations {
    [self.locationManager stopUpdatingLocation];
    CLLocation *loc = locations[0];
    CLGeocoder* reverseGeocoder = [[CLGeocoder alloc] init];
    [reverseGeocoder reverseGeocodeLocation:loc completionHandler:
     ^(NSArray *placemarks, NSError *error) {
         CLPlacemark *placemark = placemarks[0];
         NSString *zip = placemark.addressDictionary[ZIP_KEY];
         NearbyAirportsFetcher *fetcher =
         [[NearbyAirportsFetcher alloc] initWithZipcode:zip delegate:self];
         [fetcher fetchList];
     }];
}


#pragma mark - NearbyAirportsFetcherDelegate Methods

/* Log it. */
- (void)nearbyAirportsFetcher:(NearbyAirportsFetcher *)fetcher
             didFailWithError:(NSError *)error {
    NSLog(@"%@", error);
}

/* Set the array of nearby IATAs and fetch the status for all of them. */
- (void)nearbyAirportsFetcher:(NearbyAirportsFetcher *)fetcher
             didFetchAirportCodes:(NSArray *)iataCodes {
    self.nearbyIATAs = [iataCodes mutableCopy];
    for (NSString *iata in self.nearbyIATAs) {
        Airport *airport = [[Airport alloc] init];
        airport.IATA = iata;
        AirportStatusFetcher *fetch =
        [[AirportStatusFetcher alloc] initWithAirport:airport delegate:self];
        [fetch fetchStatus];
    }
}

@end
