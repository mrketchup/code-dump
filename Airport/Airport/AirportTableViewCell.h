//
//  AirportTableViewCell.h
//  Airport
//
//  Created by Matt Jones on 8/11/13.
//  Copyright (c) 2013 Mattjones. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 * The custom cell for the AirportTableView.
 * @author Matt Jones
 */
@interface AirportTableViewCell : UITableViewCell

/** The airport IATA label. */
@property (weak, nonatomic) IBOutlet UILabel *iataLabel;

/** The airport name label. */
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

/** The airport location label. */
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;

/** The airport delay label. */
@property (weak, nonatomic) IBOutlet UILabel *delayLabel;

/** The airport temperature label. */
@property (weak, nonatomic) IBOutlet UILabel *temperatureLabel;

/** The airport visibility label. */
@property (weak, nonatomic) IBOutlet UILabel *visibilityLabel;

/** The image for the delay alert. */
@property (weak, nonatomic) IBOutlet UIImageView *delayImage;

/** The image for the wind direction. */
@property (weak, nonatomic) IBOutlet UIImageView *windDirectionImage;

/** The image for the cloud conditions. */
@property (weak, nonatomic) IBOutlet UIImageView *cloudImage;

@end
