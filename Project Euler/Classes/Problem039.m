//
//  Problem039.m
//  Project Euler
//
//  Created by Matt Jones on 1/26/11.
//  Copyright 2011 Mr Mustard Media. All rights reserved.
//

#import "Problem039.h"


@implementation Problem39

- (id) init
{
	NSString *t = @"Problem 39";
	NSString *st = @"If p is the perimeter of a right angle triangle, {a, b, "
					"c}, which value, for p <= 1000, has the most solutions?";
	NSString *d = @"If p is the perimeter of a right angle triangle with "
	"integral length sides, {a,b,c}, there are exactly three solutions for p = "
	"120.\n\n{20,48,52}, {24,45,51}, {30,40,50}\n\nFor which value of p <= 1000, "
	"is the number of solutions maximised?";
	self = [super initWithTitle:t subtitle:st description:d solved:YES];
	
	return self;
}

- (NSString *) solve:(ProblemViewController *)pvc
{
	[pvc performSelectorOnMainThread:@selector(addToConsole:) withObject:@"Initializing..." waitUntilDone:NO];
	NSInteger ans = 1;
	NSInteger maxCount = 0;
	
	[pvc performSelectorOnMainThread:@selector(addToConsole:) withObject:@"Calculating..." waitUntilDone:NO];
	for (int n=3; n<=1000; n++)
	{
		int count = 0;
		for (int c=n-2; c>n/3; c--)
		{
			int b = 0;
			for (int a=(n-c)/2; a>0&&b<c; a--)
			{
				b = n - c - a;
				if (a*a + b*b == c*c)
				{
					count++;
				}
			}
		}
		
		if (count > maxCount)
		{
			maxCount = count;
			ans = n;
		}
	}
	
	return [NSString stringWithFormat:@"%d", ans];
}

@end
