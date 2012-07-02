//
//  AdPartOne7.m
//  StopSpermCocos
//
//  Created by King on 10-11-21.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "AdPartOne7.h"
#import "SpermLevel1-6.h"


@implementation AdPartOne7
+(id) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	AdPartOne7 *layer = [AdPartOne7 node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}
// on "init" you need to initialize your instance
-(void)initothers{
	
	sperm = [[SpermLevel1_6 alloc] initWithFile:@"sperm.png"];
	[self addChild:sperm];
	sperm.swimspeed = NKSPERMSPEADMID;
	[sperm toPosition:NKLOSTPOSITION withspeed:sperm.swimspeed];
	[sperm release];
	
	//[CCBezierTo 
}
// on "dealloc" you need to release all your retained objects
-(void)gotonextlevel{
	[[CCDirector sharedDirector] replaceScene:[AdPartOne7 scene]];
	
}		

-(void)losegame{
	[[CCDirector sharedDirector] replaceScene:[AdPartOne7 scene]];
}


-(void)specialGameLogic:(ccTime)dt{
	
}


- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	
	// don't forget to call "super dealloc"
	[super dealloc];
}




@end


