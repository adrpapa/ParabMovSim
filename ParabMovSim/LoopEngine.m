//
//  LoopEngine.m
//  AppleCatcher
//
//  Created by Adriano Papa on 3/24/14.
//  Copyright (c) 2014 Adriano Papa. All rights reserved.
//

#import "LoopEngine.h"

#define TIME_UNIT					0.04
#define MAX_OBJS                    5

@implementation LoopEngine

@synthesize mainView;

- (id)init
{
    self = [super init];
    
    if (self)
    {
//		physicsEngineDict = [NSMutableDictionary dictionaryWithCapacity:MAX_OBJS];
        physicsEngine = [[PhysicsEngine alloc] init];
    }
    
    return self;
}

- (void)waitForThreadToFinish
{
    while (loopEngineThread && ![loopEngineThread isFinished]) { // Wait for the thread to finish.
        [NSThread sleepForTimeInterval:0.1];
    }
}

- (void)startLoopEngineThread
{
    if (loopEngineThread != nil)
    {
        [loopEngineThread cancel];
        [self waitForThreadToFinish];
    }
    
	NSThread *thr = [[NSThread alloc] initWithTarget:self selector:@selector(loopEngine) object:nil];
	self->loopEngineThread = thr;
    
	[self->loopEngineThread start];
}

- (void)loopEngine
{
    [NSThread setThreadPriority:1.0];
    continueLoop = true;
	
	while (continueLoop) 
	{
        [NSThread sleepForTimeInterval:TIME_UNIT];
        
        // Call Update()
        [self performSelectorOnMainThread:@selector(update) withObject:nil waitUntilDone:NO];
	}
}

- (void)stopSimulator
{
    continueLoop=false;
    [loopEngineThread cancel];
    [self waitForThreadToFinish];
    loopEngineThread=nil;
}

#pragma mark -
#pragma mark === Delegates Implementation ===
#pragma mark -

- (void)addEntity:(Entity*)_entity withKey:(NSString*)key
{
	[physicsEngine.entityDict setValue:_entity forKey:key];
}

- (void)removeEntity:(NSString*)key
{
	[physicsEngine.entityDict removeObjectForKey:key];
}

- (void)stop
{
    [self stopSimulator];
}

// ********** End Delegate Implementation ***********

- (void)update
{
    // Update entities position
    [physicsEngine update];
    
    // Render on the view
    [self render];
}

- (void)render
{
	[physicsEngine.entityDict enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        // Get the Entity object
		Entity *entityObj = (Entity*) obj;

	    [mainView updateViewWithKey:key withPoint:CGPointMake(entityObj.s.y,entityObj.s.x)];
    }];
}

@end
