//
//  AirportTableViewHeaderView.h
//  Airport
//
//  Created by Matt Jones on 8/11/13.
//  Copyright (c) 2013 Mattjones. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 * The custom view for the AirportTableView headers.
 * @author Matt Jones
 */
@interface AirportTableViewHeaderView : UIView

/** The height that should be used for the header. */
extern CGFloat const AIRPORT_TABLE_VIEW_HEADER_HEIGHT;

/** The title label. */
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end
