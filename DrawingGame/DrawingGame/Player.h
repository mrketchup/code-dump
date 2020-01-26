//
//  Player.h
//  DrawingGame
//
//  Created by Matt Jones on 5/23/13.
//  Copyright (c) 2013 Jones Brothers. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Player : NSObject

@property (nonatomic, strong, readonly) NSString *email;
@property (nonatomic, strong) NSString *username;

- (id)initWithEmail:(NSString *)email username:(NSString *)username;

@end
