//
//  SpermForMenu.m
//  StopSpermCocos
//
//  Created by King on 10-11-19.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "SpermForMenu.h"


@implementation SpermForMenu

- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event{
	
	if ( ![self bodyTouched:touch] )   
    {  
        return NO;  
    } 
	[NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(nextpos) object:nil];
	[self nextpos];
	return YES;
}

@end
