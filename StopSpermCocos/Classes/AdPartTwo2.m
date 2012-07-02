//
//  AdPartTwo2.m
//  StopSpermCocos
//
//  Created by King on 10-11-24.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "AdPartTwo2.h"
#import "AdPartTwo3.h"


@implementation AdPartTwo2

+(id) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	AdPartTwo2 *layer = [AdPartTwo2 node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

-(void)initothers{
	[gameLevel setString:@"Level 2-2"];
	self.index = 0;
	memset(path, 0, sizeof(path));
	
	tipLabel = [CCLabel labelWithString:@"You can also cut his's head, will you really do that?" fontName:@"Marker Felt" fontSize:15];
	[self addChild:tipLabel];
	tipLabel.position = ccp(NKWINDOWSIZE.width/2, NKWINDOWSIZE.height - 100);
	tipLabel.opacity = 0.0;
	
	[tipLabel runAction:[CCSequence actions:[CCFadeIn actionWithDuration:2.0], [CCMoveBy actionWithDuration:3.0 position:ccp(0,0)], [CCFadeOut actionWithDuration:1.0],nil ]];
	
	
	sperm = [[SpermLevel1_6 alloc] initWithFile:@"sperm.png"];
	[self addChild:sperm];
	sperm.swimspeed = NKSPERMSPEADSLOW;
	[sperm toPosition:NKLOSTPOSITION withspeed:sperm.swimspeed];
	[sperm release];
}
-(void)gotonextlevel{
	[[CCDirector sharedDirector] replaceScene:[AdPartTwo3 scene]];
	
}		

-(void)losegame{
	[[CCDirector sharedDirector] replaceScene:[AdPartTwo2 scene ]];
}

-(void)cuthead:(CGPoint)pt{
	if (ccpDistance(pt, [sperm headCutPoint])<20) {
		[sperm cutthehead];
	}
}

@end
