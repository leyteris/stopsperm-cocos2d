//
//  AdPartTwo3.m
//  StopSpermCocos
//
//  Created by King on 10-11-24.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "AdPartTwo3.h"


@implementation AdPartTwo3

+(id) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	AdPartTwo3 *layer = [AdPartTwo3 node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

-(void)initothers{
	[gameLevel setString:@"Level 2-3"];
	self.index = 0;
	memset(path, 0, sizeof(path));
	
	tipLabel = [CCLabel labelWithString:@"You can draw a magnifier to find him." fontName:@"Marker Felt" fontSize:15];
	[self addChild:tipLabel];
	tipLabel.position = ccp(NKWINDOWSIZE.width/2, NKWINDOWSIZE.height - 100);
	tipLabel.opacity = 0.0;
	
	[tipLabel runAction:[CCSequence actions:[CCFadeIn actionWithDuration:2.0], [CCMoveBy actionWithDuration:3.0 position:ccp(0,0)], [CCFadeOut actionWithDuration:1.0],nil ]];
	
	
	sperm = [[SpermLevel1_6 alloc] initWithFile:@"sperm.png"];
	[self addChild:sperm];
	sperm.swimspeed = NKSPERMSPEADSLOW;
	[sperm toPosition:NKLOSTPOSITION withspeed:sperm.swimspeed];
	[sperm release];
	
	magnifier = [CCSprite spriteWithFile:@"touchpoint.png"];
	[self addChild:magnifier];
	magnifier.scale = 4.0;
	magnifier.visible = NO;
}
-(void)gotonextlevel{
	[[CCDirector sharedDirector] replaceScene:[AdPartTwo3 scene]];
	
}		

-(void)losegame{
	[[CCDirector sharedDirector] replaceScene:[AdPartTwo3 scene ]];
}

-(void)cuthead:(CGPoint)pt{
	if (ccpDistance(pt, [sperm headCutPoint])<20) {
		[sperm cutthehead];
	}
}
-(void)magnifier:(CGPoint)pt{
	
}

@end
