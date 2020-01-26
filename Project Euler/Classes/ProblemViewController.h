//
//  ProblemSubView.h
//  Project Euler
//
//  Created by Matt Jones on 12/5/10.
//  Copyright 2010 Mr Mustard Media. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Problem.h"


@interface ProblemViewController : UIViewController 
{
	IBOutlet UITextView *console;
	IBOutlet UITextView *description;
	IBOutlet UIButton *execute;
	IBOutlet UIActivityIndicatorView *wheel;
	Problem *problem;
}

@property (strong, nonatomic) IBOutlet UITextView *console;
@property (strong, nonatomic) IBOutlet UITextView *description;
@property (strong, nonatomic) IBOutlet UIButton *execute;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *wheel;
@property (strong, nonatomic) Problem *problem;

- (id) initWithProblem:(Problem *)p;
- (IBAction) solve;

@end