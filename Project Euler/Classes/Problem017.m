//
//  Problem017.m
//  Project Euler
//
//  Created by Matt Jones on 12/19/10.
//  Copyright 2010 Mr Mustard Media. All rights reserved.
//

#import "Problem017.h"


@implementation Problem17

- (id) init
{
	NSString *t = @"Problem 17";
	NSString *st = @"How many letters would be needed to write all the numbers "
					"in words from 1 to 1000?";
	NSString *d = @"If the numbers 1 to 5 are written out in words: one, two, "
				   "three, four, five, then there are 3 + 3 + 5 + 4 + 4 = 19 "
				   "letters used in total.\n\nIf all the numbers from 1 to "
				   "1000 (one thousand) inclusive were written out in words, "
				   "how many letters would be used?\n\nNOTE: Do not count "
				   "spaces or hyphens. For example, 342 (three hundred and "
				   "forty-two) contains 23 letters and 115 (one hundred and "
				   "fifteen) contains 20 letters. The use of \"and\" when "
				   "writing out numbers is in compliance with British usage.";
	self = [super initWithTitle:t subtitle:st description:d solved:YES];
	
	return self;
}

- (NSString *) solve:(ProblemViewController *)pvc
{	
	[pvc performSelectorOnMainThread:@selector(addToConsole:) withObject:@"Initializing..." waitUntilDone:NO];
	NSString *longAssWord = @"onethousand";
	NSString *number = [[NSString alloc] init];
	
	[pvc performSelectorOnMainThread:@selector(addToConsole:) withObject:@"Calculating..." waitUntilDone:NO];
	for (int i=999; i>99; i--) 
	{
		int digit1 = i / 100;
		switch (digit1) 
		{
			case 9:
				number = @"ninehundred";
				break;
			case 8:
				number = @"eighthundred";
				break;
			case 7:
				number = @"sevenhundred";
				break;
			case 6:
				number = @"sixhundred";
				break;
			case 5:
				number = @"fivehundred";
				break;
			case 4:
				number = @"fourhundred";
				break;
			case 3:
				number = @"threehundred";
				break;
			case 2:
				number = @"twohundred";
				break;
			case 1:
				number = @"onehundred";
			default:
				break;
		}
		
		int digit2 = (i / 10) % 10;
		switch (digit2) 
		{
			case 9:
				number = [NSString stringWithFormat:@"%@%@",number,@"andninety"];
				break;
			case 8:
				number = [NSString stringWithFormat:@"%@%@",number,@"andeighty"];
				break;
			case 7:
				number = [NSString stringWithFormat:@"%@%@",number,@"andseventy"];
				break;
			case 6:
				number = [NSString stringWithFormat:@"%@%@",number,@"andsixty"];
				break;
			case 5:
				number = [NSString stringWithFormat:@"%@%@",number,@"andfifty"];
				break;
			case 4:
				number = [NSString stringWithFormat:@"%@%@",number,@"andforty"];
				break;
			case 3:
				number = [NSString stringWithFormat:@"%@%@",number,@"andthirty"];
				break;
			case 2:
				number = [NSString stringWithFormat:@"%@%@",number,@"andtwenty"];
				break;
			case 0:
				if (i % 10 != 0) 
				{
					number = [NSString stringWithFormat:@"%@%@",number,@"and"];
				}
			default:
				break;
		}
		
		int digit3 = i % 10;
		if (digit2 == 1) 
		{
			switch (digit3) 
			{
				case 9:
					number = [NSString stringWithFormat:@"%@%@",number,@"andnineteen"];
					break;
				case 8:
					number = [NSString stringWithFormat:@"%@%@",number,@"andeighteen"];
					break;
				case 7:
					number = [NSString stringWithFormat:@"%@%@",number,@"andseventeen"];
					break;
				case 6:
					number = [NSString stringWithFormat:@"%@%@",number,@"andsixteen"];
					break;
				case 5:
					number = [NSString stringWithFormat:@"%@%@",number,@"andfifteen"];
					break;
				case 4:
					number = [NSString stringWithFormat:@"%@%@",number,@"andfourteen"];
					break;
				case 3:
					number = [NSString stringWithFormat:@"%@%@",number,@"andthirteen"];
					break;
				case 2:
					number = [NSString stringWithFormat:@"%@%@",number,@"andtwelve"];
					break;
				case 1:
					number = [NSString stringWithFormat:@"%@%@",number,@"andeleven"];
					break;
				case 0:
					number = [NSString stringWithFormat:@"%@%@",number,@"andten"];
				default:
					break;
			}
		}
		else 
		{
			switch (digit3) 
			{
				case 9:
					number = [NSString stringWithFormat:@"%@%@",number,@"nine"];
					break;
				case 8:
					number = [NSString stringWithFormat:@"%@%@",number,@"eight"];
					break;
				case 7:
					number = [NSString stringWithFormat:@"%@%@",number,@"seven"];
					break;
				case 6:
					number = [NSString stringWithFormat:@"%@%@",number,@"six"];
					break;
				case 5:
					number = [NSString stringWithFormat:@"%@%@",number,@"five"];
					break;
				case 4:
					number = [NSString stringWithFormat:@"%@%@",number,@"four"];
					break;
				case 3:
					number = [NSString stringWithFormat:@"%@%@",number,@"three"];
					break;
				case 2:
					number = [NSString stringWithFormat:@"%@%@",number,@"two"];
					break;
				case 1:
					number = [NSString stringWithFormat:@"%@%@",number,@"one"];
				default:
					break;
			}
		}
		longAssWord = [NSString stringWithFormat:@"%@%@",longAssWord,number];
	}
	
	for (int i=99; i>9; i--) 
	{
		int digit1 = i / 10;
		switch (digit1) 
		{
			case 9:
				number = @"ninety";
				break;
			case 8:
				number = @"eighty";
				break;
			case 7:
				number = @"seventy";
				break;
			case 6:
				number = @"sixty";
				break;
			case 5:
				number = @"fifty";
				break;
			case 4:
				number = @"forty";
				break;
			case 3:
				number = @"thirty";
				break;
			case 2:
				number = @"twenty";
				break;
			default:
				break;
		}
		
		int digit2 = i % 10;
		if (digit1 == 1) 
		{
			switch (digit2) 
			{
				case 9:
					number = @"nineteen";
					break;
				case 8:
					number = @"eighteen";
					break;
				case 7:
					number = @"seventeen";
					break;
				case 6:
					number = @"sixteen";
					break;
				case 5:
					number = @"fifteen";
					break;
				case 4:
					number = @"fourteen";
					break;
				case 3:
					number = @"thirteen";
					break;
				case 2:
					number = @"twelve";
					break;
				case 1:
					number = @"eleven";
					break;
				case 0:
					number = @"ten";
				default:
					break;
			}
		}
		else 
		{
			switch (digit2) 
			{
				case 9:
					number = [NSString stringWithFormat:@"%@%@",number,@"nine"];
					break;
				case 8:
					number = [NSString stringWithFormat:@"%@%@",number,@"eight"];
					break;
				case 7:
					number = [NSString stringWithFormat:@"%@%@",number,@"seven"];
					break;
				case 6:
					number = [NSString stringWithFormat:@"%@%@",number,@"six"];
					break;
				case 5:
					number = [NSString stringWithFormat:@"%@%@",number,@"five"];
					break;
				case 4:
					number = [NSString stringWithFormat:@"%@%@",number,@"four"];
					break;
				case 3:
					number = [NSString stringWithFormat:@"%@%@",number,@"three"];
					break;
				case 2:
					number = [NSString stringWithFormat:@"%@%@",number,@"two"];
					break;
				case 1:
					number = [NSString stringWithFormat:@"%@%@",number,@"one"];
				default:
					break;
			}
		}
		longAssWord = [NSString stringWithFormat:@"%@%@",longAssWord,number];
	}
	
	for (int i=9; i>0; i--) 
	{
		switch (i) 
		{
			case 9:
				number = @"nine";
				break;
			case 8:
				number = @"eight";
				break;
			case 7:
				number = @"seven";
				break;
			case 6:
				number = @"six";
				break;
			case 5:
				number = @"five";
				break;
			case 4:
				number = @"four";
				break;
			case 3:
				number = @"three";
				break;
			case 2:
				number = @"two";
				break;
			case 1:
				number = @"one";
			default:
				break;
		}
		longAssWord = [NSString stringWithFormat:@"%@%@",longAssWord,number];
	}
	
	return [NSString stringWithFormat:@"%d", [longAssWord length]];
}

@end
