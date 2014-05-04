//
//  PhysicsEngine.h
//  ParabMovSim
//
//  Created by Adriano Papa on 5/4/14.
//  Copyright (c) 2014 Adriano Papa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Entity.h"

@interface PhysicsEngine : NSObject
{
    NSMutableDictionary *entityDict;
}

@property (strong,nonatomic) NSMutableDictionary *entityDict;

- (void)update;

@end
