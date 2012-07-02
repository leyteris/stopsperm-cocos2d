//
//  SpermLevel1-3.m
//  StopSpermCocos
//
//  Created by King on 10-11-19.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "SpermLevel1-3.h"


@implementation SpermLevel1_3
@synthesize touched;
-(void)istouched{
	if (ispressed && touched) {
		if ( ![self headTouched:touched] )   
		{  
			//[self stopAction:moveAction];
			[self runAway];
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
	[self toPosition:NKLOSTPOSITION withspeed:swimspeed/2];
	return YES;
}

- (void)ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event{
	self.touched = touch;
	if (ispressed) {
		if ( ![self headTouched:touch] )   
		{  
			//[self stopAction:moveAction];
			[self runAway];
			ispressed = NO;
			return;  
		}  
		
	}
	
}
- (void)ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event{
	self.touched = touch;
	if (ispressed) {
		[self runAway];
		
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

@end
