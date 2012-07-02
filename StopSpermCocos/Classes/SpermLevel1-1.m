//
//  SpermLevel1-1.m
//  StopSpermCocos
//
//  Created by King on 10-11-19.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "SpermLevel1-1.h"


@implementation SpermLevel1_1

- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event{
	
	if ( ![self headTouched:touch] )   
    {  
        return NO;  
    }  
	self.ispressed = YES;
	[self stopAction:moveAction];
	return YES;
}

- (void)ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event{
	if ( ![self headTouched:touch] )   
    {  
		[self runAway];
		ispressed = NO;
        return;  
    }  
	
}
- (void)ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event{
	if (ispressed) {
		[self runAway];
		ispressed = NO;
	}
	
}

@end
