//
//  Problem040.m
//  Project Euler
//
//  Created by Matt Jones on 1/26/11.
//  Copyright 2011 Mr Mustard Media. All rights reserved.
//

#import "Problem040.h"


@implementation Problem40

- (id) init
{
	NSString *t = @"Problem 40";
	NSString *st = @"Finding the nth digit of the fractional part of the "
					"irrational number.";
	NSString *d = @"An irrational decimal fraction is created by concatenating "
	"the positive integers:\n\n\t0.123456789101112131415161718192021...\n\nIt "
	"can be seen that the 12th digit of the fractional part is 1.\n\nIf d(n) "
	"represents the nth digit of the fractional part, find the value of the "
	"following expression.\n\n\td(1) x d(10) x d(100) x d(1000) x d(10000) x "
	"d(100000) x d(1000000)";
	self = [super initWithTitle:t subtitle:st description:d solved:YES];
	
	return self;
}

- (NSString *) solve:(ProblemViewController *)pvc
{
	[pvc performSelectorOnMainThread:@selector(addToConsole:) withObject:@"Initializing..." waitUntilDone:NO];
	int product = 1;
	NSString *fraction = [[NSString alloc] init];
	for (int i=1; [fraction length] < 100000; i++) 
	{
		fraction = [fraction stringByAppendingFormat:@"%d",i];
	}
	
	[pvc performSelectorOnMainThread:@selector(addToConsole:) withObject:@"Calculating..." waitUntilDone:NO];
	product *= [[fraction substringWithRange:NSMakeRange(0, 1)] intValue];
	product *= [[fraction substringWithRange:NSMakeRange(9, 1)] intValue];
	product *= [[fraction substringWithRange:NSMakeRange(99, 1)] intValue];
	product *= [[fraction substringWithRange:NSMakeRange(999, 1)] intValue];
	product *= [[fraction substringWithRange:NSMakeRange(9999, 1)] intValue];
	product *= [[fraction substringWithRange:NSMakeRange(99999, 1)] intValue];
	
	return [NSString stringWithFormat:@"%d", product];
}

@end
