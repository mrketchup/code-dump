//
//  ProblemXXX.m
//  Project Euler
//
//  Created by Matt Jones on 3/4/11.
//  Copyright 2011 Mr Mustard Media. All rights reserved.
//

#import "ProblemXXX.h"


@implementation ProblemXXX

- (id) init
{
	NSString *t = @"Problem XXX";
	NSString *st = @"[Subtitle]";
	NSString *d = @"[Description]";
	self = [super initWithTitle:t subtitle:st description:d solved:NO];
	
	return self;
}

- (NSString *) solve:(ProblemViewController *)pvc
{
	[pvc performSelectorOnMainThread:@selector(addToConsole:) withObject:@"Initializing..." waitUntilDone:NO];
	
	
	[pvc performSelectorOnMainThread:@selector(addToConsole:) withObject:@"Calculating..." waitUntilDone:NO];
	
	
	return [NSString stringWithFormat:@"%d", 0];
}

@end
