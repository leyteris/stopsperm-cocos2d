//
//  AdPartOne2.m
//  StopSpermCocos
//
//  Created by King on 10-11-18.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "AdPartOne2.h"
#import "SpermLevel1-1.h"
#import "AdPartOne3.h"


@implementation AdPartOne2
+(id) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	AdPartOne2 *layer = [AdPartOne2 node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}
-(void)gotonextlevel{
	[[CCDirector sharedDirector] replaceScene:[AdPartOne3 scene]];
	
}	

-(void)losegame{
	[[CCDirector sharedDirector] replaceScene:[AdPartOne2 scene ]];
}
-(void)initothers{
	
	sperm = [[SpermLevel1_1 alloc] initWithFile:@"sperm.png"];
	[self addChild:sperm];
	sperm.swimspeed = NKSPERMSPEADMID;
	[sperm toPosition:NKLOSTPOSITION withspeed:sperm.swimspeed];
	[sperm release];
}
// on "dealloc" you need to release all your retained objects

- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	
	// don't forget to call "super dealloc"
	[super dealloc];
}




@end
