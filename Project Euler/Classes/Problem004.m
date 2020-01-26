//
//  Problem4.m
//  Project Euler
//
//  Created by Matt Jones on 12/9/10.
//  Copyright 2010 Mr Mustard Media. All rights reserved.
//

#import "Problem004.h"


@implementation Problem4

- (id) init
{
	NSString *t = @"Problem 4";
	NSString *st = @"Find the largest palindrome made from the product of two "
					"3-digit numbers.";
	NSString *d = @"A palindromic number reads the same both ways. The largest "
				   "palindrome made from the product of two 2-digit numbers is "
				   "9009 = 91 x 99.\n\nFind the largest palindrome made from "
				   "the product of two 3-digit numbers.";
	self = [super initWithTitle:t subtitle:st description:d solved:YES];
	
	return self;
}

- (NSString *) solve:(ProblemViewController *)pvc
{
	[pvc performSelectorOnMainThread:@selector(addToConsole:) withObject:@"Initializing..." waitUntilDone:NO];
	NSInteger max = 0;
	
	[pvc performSelectorOnMainThread:@selector(addToConsole:) withObject:@"Calculating..." waitUntilDone:NO];
	for (int i=999; i>99; i--) 
	{
		for (int j=i; j>99; j--) 
		{
			if ([self isPalindrome:[NSString stringWithFormat:@"%d", (i * j)]]) 
			{
				if (i * j > max) 
				{
					max = i * j;
				}
			}
		}
	}
	
	return [NSString stringWithFormat:@"%d", max];
}

- (BOOL) isPalindrome:(NSString *)n
{	
	unichar first = [n characterAtIndex:0];
	unichar last = [n characterAtIndex:[n length] - 1];
	
	if ([n length] > 3) 
	{
		NSString *sub = [n substringToIndex:[n length] - 1];
		sub = [sub substringFromIndex:1];
		return (first == last) && [self isPalindrome:sub];
	}
	
	return first == last;
}

@end
