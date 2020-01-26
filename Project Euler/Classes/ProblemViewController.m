//
//  ProblemSubView.m
//  Project Euler
//
//  Created by Matt Jones on 12/5/10.
//  Copyright 2010 Mr Mustard Media. All rights reserved.
//

#import "ProblemViewController.h"

@implementation ProblemViewController

@synthesize console, problem, execute, wheel, description;

- (id) initWithProblem:(Problem *)p
{
	self = [super init];
	if (self != nil) {
		self.title = NSLocalizedString(p.title, @"");
        problem = p;
	}
	
	return self;
}

- (IBAction) solve
{	
	console.text = @"Performing solution...";
	[NSThread detachNewThreadSelector:@selector(solutionBegin) toTarget:self withObject:nil];
	[NSThread detachNewThreadSelector:@selector(solution) toTarget:self	withObject:nil];
}

- (void) addToConsole:(NSString *)s
{
	console.text = [NSString stringWithFormat:@"%@\n%@",console.text,s];
}

- (void) solutionBegin
{
	execute.hidden = YES;
	[wheel startAnimating];
}

- (void) solution
{
	@autoreleasepool {
		NSDate *start = [NSDate date];
		NSString *solution = [problem solve:self];
		NSDate *finish = [NSDate date];
		NSTimeInterval elapsed = [finish timeIntervalSinceDate:start];
		NSString *temp = [NSString stringWithFormat:@"Done! (%f s)\n\nSolution: %@",
						  elapsed, solution];
		[self performSelectorOnMainThread:@selector(addToConsole:) withObject:temp waitUntilDone:YES];
		[wheel stopAnimating];
		execute.hidden = NO;
	}
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidLoad
{
	description.text = problem.description;
	console.font = [UIFont fontWithName:@"Courier-Bold" size:16.0]; 
}

- (void)viewDidUnload {
    [super viewDidUnload];
}


@end