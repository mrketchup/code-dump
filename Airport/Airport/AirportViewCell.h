//
//  AirportViewCell.h
//  Airport
//
//  Created by Matt Jones on 8/12/13.
//  Copyright (c) 2013 Mattjones. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 * The custom cell for the AirportView.
 * @author Matt Jones
 */
@interface AirportViewCell : UITableViewCell

/** The label for the attribute ("Visibility", "Delay", etc). */
@property (weak, nonatomic) IBOutlet UILabel *attributeLabel;

/** The label with the value to the corresponding attribute. */
@property (weak, nonatomic) IBOutlet UILabel *valueLabel;

@end
