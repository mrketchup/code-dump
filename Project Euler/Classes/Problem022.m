//
//  Problem022.m
//  Project Euler
//
//  Created by Matt Jones on 12/22/10.
//  Copyright 2010 Mr Mustard Media. All rights reserved.
//

#import "Problem022.h"


@implementation Problem22

- (id) init
{
	NSString *t = @"Problem 22";
	NSString *st = @"What is the total of all the name scores in the file of "
					"first names?";
	NSString *d = @"Using names.txt, a 46K text file containing over five-"
				   "thousand first names, begin by sorting it into "
				   "alphabetical order. Then working out the alphabetical "
				   "value for each name, multiply this value by its "
				   "alphabetical position in the list to obtain a name score."
				   "\n\nFor example, when the list is sorted into alphabetical "
				   "order, COLIN, which is worth 3 + 15 + 12 + 9 + 14 = 53, is "
				   "the 938th name in the list. So, COLIN would obtain a score "
				   "of 938 x 53 = 49714.\n\n What is the total of all the name "
				   "scores in the file?";
	self = [super initWithTitle:t subtitle:st description:d solved:YES];
	
	return self;
}

- (NSString *) solve:(ProblemViewController *)pvc
{
	[pvc performSelectorOnMainThread:@selector(addToConsole:) withObject:@"Initializing..." waitUntilDone:NO];
	NSBundle *bundle = [NSBundle mainBundle];
	NSString *filePath = [bundle pathForResource:@"names" ofType:@"txt"];
	NSString *fileContents = [NSString stringWithContentsOfFile:filePath encoding:NSASCIIStringEncoding error:NULL];
	NSArray *unsortedNames = [[NSArray alloc] initWithArray:[fileContents componentsSeparatedByString:@"\",\""]];
	NSArray *names = [unsortedNames sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)];
	NSInteger overallScore = 0;
	
	[pvc performSelectorOnMainThread:@selector(addToConsole:) withObject:@"Calculating..." waitUntilDone:NO];
	for (int i=1; i<[names count]; i++) 
	{
		int nameScore = 0;
		NSString *name = [names objectAtIndex:i];
		for (int j=0; j<[name length]; j++) 
		{
			int letterScore = [name characterAtIndex:j] - 64;
			nameScore += letterScore;
		}
		int score = nameScore * i;
		overallScore += score;
	}
		
	return [NSString stringWithFormat:@"%d", overallScore];
}

@end
