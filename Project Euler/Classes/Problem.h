//
//  Problem.h
//  Project Euler
//
//  Created by Matt Jones on 12/7/10.
//  Copyright 2010 Mr Mustard Media. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Problem : NSObject 
{
	NSString *title;
	NSString *subtitle;
	NSString *description;
	BOOL isSolved;
}

@property (readonly, strong) NSString *title;
@property (readonly, strong) NSString *description;
@property (readonly, strong) NSString *subtitle;
@property (readonly) BOOL isSolved;

- (id) initWithTitle:(NSString *)t subtitle:(NSString *)st description:(NSString *)d solved:(BOOL)s;
- (NSString *) solve:(id)thing;

@end
