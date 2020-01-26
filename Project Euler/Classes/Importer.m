//
//  Importer.m
//  Project Euler
//
//  Created by Matt Jones on 12/7/10.
//  Copyright 2010 Mr Mustard Media. All rights reserved.
//

#import "Importer.h"


@implementation Importer

+ (NSMutableArray *) getProblems
{
	NSMutableArray *probs = [[NSMutableArray alloc] initWithObjects:
							 
							 [[Problem1 alloc] init],
							 [[Problem2 alloc] init],
							 [[Problem3 alloc] init],
							 [[Problem4 alloc] init],
							 [[Problem5 alloc] init],
							 [[Problem6 alloc] init],
							 [[Problem7 alloc] init],
							 [[Problem8 alloc] init],
							 [[Problem9 alloc] init],
							 [[Problem10 alloc] init],
							 [[Problem11 alloc] init],
							 [[Problem12 alloc] init],
							 [[Problem13 alloc] init],
							 [[Problem14 alloc] init],
							 [[Problem15 alloc] init],
							 [[Problem16 alloc] init],
							 [[Problem17 alloc] init],
							 [[Problem18 alloc] init],
							 [[Problem19 alloc] init],
							 [[Problem20 alloc] init],
							 [[Problem21 alloc] init],
							 [[Problem22 alloc] init],
							 [[Problem23 alloc] init],
							 [[Problem24 alloc] init],
							 [[Problem25 alloc] init],
							 [[Problem26 alloc] init],
							 [[Problem27 alloc] init],
							 [[Problem28 alloc] init],
							 [[Problem29 alloc] init],
							 [[Problem30 alloc] init],
							 [[Problem31 alloc] init],
							 [[Problem32 alloc] init],
							 [[Problem33 alloc] init],
							 [[Problem34 alloc] init],
							 [[Problem35 alloc] init],
							 [[Problem36 alloc] init],
							 [[Problem37 alloc] init],
							 [[Problem38 alloc] init],
							 [[Problem39 alloc] init],
							 [[Problem40 alloc] init],
							 //...
							 //[[ProblemN alloc] init],
							 nil];
	
	return probs;
}

+ (NSMutableArray *) getSolved
{
	NSMutableArray *probs = [self getProblems];
	
	NSMutableArray *solved = [[NSMutableArray alloc] init];
	
	for (int i=0; i<[probs count]; i++) 
	{
		Problem *p = [probs objectAtIndex:i];
		if (p.isSolved == YES)
		{
			[solved addObject:[probs objectAtIndex:i]];
		}
	}
	
	return solved;
}

+ (NSMutableArray *) getUnsolved
{
	NSMutableArray *probs = [self getProblems];
	
	NSMutableArray *unsolved = [[NSMutableArray alloc] init];
	
	for (int i=0; i<[probs count]; i++) 
	{
		Problem *p = [probs objectAtIndex:i];
		if (p.isSolved == NO)
		{
			[unsolved addObject:[probs objectAtIndex:i]];
		}
	}
	
	return unsolved;
}

@end
