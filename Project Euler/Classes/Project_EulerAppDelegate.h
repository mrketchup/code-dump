//
//  Project_EulerAppDelegate.h
//  Project Euler
//
//  Created by Matt Jones on 12/3/10.
//  Copyright 2010 Mr Mustard Media. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Project_EulerAppDelegate : NSObject <UIApplicationDelegate> {
    
    UIWindow *window;
    UINavigationController *navigationController;
}

@property (nonatomic, strong) IBOutlet UIWindow *window;
@property (nonatomic, strong) IBOutlet UINavigationController *navigationController;

@end