//
//  AppleCatcherView.m
//  AppleCatcher
//
//  Created by Adriano Papa on 3/19/14.
//  Copyright (c) 2014 Adriano Papa. All rights reserved.
//
#import "ParabMovSimView.h"

CGFloat DegreesToRadians(CGFloat degrees) {return degrees * M_PI / 180;};
CGFloat RadiansToDegrees(CGFloat radians) {return radians * 180/M_PI;};

#define MAX_OBJS 5

@implementation ParabMovSimView

@synthesize delegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        startSimulator = false;
		ballCount = 0;
		ballViewDict = [NSMutableDictionary dictionaryWithCapacity:MAX_OBJS];

        lastLayer = nil;
    }
    return self;
}

- (void)drawThrowVector:(CGPoint)toPoint
{
    UIBezierPath *aPath = [UIBezierPath bezierPath];
    
	[aPath moveToPoint:CGPointMake(0.0,0.0)];
	[aPath addLineToPoint:toPoint];
	
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = [aPath CGPath];
    shapeLayer.lineDashPattern = [NSArray arrayWithObjects:[NSNumber numberWithInt:2], [NSNumber numberWithInt:3],nil];
    shapeLayer.strokeColor = [[UIColor whiteColor] CGColor];
    shapeLayer.lineWidth = 1.0;
    shapeLayer.fillColor = [[UIColor clearColor] CGColor];
    
    if (lastLayer != nil)
    {
        [self.layer replaceSublayer:lastLayer with:shapeLayer];
    }
    else
    {
        [self.layer addSublayer:shapeLayer];
    }
    
    lineLen = sqrtf(toPoint.x*toPoint.x + toPoint.y*toPoint.y);
    lineAngle = atanf(toPoint.x/toPoint.y);
    
    NSLog(@"Line Len: %f", lineLen);
    NSLog(@"Angle: %f", RadiansToDegrees(lineAngle));
    
    lastLayer = shapeLayer;
}

#pragma mark -
#pragma mark === Touch handling ===
#pragma mark -
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [[event allTouches] anyObject];
    CGPoint location = [touch locationInView:self];
	[self drawThrowVector:location];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [[event allTouches] anyObject];
    CGPoint location = [touch locationInView:self];
	
	[self drawThrowVector:location];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
	// Create a new apple view
	NSString *key = [NSString stringWithFormat:@"%d",ballCount];

    UIImageView *ball = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ball.png"]];
    ball.center = self.center;
    ball.layer.position = CGPointMake(0.0, 0.0);
    ball.opaque = YES;

    [ballViewDict setValue:ball forKey:key];
	
	// Create one PE and Add it to Loop Engine
	Entity *ph_eng = [[Entity alloc] initWithKey:key andAngle:90-RadiansToDegrees(lineAngle) andVelocity:lineLen/2.0];
	// Call the delegate
    [self.delegate addEntity:ph_eng withKey:key];
	
	// Add to Landscape View
	[self addSubview:ball];
	
	if (++ballCount >= INT32_MAX) ballCount = 0;
    
    if (lastLayer != nil)
    {
        [lastLayer removeFromSuperlayer];
        lastLayer = nil;
    }
}

//
// Update the ball position
//
- (void)updateViewWithKey:(NSString*)key withPoint:(CGPoint)ballPos
{
    // Update apple position
	//UIImageView *apple = (UIImageView*)[appleViewDict valueForKey:key];
    UIImageView *ball = (UIImageView*)[ballViewDict valueForKey:key];
    
    if ((ball.layer.position.y > self.bounds.size.height || ball.layer.position.x > self.bounds.size.width ||
         ball.layer.position.x < 0 || ball.layer.position.y < 0) )
    {
        [self.delegate removeEntity:key];
        [ball removeFromSuperview];
    }
    else
    {
        ball.layer.position = ballPos;
    }
}

@end
