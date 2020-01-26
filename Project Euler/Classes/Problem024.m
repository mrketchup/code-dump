//
//  Problem024.m
//  Project Euler
//
//  Created by Matt Jones on 12/22/10.
//  Copyright 2010 Mr Mustard Media. All rights reserved.
//

#import "Problem024.h"


@implementation Problem24

- (id) init
{
	NSString *t = @"Problem 24";
	NSString *st = @"What is the millionth lexicographic permutation of the "
					"digits 0, 1, 2, 3, 4, 5, 6, 7, 8 and 9?";
	NSString *d = @"A permutation is an ordered arrangement of objects. For "
				   "example, 3124 is on possible permutation of the digits 1, "
				   "2, 3 and 4. If all the permutations are listed numerically "
				   "or alphabetically, we call it lexicographic order. The "
				   "lexocographic permutations of 0, 1 and 2 are:\n\n\t012 021 "
				   "102 120 201 210\n\nWhat is the millionth lexicographic "
				   "permutation of the digits 0, 1, 2, 3, 4, 5, 6, 7, 8 and 9?";
	self = [super initWithTitle:t subtitle:st description:d solved:YES];
	
	return self;
}

- (NSString *) solve:(ProblemViewController *)pvc
{
	[pvc performSelectorOnMainThread:@selector(addToConsole:) withObject:@"Initializing..." waitUntilDone:NO];
	NSMutableArray *permutations = [[NSMutableArray alloc] init];
	
	[pvc performSelectorOnMainThread:@selector(addToConsole:) withObject:@"Calculating..." waitUntilDone:NO];
	for (int a=0; a<10; a++) 
	{
		for (int b=0; b<10; b++) 
		{
			if (b != a) 
			{
				for (int c=0; c<10; c++) 
				{
					if (c != b && c != a) 
					{
						for (int d=0; d<10; d++) 
						{
							if (d != c && d != b && d != a) 
							{
								for (int e=0; e<10; e++) 
								{
									if (e != d && e != c && e != b && e != a) 
									{
										for (int f=0; f<10; f++) 
										{
											if (f != e && f != d && f != c && f != b && f != a) 
											{
												for (int g=0; g<10; g++) 
												{
													if (g != f && g != e && g != d && g != c && g != b && g != a) 
													{
														for (int h=0; h<10; h++) 
														{
															if (h != g && h != f && h != e && h != d && h != c && h != b && h != a) 
															{
																for (int i=0; i<10; i++) 
																{
																	if (i != h && i != g && i != f && i != e && i != d && i != c && i != b && i != a) 
																	{
																		for (int j=0; j<10; j++) 
																		{
																			if (j != i && j != h && j != g && j != f && j != e && j != d && j != c && j != b && j != a) 
																			{
																				long long int x;
																				x  = a * 1000000000;
																				x += b * 100000000;
																				x += c * 10000000;
																				x += d * 1000000;
																				x += e * 100000;
																				x += f * 10000;
																				x += g * 1000;
																				x += h * 100;
																				x += i * 10;
																				x += j;
																				[permutations addObject:@(x)];																			}
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
	}
	
	return [NSString stringWithFormat:@"%qi", [[permutations objectAtIndex:999999] longLongValue]];
}

@end
