//
//  Problem.m
//  Project Euler
//
//  Created by Matt Jones on 12/7/10.
//  Copyright 2010 Mr Mustard Media. All rights reserved.
//

#import "Problem.h"


@implementation Problem

@synthesize title, subtitle, description, isSolved;

- (id) initWithTitle:(NSString *)t subtitle:(NSString *)st description:(NSString *)d solved:(BOOL)s 
{
	title = t;
	subtitle = st;
	description = d;
	isSolved = s;
	return self;
}

- (NSString *) solve:(id)thing
{
	return @"0";
}

@end
