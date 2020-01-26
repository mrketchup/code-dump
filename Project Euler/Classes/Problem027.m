//
//  Problem027.m
//  Project Euler
//
//  Created by Matt Jones on 1/3/11.
//  Copyright 2011 Mr Mustard Media. All rights reserved.
//

#import "Problem027.h"


@implementation Problem27

- (id) init
{
	NSString *t = @"Problem 27";
	NSString *st = @"Find a quadratic formula that produces the maximum number "
					"of primes for consecutive values of n.";
	NSString *d = @"Euler published the remarkable quadratic formula:\n"
	"\n\tn^2 + n + 41\n\nIt turns out that the formula will produce 40 primes "
	"for the consecutive values n = 0 to 39. However, when n = 40, 40^2 + 40 + "
	"41 = 40(40 + 1) + 41 is divisible by 41, and certainly when n = 41, 41^2 "
	"+ 41 + 41is clearly divisible by 41.\n\nUsing computers, the incredible "
	"formula n^2 - 79n + 1601 was discovered, which produces 80 primes for the "
	"consecutive values n = 0 to 79. The product of the coefficients, -79 and "
	"1601, is -126479.\n\nConsidering quadratics of the form:\n\n\tn^2 + an + "
	"b, where |a| < 1000 and |b| < 1000\n\nFind the product of the "
	"coefficients, a and b, for the quadratic expression that produces the "
	"maximum number of primes for consecutive values of n, starting with n=0.";
	self = [super initWithTitle:t subtitle:st description:d solved:YES];
	
	return self;
}

- (NSString *) solve:(ProblemViewController *)pvc
{
	[pvc performSelectorOnMainThread:@selector(addToConsole:) withObject:@"Initializing..." waitUntilDone:NO];
	int product = 0;
	int maxChain = 0;
	NSMutableArray *primes = [[NSMutableArray alloc] init];
	[primes addObject:@2];
	[primes addObject:@-2];
	for (int i=3; i<1000; i+=2) 
	{
		if ([self isPrime:i]) 
		{
			[primes addObject:@(i)];
			[primes addObject:@(-1*i)];
		}
	}
	
	[pvc performSelectorOnMainThread:@selector(addToConsole:) withObject:@"Calculating..." waitUntilDone:NO];
	for (int i=0; i<[primes count]; i++) 
	{
		int a = [[primes objectAtIndex:i] intValue];
		for (int j=0; j<[primes count]; j++)
		{
			int b = [[primes objectAtIndex:j] intValue];
			int chain = [self chain:a and:b];
			if (chain > maxChain) 
			{
				product = a * b;
				maxChain = chain;
			}
		}
	}
	
	return [NSString stringWithFormat:@"%d", product];
}

- (BOOL) isPrime:(int)n
{
	n = abs(n);
	for (int i=2; i<n/2; i++) 
	{
		if (n % i == 0) 
		{
			return NO;
		}
	}
	
	return YES;
}

- (int) chain:(int)a and:(int)b
{
	int n = 0;
	int quad = pow(n, 2) + a * n + b;
	while ([self isPrime:quad]) 
	{
		n++;
		quad = pow(n, 2) + a * n + b;
	}
	
	return n;
}

@end
