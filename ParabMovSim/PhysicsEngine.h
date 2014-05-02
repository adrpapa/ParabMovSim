//
//  PhysicsEngine.h
//  ParabMovSim
//
//  Created by Adriano Papa on 4/20/14.
//  Copyright (c) 2014 Adriano Papa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Vector.h"

@interface PhysicsEngine : NSObject
{
	NSString *key;
    double Vm;
    double Alpha;
    double Gamma;
    double L;
    double Yb;
    Vector *s;
    double time;
    double tInc;
    double g;
}

@property (nonatomic,strong) Vector *s;

- (id)initWithKey:(NSString*)_key andAngle:(double)angleInDegree andVelocity:(double)velocity;
- (void)update;

@end
