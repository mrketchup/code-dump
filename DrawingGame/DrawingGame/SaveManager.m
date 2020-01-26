//
//  SaveManager.m
//  DrawingGame
//
//  Created by Matt Jones on 3/15/13.
//  Copyright (c) 2013 Jones Brothers. All rights reserved.
//

#import "SaveManager.h"

@implementation SaveManager

+ (UIImage *)loadSavedImageForGame:(NSObject *)game {
    return [UIImage imageWithContentsOfFile:[self pathToImageForGame:game]];
}

+ (BOOL)saveImage:(UIImage *)image forGame:(NSObject *)game {
	NSData *data = [NSData dataWithData:UIImagePNGRepresentation(image)];
	return [data writeToFile:[self pathToImageForGame:game] atomically:YES];
}

+ (NSString *)pathToImageForGame:(NSObject *)game {
    NSString *dir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                         NSUserDomainMask,
                                                         YES) objectAtIndex:0];
    return [NSString stringWithFormat:@"%@/cache.png", dir];
}

@end
