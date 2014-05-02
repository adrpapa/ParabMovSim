//
//  LoopEngine.h
//  ParabMovSim
//
//  Created by Adriano Papa on 4/19/14.
//  Copyright (c) 2014 Adriano Papa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ParabMovSimView.h"

@interface LoopEngine : NSObject <ParabMovSimViewDelegate>
{
	ParabMovSimView *mainView;
	NSMutableDictionary *physicsEngineDict;
    NSThread *loopEngineThread;
    BOOL continueLoop;
}

@property(strong,nonatomic) ParabMovSimView *mainView;

- (void)startLoopEngineThread;

@end
