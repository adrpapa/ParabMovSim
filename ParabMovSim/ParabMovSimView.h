//
//  ParabMovSimView.h
//  ParabMovSim
//
//  Created by Adriano Papa on 4/19/14.
//  Copyright (c) 2014 Adriano Papa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PhysicsEngine.h"

@protocol ParabMovSimViewDelegate;

@interface ParabMovSimView : UIView
{
    id <ParabMovSimViewDelegate> delegate;
    NSMutableDictionary *ballViewDict;
    NSInteger ballCount;
    CALayer *lastLayer;
    CGFloat lineLen;
    CGFloat lineAngle;
    BOOL startSimulator;
}

@property (strong,nonatomic) id <ParabMovSimViewDelegate> delegate;

- (void)updateViewWithKey:(NSString*)key withPoint:(CGPoint)applePos;

@end

@protocol ParabMovSimViewDelegate

- (void)addPhysicsEngine:(PhysicsEngine*)_physicsEngine withKey:(NSString*)key;
- (void)removePhysicsEngine:(NSString*)key;
- (void)stop;

@end