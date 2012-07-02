//
//  SpermCreateOne.m
//  StopSpermCocos
//
//  Created by King on 10-11-21.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "SpermCreateOne.h"


@implementation SpermCreateOne
-(void)swimatbottom{
	[self toPosition:ccp(arc4random()%320, arc4random()%40) intime:arc4random()%2+1];
}
-(void)getthere{
	[self stopAction:shaketail];
	int delaytime = arc4random()%10;
	if (delaytime < 1) {
		delaytime =1;
	}
	[self performSelector:@selector(swimatbottom) withObject:nil afterDelay:delaytime];
	
}

- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event{
	
	if ( ![self headTouched:touch] )   
    {  
        return NO;  
    }  
	[NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(swimatbottom) object:nil];
	[self swimatbottom];
	return YES;
}




@end
