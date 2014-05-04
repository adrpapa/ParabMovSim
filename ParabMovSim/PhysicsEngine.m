//
//  PhysicsEngine.m
//  ParabMovSim
//
//  Created by Adriano Papa on 5/4/14.
//  Copyright (c) 2014 Adriano Papa. All rights reserved.
//

#import "PhysicsEngine.h"

@implementation PhysicsEngine

@synthesize entityDict;

- (id)init
{
    self = [super init];
    
    if (self)
    {
		entityDict = [NSMutableDictionary dictionaryWithCapacity:5];
    }
    
    return self;
}

- (void)addEntity:(Entity*)_entity withKey:(NSString*)key
{
	[entityDict setValue:_entity forKey:key];
}

- (void)removeEntity:(NSString*)key
{
	[entityDict removeObjectForKey:key];
}

- (void)update
{
	[entityDict enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        // Get the Entity object
		Entity *entityObj = (Entity*) obj;
        
        // Update the Entity
        [entityObj update];
	}];
}

@end
