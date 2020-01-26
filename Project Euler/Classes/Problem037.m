//
//  Problem037.m
//  Project Euler
//
//  Created by Matt Jones on 1/26/11.
//  Copyright 2011 Mr Mustard Media. All rights reserved.
//

#import "Problem037.h"


@implementation Problem37

- (id) init
{
	NSString *t = @"Problem 37";
	NSString *st = @"Find the sum of all eleven primes that are both "
					"truncatable from left to right and right to left.";
	NSString *d = @"The number 3797 has an interesting property. Being prime "
	"itself, it is possible to continuously remove digits from left to right, "
	"and remain prime at each stage: 3797, 797, 97, and 7. Similarly we can "
	"work from right to left: 3797, 379, 37, and 3.\n\nFind the sum of the "
	"only eleven primes that are both truncatable from left to right and right "
	"to left.\n\nNOTE: 2, 3, 5, and 7 are not considered to be truncatable primes.";
	self = [super initWithTitle:t subtitle:st description:d solved:YES];
	
	return self;
}

- (NSString *) solve:(ProblemViewController *)pvc
{
	[pvc performSelectorOnMainThread:@selector(addToConsole:) withObject:@"Initializing..." waitUntilDone:NO];
	NSMutableArray *primes = [self getPrimesTo:100000];
	[primes addObject:@739397];
	NSInteger sum = 0;
	NSInteger count = 0;
	
	[pvc performSelectorOnMainThread:@selector(addToConsole:) withObject:@"Calculating..." waitUntilDone:NO];
	for (int i=4; i<[primes count] && count<11; i++)
	{
		NSInteger n = [[primes objectAtIndex:i] intValue];
		
		if ([self isTruncatableRight:n primes:primes] && [self isTruncatableLeft:n primes:primes])
		{
			sum += n;
			count++;
		}
	}
	
	return [NSString stringWithFormat:@"%d", sum];
}

- (NSMutableArray *) getPrimesTo:(int)n
{
	if (n <= 0) 
	{
		n = 1;
	}
	int size = n + 1;
	bool prime[size];
	for (int i=0; i<size; i++) 
	{
		prime[i] = true;
	}
	prime[0] = false;
	prime[1] = false;
	
	for (int i=2; i<size; i++)
	{
		if (prime[i])
		{
			for (int j=i+i; j<size; j+=i) 
			{
				prime[j] = false;
			}
		}
	}
	
	NSMutableArray *list = [[NSMutableArray alloc] init];
	for (int i=2; i<size; i++)
	{
		if (prime[i])
		{
			[list addObject:@(i)];
		}
	}
	
	return list;
}

- (NSMutableArray *) addNextPrime:(NSMutableArray *)list
{
	NSInteger n = [[list objectAtIndex:[list count] - 1] intValue];
	BOOL isNextPrime = NO;
	while (!isNextPrime)
	{
		n++;
		BOOL isPrime = YES;
		for (int i=0; i<[list count]; i++)
		{
			if (n % [[list objectAtIndex:i] intValue] == 0) 
			{
				isPrime = NO;
				i = [list count];
			}
		}
		isNextPrime = isPrime;
	}
	
	
	[list addObject:@(n)];
	return list;
}

- (BOOL) isTruncatableRight:(NSInteger)num primes:(NSMutableArray *)p
{
	int n = num / 10;
	BOOL answer = YES;
	
	while (n > 0) 
	{
		if (![p containsObject:@(n)])
		{
			answer = NO;
			n = 0;
		}
		
		n /= 10;
	}
	
	return answer;
}

- (BOOL) isTruncatableLeft:(NSInteger)num primes:(NSMutableArray *)p
{
	int mod = 1000000;
	BOOL answer = YES;
	
	while (mod > 1) 
	{
		int temp = num % mod;
		if (![p containsObject:@(temp)])
		{
			answer = NO;
			mod = 0;
		}
		
		mod /= 10;
	}
	
	return answer;
}

@end
