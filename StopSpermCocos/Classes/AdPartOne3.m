//
//  AdPartOne3.m
//  StopSpermCocos
//
//  Created by King on 10-11-19.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "AdPartOne3.h"
#import "SpermLevel1-3.h"
#import "AdPartOne4.h"


@implementation AdPartOne3
+(id) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	AdPartOne3 *layer = [AdPartOne3 node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}
// on "init" you need to initialize your instance
-(void)initothers{
	
	tipLabel = [CCLabel labelWithString:@"The pollywog will try to escape while pressed." fontName:@"Marker Felt" fontSize:15];
	[self addChild:tipLabel];
	tipLabel.position = ccp(NKWINDOWSIZE.width/2, NKWINDOWSIZE.height - 100);
	tipLabel.opacity = 0.0;
	
	[tipLabel runAction:[CCSequence actions:[CCFadeIn actionWithDuration:2.0], [CCMoveBy actionWithDuration:3.0 position:ccp(0,0)], [CCFadeOut actionWithDuration:1.0],nil ]];
	
	
	sperm = [[SpermLevel1_3 alloc] initWithFile:@"sperm.png"];
	[self addChild:sperm];
	sperm.swimspeed = NKSPERMSPEADSLOW;
	[sperm toPosition:NKLOSTPOSITION withspeed:sperm.swimspeed];
	[sperm release];
}
// on "dealloc" you need to release all your retained objects
-(void)gotonextlevel{
	[[CCDirector sharedDirector] replaceScene:[AdPartOne4 scene]];
	
}		

-(void)losegame{
	[[CCDirector sharedDirector] replaceScene:[AdPartOne3 scene]];
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

