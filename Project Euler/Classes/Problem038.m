//
//  Problem038.m
//  Project Euler
//
//  Created by Matt Jones on 1/26/11.
//  Copyright 2011 Mr Mustard Media. All rights reserved.
//

#import "Problem038.h"


@implementation Problem38

- (id) init
{
	NSString *t = @"Problem 38";
	NSString *st = @"What is the largest 1 to 9 pandigital that can be formed "
					"by multiplying a fixed number by 1, 2, 3, ... ?";
	NSString *d = @"Take the number 192 and multiply it by each of 1, 2, and 3:"
	"\n\n\t192 x 1 = 192\n\t192 x 2 = 384\n\t192 x 3 = 576\n\nBy concatenating "
	"each product we get the 1 to 9 pandigital, 192384576. We will call "
	"192384576 the concatenated product of 192 and (1,2,3)\n\nThe same can be "
	"achieved by starting with 9 and multiplying by 1, 2, 3, 4, and 5, giving "
	"the pandigital, 918273645, which is the concatenated product of 9 and "
	"(1,2,3,4,5).\n\nWhat is the largest 1 to 9 pandigital 9-digit number that "
	"can be formed as the concatenated product of an integer with (1,2, ... , "
	"n) where n > 1?";
	self = [super initWithTitle:t subtitle:st description:d solved:YES];
	
	return self;
}

- (NSString *) solve:(ProblemViewController *)pvc
{
	[pvc performSelectorOnMainThread:@selector(addToConsole:) withObject:@"Initializing..." waitUntilDone:NO];
	NSMutableArray *pandigitals = [[NSMutableArray alloc] init];
	for (int i=1; i<9876; i++) 
	{
		NSString *n = [self nineDigitNumber:i];
		if ([self isPandigital:n])
		{
			NSLog(@"%@",n);
			[pandigitals addObject:n];
		}
	}
	
	[pvc performSelectorOnMainThread:@selector(addToConsole:) withObject:@"Calculating..." waitUntilDone:NO];
	[pandigitals sortUsingSelector:@selector(caseInsensitiveCompare:)];
	
	return [NSString stringWithFormat:@"%@", [pandigitals objectAtIndex:[pandigitals count]-1]];
}

- (NSString *) nineDigitNumber:(NSInteger)n
{
	NSString *num = @"";
	
	int x = 1;
	while ([num length] < 9) 
	{
		num = [num stringByAppendingFormat:@"%d", n*x];
		x++;
	}
	
	if ([num length] > 9) 
	{
		num = @"";
	}
	
	return num;
}

- (BOOL) isPandigital:(NSString *)num
{
	BOOL answer = YES;
	
	for (int i=1; i<10; i++)
	{
		NSArray *split = [num componentsSeparatedByString:[NSString stringWithFormat:@"%d",i]];
		if ([split count] == 1)
		{
			answer = NO;
			i = 10;
		}
	}
	
	return answer;
}

@end
