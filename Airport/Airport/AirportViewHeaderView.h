//
//  AirportViewHeaderView.h
//  Airport
//
//  Created by Matt Jones on 8/12/13.
//  Copyright (c) 2013 Mattjones. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 * The custom view for the AirportView header.
 * @author Matt Jones
 */
@interface AirportViewHeaderView : UIView

/** The height that should be used for the header. */
extern CGFloat const AIRPORT_VIEW_HEADER_HEIGHT;

/** The airport IATA label. */
@property (weak, nonatomic) IBOutlet UILabel *iataLabel;

/** The airport name label. */
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

/** The airport temperature label. */
@property (weak, nonatomic) IBOutlet UILabel *temperatureLabel;

/** The image for the wind direction. */
@property (weak, nonatomic) IBOutlet UIImageView *windDirectionImage;

/** The image for the cloud conditions. */
@property (weak, nonatomic) IBOutlet UIImageView *cloudImage;

@end
