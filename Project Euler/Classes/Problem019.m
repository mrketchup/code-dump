//
//  Problem019.m
//  Project Euler
//
//  Created by Matt Jones on 12/19/10.
//  Copyright 2010 Mr Mustard Media. All rights reserved.
//

#import "Problem019.h"


@implementation Problem19

- (id) init
{
	NSString *t = @"Problem 19";
	NSString *st = @"How many Sundays fell on the first of the month during "
					"the twentieth century?";
	NSString *d = @"You are given the following information, but you may "
				   "prefer to do some research for yourself.\n\n"
				   "\t* 1 Jan 1900 was a Monday.\n"
	"\t* Thirty days has September,\n"
	"\t  April, June and November.\n"
	"\t  All the rest have thirty-one,\n"
	"\t  Saving February alone,\n"
	"\t  Which has twenty-eight, rain or shine.\n"
	"\t  And on leap years, twenty-nine.\n"
	"\t* A leap year occurs on any year evenly divisible by 4, but not on a "
	"century unless it is divisible by 400.\n\n"
	"How many Sundays fell on the first of the month during the twentieth "
	"century (1 Jan 1901 to 31 Dec 2000)?";
	self = [super initWithTitle:t subtitle:st description:d solved:YES];
	
	return self;
}

- (NSString *) solve:(ProblemViewController *)pvc
{	
	[pvc performSelectorOnMainThread:@selector(addToConsole:) withObject:@"Initializing..." waitUntilDone:NO];
	NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
	NSDateComponents *origin = [[NSDateComponents alloc] init];
	[origin setDay:1];
	[origin setMonth:1];
	[origin setYear:1901];
	NSDateComponents *offset = [[NSDateComponents alloc] init];
	NSDate *day1 = [gregorian dateFromComponents:origin];
	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
	[formatter setDateFormat:@"dd"];
	int sum = 0;
	
	[pvc performSelectorOnMainThread:@selector(addToConsole:) withObject:@"Calculating..." waitUntilDone:NO];
	for (int i=0; i<36525; i++)
	{
		[offset setDay:i];
		NSDate *current = [gregorian dateByAddingComponents:offset toDate:day1 options:0];
		NSDateComponents *components = [gregorian components:NSWeekdayCalendarUnit fromDate:current];
		int weekday = [components weekday];
		NSString *monthday = [formatter stringFromDate:current];
		
		if (weekday == 1 && [monthday isEqualToString:@"01"]) 
		{
			sum++;
		}
	}
	
	return [NSString stringWithFormat:@"%d", sum];
}

@end
