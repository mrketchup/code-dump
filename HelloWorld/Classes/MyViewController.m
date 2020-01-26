/*
*  MyViewController.m
*  HelloWorld
*
*  Created by Matt Jones on 10/31/10.
*  Copyright 2010 Mr Mustard Media. All rights reserved.
*/

#import "MyViewController.h"

@implementation MyViewController

- (IBAction)changeGreeting:(id)sender {
	label.text = [self getGreeting:textField.text];
}

- (NSString *)getGreeting:(NSString *)name {
	if ([name length] == 0) {
		name = @"World";
	}
	
	NSString *prefix = @"Hello";
	NSInteger hour = [self getHour];
	if (hour < 4 || hour > 21) {
		prefix = @"Good night";
	}
	else if(hour > 3 && hour < 11) {
		prefix = @"Good morning";
	}
	else if(hour > 16 && hour < 22) {
		prefix = @"Good evening";
	}
	else if(hour > 11 && hour < 16) {
		prefix = @"Good afternoon";
	}

	
	return [NSString stringWithFormat:@"%@, %@!", prefix, name];
}

- (NSInteger)getHour {
	NSDate *date = [[NSDate alloc] init];
	NSString *time = [[date description] substringFromIndex:11];
	time = [time substringToIndex:2];
	
	NSInteger hour = [time intValue];
	NSInteger offset = [[NSTimeZone localTimeZone] secondsFromGMT] / 3600;
	hour += offset;
	if (hour < 0) {
		hour += 24;
	}
	
	return hour;
}

- (BOOL)textFieldShouldReturn:(UITextField *)theTextField {
	if(theTextField = textField) {
		[textField resignFirstResponder];
	}
	
	return YES;
}

@synthesize textField;
@synthesize label;
@synthesize string;

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
    [super viewDidUnload];
}

- (void)dealloc {
	[textField release];
	[label release];
	[string release];
    [super dealloc];
}

@end