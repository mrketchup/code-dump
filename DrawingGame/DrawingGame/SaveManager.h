//
//  SaveManager.h
//  DrawingGame
//
//  Created by Matt Jones on 3/15/13.
//  Copyright (c) 2013 Jones Brothers. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SaveManager : NSObject

+ (UIImage *)loadSavedImageForGame:(NSObject *)game;
+ (BOOL)saveImage:(UIImage *)image forGame:(NSObject *)game;

@end
