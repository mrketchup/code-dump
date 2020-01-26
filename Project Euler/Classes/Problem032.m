//
//  Problem032.m
//  Project Euler
//
//  Created by Matt Jones on 1/13/11.
//  Copyright 2011 Mr Mustard Media. All rights reserved.
//

#import "Problem032.h"


@implementation Problem32

- (id) init
{
	NSString *t = @"Problem 32";
	NSString *st = @"Find the sum of all numbers that can be written as "
					"pandigital products.";
	NSString *d = @"We shall say that an n-digit number is pandigital if it "
	"makes use of all the digits 1 to n exactly once; for example, the 5-digit "
	"number, 15234, is 1 through 5 pandigital.\n\nThe product 7254 is unusual, "
	"as the identity, 39 x 186 = 7254, containing multiplicand, multiplier, "
	"and product is 1 through 9 pandigital.\n\nFind the sum of all products "
	"whose multiplicand/multiplier/product identity can be written as a 1 "
	"through 9 pandigital.\n\nHint: Some products can be obtained in more than "
	"one way so be sure to only include it once in your sum.";
	self = [super initWithTitle:t subtitle:st description:d solved:YES];
	
	return self;
}

- (NSString *) solve:(ProblemViewController *)pvc
{
	[pvc performSelectorOnMainThread:@selector(addToConsole:) withObject:@"Initializing..." waitUntilDone:NO];
	int sum = 0;
	NSMutableSet *products = [[NSMutableSet alloc] init];
	NSMutableArray *permutations = [[NSMutableArray alloc] init];
	for (int b=1; b<10; b++) 
	{ 
		for (int c=1; c<10; c++) 
		{
			if (c != b) 
			{
				for (int d=1; d<10; d++) 
				{
					if (d != c && d != b) 
					{
						for (int e=1; e<10; e++) 
						{
							if (e != d && e != c && e != b) 
							{
								for (int f=1; f<10; f++) 
								{
									if (f != e && f != d && f != c && f != b) 
									{
										for (int g=1; g<10; g++) 
										{
											if (g != f && g != e && g != d && g != c && g != b) 
											{
												for (int h=1; h<10; h++) 
												{
													if (h != g && h != f && h != e && h != d && h != c && h != b) 
													{
														for (int i=1; i<10; i++) 
														{
															if (i != h && i != g && i != f && i != e && i != d && i != c && i != b) 
															{
																for (int j=1; j<10; j++) 
																{
																	if (j != i && j != h && j != g && j != f && j != e && j != d && j != c && j != b) 
																	{
																		NSString *num = [NSString stringWithFormat:@"%d%d%d%d%d%d%d%d%d",b,c,d,e,f,g,h,i,j];
																		[permutations addObject:num];
																	}
																}
															}
														}
													}
												}
											}
										}
									}
								}
							}
						}
					}
				}
			}
		}
	}
	
	[pvc performSelectorOnMainThread:@selector(addToConsole:) withObject:@"Calculating..." waitUntilDone:NO];
	for (int i=0; i<[permutations count]; i++) 
	{
		for (int i1=1; i1<8; i1++) 
		{
			for (int i2=8; i2>i1; i2--) 
			{
				NSString *n = [permutations objectAtIndex:i];
				int term1 = [[n substringToIndex:i1] intValue];
				int term2 = [[n substringWithRange:NSMakeRange(i1, i2-i1)] intValue];
				int product = [[n substringFromIndex:i2] intValue];
				
				if (term1 * term2 == product) 
				{
					[products addObject:@(product)];
				}
			}
		}
	}
	
	NSArray *p = [products allObjects];
	for (int i=0; i<[p count]; i++) 
	{
		sum += [[p objectAtIndex:i] intValue];
	}
	
	return [NSString stringWithFormat:@"%d", sum];
}

@end
