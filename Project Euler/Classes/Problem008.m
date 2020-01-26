//
//  Problem8.m
//  Project Euler
//
//  Created by Matt Jones on 12/9/10.
//  Copyright 2010 Mr Mustard Media. All rights reserved.
//

#import "Problem008.h"


@implementation Problem8

- (id) init
{
	NSString *t = @"Problem 8";
	NSString *st = @"Discover the largest product of five consecutive digits "
					"in the 1000-digit number.";
	NSString *d = @"Find the greatest product of five consecutive digits in "
				   "the 1000-digit number.\n\n"
				   "\t731671765313306249192251196\n"
				   "\t744265747423553491949349698\n"
				   "\t352031277450632623957831801\n"
				   "\t698480186947885184385861560\n"
				   "\t789112949495459501737958331\n"
				   "\t952853208805511125406987471\n"
				   "\t585238630507156932909632952\n"
				   "\t274430435576689664895044524\n"
				   "\t452316173185640309871112172\n"
				   "\t238311362229893423380308135\n"
				   "\t336276614282806444486645238\n"
				   "\t749303589072962904915604407\n"
				   "\t723907138105158593079608667\n"
				   "\t017242712188399879790879227\n"
				   "\t492190169972088809377665727\n"
				   "\t333001053367881220235421809\n"
				   "\t751254540594752243525849077\n"
				   "\t116705560136048395864467063\n"
				   "\t244157221553975369781797784\n"
				   "\t617406495514929086256932197\n"
				   "\t846862248283972241375657056\n"
				   "\t057490261407972968652414535\n"
				   "\t100474821663704844031998900\n"
				   "\t088952434506585412275886668\n"
				   "\t811642717147992444292823086\n"
				   "\t346567481391912316282458617\n"
				   "\t866458359124566529476545682\n"
				   "\t848912883142607690042242190\n"
				   "\t226710556263211111093705442\n"
				   "\t175069416589604080719840385\n"
				   "\t096245544436298123098787992\n"
				   "\t724428490918884580156166097\n"
				   "\t919133875499200524063689912\n"
				   "\t560717606058861164671094050\n"
				   "\t775410022569831552000559357\n"
				   "\t297257163626956188267042825\n"
				   "\t248360082325753042075296345\n"
				   "\t0";
	self = [super initWithTitle:t subtitle:st description:d solved:YES];
	
	return self;
}

- (NSString *) solve:(ProblemViewController *)pvc
{	
	[pvc performSelectorOnMainThread:@selector(addToConsole:) withObject:@"Initializing..." waitUntilDone:NO];
	NSInteger max = 0;
	NSString *bigNum = @"731671765313306249192251196744265747423553491949349698"
	"35203127745063262395783180169848018694788518438586156078911294949545950173"
	"79583319528532088055111254069874715852386305071569329096329522744304355766"
	"89664895044524452316173185640309871112172238311362229893423380308135336276"
	"61428280644448664523874930358907296290491560440772390713810515859307960866"
	"70172427121883998797908792274921901699720888093776657273330010533678812202"
	"35421809751254540594752243525849077116705560136048395864467063244157221553"
	"97536978179778461740649551492908625693219784686224828397224137565705605749"
	"02614079729686524145351004748216637048440319989000889524345065854122758866"
	"68811642717147992444292823086346567481391912316282458617866458359124566529"
	"47654568284891288314260769004224219022671055626321111109370544217506941658"
	"96040807198403850962455444362981230987879927244284909188845801561660979191"
	"33875499200524063689912560717606058861164671094050775410022569831552000559"
	"3572972571636269561882670428252483600823257530420752963450";
	
	[pvc performSelectorOnMainThread:@selector(addToConsole:) withObject:@"Calculating..." waitUntilDone:NO];
	for (int i=0; i<[bigNum length]-5; i++) 
	{
		NSInteger n1 = [@((char)[bigNum characterAtIndex:i]) intValue] - 48;
		NSInteger n2 = [@((char)[bigNum characterAtIndex:i+1]) intValue] - 48;
		NSInteger n3 = [@((char)[bigNum characterAtIndex:i+2]) intValue] - 48;
		NSInteger n4 = [@((char)[bigNum characterAtIndex:i+3]) intValue] - 48;
		NSInteger n5 = [@((char)[bigNum characterAtIndex:i+4]) intValue] - 48;
		
		NSInteger product = n1 * n2 * n3 * n4 * n5;
		
		if (product > max) 
		{
			max = product;
		}
	}
	
	return [NSString stringWithFormat:@"%d", max];
}

@end