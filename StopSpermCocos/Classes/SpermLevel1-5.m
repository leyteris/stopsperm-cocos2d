//
//  SpermLevel1-5.m
//  StopSpermCocos
//
//  Created by King on 10-11-20.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "SpermLevel1-5.h"


@implementation SpermLevel1_5
@synthesize touched;

-(void)getthere{
	[self toPosition:NKLOSTPOSITION withspeed:swimspeed];
	
}

-(void)istouched{
	if (ispressed && touched) {
		if ( ![self headTouched:touched] )   
		{  
			//[self stopAction:moveAction];
			[self runAwayAndTurn];
			ispressed = NO;
			return;  
		}  
		[NSTimer scheduledTimerWithTimeInterval:0.3 target:self selector:@selector(istouched) userInfo:nil repeats:NO];
		
		
	}
}
- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event{
	self.touched = touch;
	if ( ![self headTouched:touch] )   
    {  
        return NO;  
    }  
	self.ispressed = YES;
	[NSTimer scheduledTimerWithTimeInterval:0.3 target:self selector:@selector(istouched) userInfo:nil repeats:NO];
	//[self stopAction:moveAction];
	turntime = 2.0;
	[self toPosition:CGPointMake(arc4random()%320, arc4random()%480) withspeed:swimspeed/2];
	
	
	
	return YES;
}

- (void)ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event{
	self.touched = touch;
	if (ispressed) {
		if ( ![self headTouched:touch] )   
		{  
			//[self stopAction:moveAction];
			[self runAwayAndTurn];
			ispressed = NO;
			return;  
		}  
		
	}
	
}
- (void)ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event{
	self.touched = touch;
	if (ispressed) {
		[self runAwayAndTurn];
		
		ispressed = NO;
	}
}
- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	
	// don't forget to call "super dealloc"
	self.touched = nil;
	[super dealloc];
}

-(void)toPosition:(CGPoint)pos withspeed:(CGFloat)speed{
	// Rotate sperm to face the pos
    CGPoint swimVector = ccpSub(pos, self.position);
    CGFloat swimAngle = ccpToAngle(swimVector);
	CGFloat distance = ccpDistance(pos, self.position);
    CGFloat cocosAngle = CC_RADIANS_TO_DEGREES(-1 * swimAngle) + 90;

    CGFloat curAngle = self.rotation;
    CGFloat rotateDiff = cocosAngle - curAngle;    
    if (rotateDiff > 180)
		rotateDiff -= 360;
	if (rotateDiff < -180)
		rotateDiff += 360;    
	// CGFloat rotateSpeed = 0.5 / 180; // Would take 0.5 seconds to rotate half a circle
	// CGFloat rotateDuration = fabs(rotateDiff * rotateSpeed);
	
	CGFloat moveSpeed = 1.0 / speed; // Would take 1.0 second to move 240 point
	CGFloat moveDureation = fabs(distance * moveSpeed);
	
	id rotate = [CCRotateTo actionWithDuration:turntime angle:cocosAngle];
	id move =[CCMoveTo actionWithDuration:moveDureation position:pos];
	
	
	
	
	id swim = [CCSpawn actions:rotate,move,nil];
	
	[self stopAction:moveAction];
	[self stopAction:shaketail];
	[self runAction:shaketail];
	self.moveAction = [CCSequence actions:swim,[CCCallFunc actionWithTarget:self selector:@selector(getthere)],nil];
	
	[self runAction:moveAction];
    
	
}



@end
