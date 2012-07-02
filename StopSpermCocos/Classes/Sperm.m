//
//  Sperm.m
//  StopSpermCocos
//
//  Created by King on 10-11-19.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Sperm.h"


@implementation Sperm

- (id)initWithFile:(NSString *)file {
    if ((self = [super initWithFile:file])) {
        self.position = ccp(100,100);
    }
    return self;
}

-(void)toPosition:(CGPoint)pos{
	// Rotate sperm to face the pos
    CGPoint swimVector = ccpSub(pos, self.position);
    CGFloat swimAngle = ccpToAngle(swimVector);
	//CGFloat distance = ccpDistance(pos, self.position);
    CGFloat cocosAngle = CC_RADIANS_TO_DEGREES(-1 * swimAngle) + 90;
	
    CGFloat curAngle = self.rotation;
    CGFloat rotateDiff = cocosAngle - curAngle;    
    if (rotateDiff > 180)
		rotateDiff -= 360;
	if (rotateDiff < -180)
		rotateDiff += 360;    
   // CGFloat rotateSpeed = 0.5 / 180; // Would take 0.5 seconds to rotate half a circle
   // CGFloat rotateDuration = fabs(rotateDiff * rotateSpeed);
	
	//CGFloat moveSpeed = 1.0 / 240; // Would take 1.0 second to move 240 point
	//CGFloat moveDureation = fabs(distance * moveSpeed);
	
	id rotate = [CCRotateTo actionWithDuration:0.3 angle:cocosAngle];
	id move =[CCMoveTo actionWithDuration:1.0f position:pos];

	
	
	
	id swim = [CCSpawn actions:rotate,move,nil];
	
	[self runAction:[CCSequence actions:swim,[CCCallFunc actionWithTarget:self selector:@selector(getthere)],nil]];
    
	
}

-(void)nextpos{
	[self toPosition:CGPointMake(arc4random()%320, arc4random()%480)];
}
-(void)getthere{
	int delaytime = arc4random()%10;
	if (delaytime < 1) {
		delaytime =1;
	}
	[self performSelector:@selector(nextpos) withObject:nil afterDelay:delaytime];
	
}

#pragma mark -----
#pragma mark player touch

- (CGRect)rect  
{  
    CGSize s = [self.texture contentSize];  
    return CGRectMake(-s.width / 2, -s.height / 2, s.width, s.height);  
}  
- (BOOL)containsTouchLocation:(UITouch *)touch  
{  
    return CGRectContainsPoint(self.rect, [self convertTouchToNodeSpaceAR:touch]);  
}  

- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event{
	
	if ( ![self containsTouchLocation:touch] )   
    {  
        return NO;  
    }  
	return YES;
}

- (void)ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event{
	
}
- (void)ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event{
	[NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(nextpos) object:nil];
	[self nextpos];
}
- (void)ccTouchCancelled:(UITouch *)touch withEvent:(UIEvent *)event{
	[self ccTouchEnded:touch withEvent:event];
}


- (void) onEnter  
{  
    [[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];  
    [super onEnter];  
}  
- (void) onExit  
{  
    [[CCTouchDispatcher sharedDispatcher]   removeDelegate:self];  
    [super onExit];  
}  

@end
