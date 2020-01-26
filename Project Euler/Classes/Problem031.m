//
//  Problem031.m
//  Project Euler
//
//  Created by Matt Jones on 1/12/11.
//  Copyright 2011 Mr Mustard Media. All rights reserved.
//

#import "Problem031.h"


@implementation Problem31

- (id) init
{
	NSString *t = @"Problem 31";
	NSString *st = @"Investigating combinations of English currency "
					"denominations.";
	NSString *d = @"In England the currency is made up of Pound, £, and pence, "
				   "p, and there are eight coins in general circulation:\n\n\t"
				   "1p, 2p, 5p, 10p, 20p, 50p, £1 (100p), £2 (200p).\n\nIt is "
				   "possible to make £2 in the following way:\n\n\t1x£1 + "
				   "1x50p + 2x20p + 1x5p + 1x2p + 3x1p\n\nHow many different "
				   "ways can £2 be made using any number of coins?";
	self = [super initWithTitle:t subtitle:st description:d solved:YES];
	
	return self;
}

- (NSString *) solve:(ProblemViewController *)pvc
{
	[pvc performSelectorOnMainThread:@selector(addToConsole:) withObject:@"Initializing..." waitUntilDone:NO];
	const int GOAL = 200;
	int amounts[8] = {200, 100, 50, 20, 10, 5, 2, 1};
	int maxCounts[8];
	for (int i=0; i<8; i++) 
	{
		maxCounts[i] = GOAL / amounts[i];
	}
	int count = 0;
	
	[pvc performSelectorOnMainThread:@selector(addToConsole:) withObject:@"Calculating..." waitUntilDone:NO];	
	int sum = 0;
	for (int i=0; i<=maxCounts[0]; i++) 
	{
		for (int j=0; j<=maxCounts[1]; j++) 
		{
			for (int k=0; k<=maxCounts[2]; k++) 
			{
				for (int l=0; l<=maxCounts[3]; l++) 
				{
					for (int m=0; m<=maxCounts[4]; m++) 
					{
						for (int n=0; n<=maxCounts[5]; n++) 
						{
							for (int o=0; o<=maxCounts[6]; o++) 
							{
								for (int p=0; p<=maxCounts[7] && sum<GOAL; p++) 
								{
									sum = i * amounts[0];
									sum += j * amounts[1];
									sum += k * amounts[2];
									sum += l * amounts[3];
									sum += m * amounts[4];
									sum += n * amounts[5];
									sum += o * amounts[6];
									sum += p * amounts[7];
									
									if (sum == GOAL) 
									{
										count++;
									}
								}
								sum = 0;
							}
						}
					}
				}
			}
		}
	}
	
	return [NSString stringWithFormat:@"%d", count];
}

@end
