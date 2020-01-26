/*
*  MyViewController.h
*  HelloWorld
*
*  Created by Matt Jones on 10/31/10.
*  Copyright 2010 Mr Mustard Media. All rights reserved.
*/

#import <UIKit/UIKit.h>

@interface MyViewController : UIViewController <UITextFieldDelegate> {
	UITextField *textField;
	UILabel *label;
	NSString *string;
}

@property (nonatomic, retain) IBOutlet UITextField *textField;
@property (nonatomic, retain) IBOutlet UILabel *label;
@property (nonatomic, copy) NSString *string;
- (IBAction)changeGreeting:(id)sender;
- (NSString *)getGreeting:(NSString *)name;
- (NSInteger)getHour;

@end