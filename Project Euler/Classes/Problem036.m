//
//  Problem036.m
//  Project Euler
//
//  Created by Matt Jones on 1/26/11.
//  Copyright 2011 Mr Mustard Media. All rights reserved.
//

#import "Problem036.h"


@implementation Problem36

- (id) init
{
	NSString *t = @"Problem 36";
	NSString *st = @"Find the sum of all numbers less than one million, which "
					"are palindromic in base 10 and base 2.";
	NSString *d = @"The decimal number, 585 = 1001001001 (binary), is "
				   "palindromic in both bases.\n\nFind the sum of all numbers, "
				   "less than one million, which are palindromic in base 10 "
				   "and base 2.\n\n(Please note that the palindromic number, "
				   "in either base, may not include leading zeros.)";
	self = [super initWithTitle:t subtitle:st description:d solved:YES];
	
	return self;
}

- (NSString *) solve:(ProblemViewController *)pvc
{
	[pvc performSelectorOnMainThread:@selector(addToConsole:) withObject:@"Initializing..." waitUntilDone:NO];
	int sum = 0;
	NSMutableArray *binaries = [[NSMutableArray alloc] init];
	for (int i=0; i<1000000; i++) 
	{
		[binaries addObject:[self baseTwo:i]];
	}
	
	[pvc performSelectorOnMainThread:@selector(addToConsole:) withObject:@"Calculating..." waitUntilDone:NO];
	for (int i=1; i<1000000; i++) 
	{
		if ([self isPalindrome:[NSString stringWithFormat:@"%d",i]] && [self isPalindrome:[binaries objectAtIndex:i]]) 
		{
			sum += i;
		}
	}
	
	return [NSString stringWithFormat:@"%d", sum];
}

- (NSString *) baseTwo:(int)n
{
	if (n == 0) 
	{
		return @"0";
	}
	
	NSString *b = @"";
	while (n > 0) 
	{
		int i = n % 2;
		b = [NSString stringWithFormat:@"%d%@",i,b];
		n /= 2;
	}
	
	return b;
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
