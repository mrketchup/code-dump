//
//  Problem018.m
//  Project Euler
//
//  Created by Matt Jones on 12/19/10.
//  Copyright 2010 Mr Mustard Media. All rights reserved.
//

#import "Problem018.h"


@implementation Problem18

- (id) init
{
	NSString *t = @"Problem 18";
	NSString *st = @"Find the maximum sum travelling from the top of the "
					"triangle to the base.";
	NSString *d = @"By starting at the top of the triangle below and moving to "
				   "adjacent numbers on the row below, the maximum total from "
				   "top to bottom is 23.\n"
				   "\n\t  *3*"
				   "\n\t *7*4"
				   "\n\t 2*4*6"
				   "\n\t8 5*9*3"
				   "\n\nThat is, 3 + 7 + 4 + 9 = 23.\n\nFind the maximum total "
				   "from top to bottom of the triangle below:\n"
	"\n                            75"
	"\n                          95 64"
	"\n                        17 47 82"
	"\n                      18 35 87 10"
	"\n                    20 04 82 47 65"
	"\n                  19 01 23 75 03 34"
	"\n                88 02 77 73 07 63 67"
	"\n              99 65 04 28 06 16 70 92"
	"\n            41 41 26 56 83 40 80 70 33"
	"\n          41 48 72 33 47 32 37 16 94 29"
	"\n        53 71 44 65 25 43 91 52 97 51 14"
	"\n      70 11 33 28 77 73 17 78 39 68 17 57"
	"\n    91 71 52 38 17 14 91 43 58 50 27 29 48"
	"\n  63 66 04 68 89 53 67 30 73 16 69 87 40 31"
	"\n04 62 98 27 23 09 70 98 73 93 38 53 60 04 23\n\nNOTE: As there are only "
	"16384 routes, it is possible to solve this problem by trying every route. "
	"However, Problem 67, is the same challenge with a triangle containing "
	"one-hundred rows; it cannot be solved by brute force, and requires a "
	"clever method! ;o)";
	self = [super initWithTitle:t subtitle:st description:d solved:YES];
	
	return self;
}

- (NSString *) solve:(ProblemViewController *)pvc
{	
	[pvc performSelectorOnMainThread:@selector(addToConsole:) withObject:@"Initializing..." waitUntilDone:NO];
	int numbers[15][15] = {
		{75, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
		{95,64, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
		{17,47,82, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
		{18,35,87,10, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
		{20, 4,82,47,65, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
		{19, 1,23,75, 3,34, 0, 0, 0, 0, 0, 0, 0, 0, 0},
		{88, 2,77,73, 7,63,67, 0, 0, 0, 0, 0, 0, 0, 0},
		{99,65, 4,28, 6,16,70,92, 0, 0, 0, 0, 0, 0, 0},
		{41,41,26,56,83,40,80,70,33, 0, 0, 0, 0, 0, 0},
		{41,48,72,33,47,32,37,16,94,29, 0, 0, 0, 0, 0},
		{53,71,44,65,25,43,91,52,97,51,14, 0, 0, 0, 0},
		{70,11,33,28,77,73,17,78,39,68,17,57, 0, 0, 0},
		{91,71,52,38,17,14,91,43,58,50,27,29,48, 0, 0},
		{63,66, 4,68,89,53,67,30,73,16,69,87,40,31, 0},
		{ 4,62,98,27,23, 9,70,98,73,93,38,53,60, 4,23}
	};
	
	[pvc performSelectorOnMainThread:@selector(addToConsole:) withObject:@"Calculating..." waitUntilDone:NO];
	for (int i=13; i>=0; i--) 
	{
		for (int j=0; j<=i; j++) 
		{
			numbers[i][j] = MAX(numbers[i][j] + numbers[i+1][j], numbers[i][j] + numbers[i+1][j+1]);
		}
	}
	
	return [NSString stringWithFormat:@"%d", numbers[0][0]];
}

@end
