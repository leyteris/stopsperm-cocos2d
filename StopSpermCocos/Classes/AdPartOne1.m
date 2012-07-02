//
//  AdPartOne1.m
//  StopSpermCocos
//
//  Created by King on 10-11-18.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "AdPartOne1.h"
#import "AdPartOne2.h"
#import "SpermLevel1-1.h"

@implementation AdPartOne1

+(id) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	AdPartOne1 *layer = [AdPartOne1 node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}
// on "init" you need to initialize your instance
-(void)initothers{
	
	tipLabel = [CCLabel labelWithString:@"Press the pollywog's head for a while to kill him." fontName:@"Marker Felt" fontSize:15];
	[self addChild:tipLabel];
	tipLabel.position = ccp(NKWINDOWSIZE.width/2, NKWINDOWSIZE.height - 100);
	tipLabel.opacity = 0.0;
	
	[tipLabel runAction:[CCSequence actions:[CCFadeIn actionWithDuration:2.0], [CCMoveBy actionWithDuration:3.0 position:ccp(0,0)], [CCFadeOut actionWithDuration:1.0],nil ]];
	
	
	sperm = [[SpermLevel1_1 alloc] initWithFile:@"sperm.png"];
	[self addChild:sperm];
	sperm.swimspeed = NKSPERMSPEADSLOW;
	[sperm toPosition:NKLOSTPOSITION withspeed:sperm.swimspeed];
	sperm.shaketail.speed = 0.5;
	[sperm release];
	
	CCSprite *background = [CCSprite spriteWithFile:@"vocano1.png"];
	[self addChild:background];
	//background.opacity = 0.9;
	background.position = ccp(160,240);
	
	
}
// on "dealloc" you need to release all your retained objects
-(void)gotonextlevel{
	[[CCDirector sharedDirector] replaceScene:[AdPartOne2 scene]];
	
}		

-(void)losegame{
	[[CCDirector sharedDirector] replaceScene:[AdPartOne1 scene ]];
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
