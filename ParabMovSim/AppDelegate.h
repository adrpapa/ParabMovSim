//
//  AppDelegate.h
//  ParabMovSim
//
//  Created by Adriano Papa on 4/18/14.
//  Copyright (c) 2014 Adriano Papa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ParabMovSimViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    ParabMovSimViewController *viewController;
}

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) ParabMovSimViewController *viewController;

@end
