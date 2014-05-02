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
		physicsEngineDict = [NSMutableDictionary dictionaryWithCapacity:MAX_OBJS];
    }
    
    return self;
}

- (void)waitForThreadToFinish
{
    while (loopEngineThread && ![loopEngineThread isFinished]) { // Wait for the thread to finish.
        [NSThread sleepForTimeInterval:0.1];
    }
    
    // 24 quadros/sec
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
//
// Add one PE
//
- (void)addPhysicsEngine:(PhysicsEngine*)_physicsEngine withKey:(NSString*)key
{
	[physicsEngineDict setValue:_physicsEngine forKey:key];
}

//
// Remove one PE
//
- (void)removePhysicsEngine:(NSString*)key
{
	[physicsEngineDict removeObjectForKey:key];
}

- (void)stop
{
    [self stopSimulator];
}

// ********** End Delegate Implementation ***********

//
// Update all the PhysicsEngines
//
- (void)update
{
	[physicsEngineDict enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        // Get the PE object
		PhysicsEngine *peobj = (PhysicsEngine*) obj;
        
        // Update the PE
        [peobj update];
        
        // Update the PE attached View
		[mainView updateViewWithKey:key withPoint:CGPointMake(peobj.s.y,peobj.s.x)];
	}];
}

@end
