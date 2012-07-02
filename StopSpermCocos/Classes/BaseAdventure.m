//
//  BaseAdventure.m
//  StopSpermCocos
//
//  Created by King on 10-11-18.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "BaseAdventure.h"
#import "CreateOne.h"
#import "HelloWorldScene.h"


@implementation BaseAdventure
@synthesize gameLevel;
@synthesize spermnumber;

+(id) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	BaseAdventure *layer = [BaseAdventure node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
	if( (self=[super init] )) {
		presstime = 0.0;
		tailpresstime = 0.0;
		gametime = 0.0;
		shouldShowTip = YES;
		
		//CCSprite *background = [CCSprite spriteWithFile:@"vocano2.png"];
//		[self addChild:background];
//		//background.opacity = 0.9;
//		background.position = ccp(160,240);
		//[background release];
		
		//CCAction *fadein = [CCFadeIn actionWithDuration:3];
		
		self.isTouchEnabled = YES;
		// create and initialize a Label
		NSString *levelstring = [NSString stringWithFormat:@"Level 1-%d",[[GameData sharedGameData] currentlevel]];
		CCLabel *tempgamel = [[CCLabel alloc] initWithString:levelstring fontName:@"Marker Felt" fontSize:20];
		self.gameLevel = tempgamel;
		[tempgamel release];
		
		NSString *spermnu = [NSString stringWithFormat:NKSPERMNUMBER];
		
		CCLabel *tempsperml = [[CCLabel alloc] initWithString:spermnu fontName:@"Marker Felt" fontSize:20];
		self.spermnumber = tempsperml;
		[tempsperml release];
		
			// ask director the the window size
		CGSize size = [[CCDirector sharedDirector] winSize];
		
		// position the label on the center of the screen
		gameLevel.position =  ccp( NKTOPLABELLEVELSHOWX , size.height-NKTOPLABELOFFSETY );
		spermnumber.position =  ccp(size.width-NKLEFTSPERMNUMBERLABELX , size.height-NKTOPLABELOFFSETY );
		
		// add the label as a child to this Layer
		[self addChild: gameLevel];
		[self addChild:spermnumber];
		
		
		//CCLabel *win = [CCLabel labelWithString:@"Win" fontName:@"Marker Felt" fontSize:40];
//		CCMenuItemLabel *winlabel = [CCMenuItemLabel itemWithLabel:win target:self selector:@selector(wingame)];
//		CCLabel *lose = [CCLabel labelWithString:@"Lose" fontName:@"Marker Felt" fontSize:40];
//		CCMenuItemLabel *loselabel = [CCMenuItemLabel itemWithLabel:lose target:self selector:@selector(losegame)];
//		CCMenu *menu = [CCMenu menuWithItems:winlabel, loselabel, nil];
//		
//		menu.position = ccp(size.width/2, size.height/2);
//		
//		[menu alignItemsHorizontally];
//		[self addChild:menu];
		
		CCLabel *menulabel = [CCLabel labelWithString:@"Menu" fontName:@"Marker Felt" fontSize:20];
		CCMenuItemLabel *menuitem = [CCMenuItemLabel itemWithLabel:menulabel target:self selector:@selector(tomenu)];
		CCMenu *menu2 = [CCMenu menuWithItems:menuitem, nil];
		
		menu2.position = ccp(size.width-NKBOTTOMMENUOFFSETX, NKBOTTOMMENUOFFSETY);
		
		[menu2 alignItemsVertically];
		[self addChild:menu2];
		
		[self initothers];
		
//		[spermnumber runAction:[CCHide action]];
//		[gameLevel runAction:[CCHide action]];
//		[menu2 runAction:[CCHide action]];
		
		spermnumber.opacity = 0.0;
		gameLevel.opacity = 0.0;
		menu2.opacity = 0.0;
		
		[spermnumber runAction:[CCFadeIn actionWithDuration:NKFADEINDURATION]];
		[gameLevel runAction:[CCFadeIn actionWithDuration:NKFADEINDURATION]];
		[menu2 runAction:[CCFadeIn actionWithDuration:NKFADEINDURATION]];
		
		bloodLabel = [CCLabelAtlas labelAtlasWithString:@"0.0" charMapFile:@"fps_images.png" itemWidth:16 itemHeight:24 startCharMap:'.'];
		[self addChild:bloodLabel];
		bloodLabel.visible = NO;
		
		
		[self schedule:@selector(update:)];
		[self schedule:@selector(gameLogic:) interval:0.5];	
	}
	return self;
}

-(void)tomenu{
	[[CCDirector sharedDirector] replaceScene:[HelloWorld scene ]];
}
-(void)initothers{
}
-(void)gotonextlevel{
	
}
-(void)losegame{
	[[CCDirector sharedDirector] replaceScene:[BaseAdventure scene ]];
}
-(void)wingame{
	if ([self gamedatachangewin]) {
		[self gotonextlevel];
	}
}	

-(BOOL)gamedatachangewin{
	int number = [GameData sharedGameData].spermnumber;
	if (number <= 1) {
		[[CCDirector sharedDirector] replaceScene:[CreateOne scene]];
		return NO;
	}
	else {
		[GameData sharedGameData].spermnumber--;
		[GameData sharedGameData].currentlevel++;
		return YES;
	}

	
}
-(void)specialupDate:(ccTime)dt{
	
}
- (void)update:(ccTime)dt {
	[self specialupDate:dt];
	gametime += dt;
	if (sperm.ispressed) {
		presstime += dt;
		NSString *str = [[NSString alloc] initWithFormat:@"%.1f", presstime];
		[bloodLabel setString:str];
		bloodLabel.visible = YES;
		bloodLabel.position = ccp(sperm.position.x, sperm.position.y+100);
		if (presstime >= NKSPERMDEADTIME ) {
			sperm.islive = NO;
		}
	}
	else {
		bloodLabel.visible = NO;
		presstime = 0.0;
	}
	if (sperm.isTailPressed) {
		tailpresstime += dt;
		if (tailpresstime >= NKTAILPRESSTIME) {
			tailpresstime = 0.0;
			[sperm bite];
		}
	}
	else {
		tailpresstime = 0.0;
	}

	
}
-(void)gameLogic:(ccTime)dt {
	
	[self specialGameLogic:dt];
	if (ccpDistance(sperm.position, NKLOSTPOSITION) <= 1 ) {
		[self losegame];
	}
	if (!sperm.islive) {
		[self wingame];
	}
}

-(void)specialGameLogic:(ccTime)dt{
	
}

// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	
	// don't forget to call "super dealloc"
	
	[gameLevel release];
	[spermnumber release];
	[super dealloc];
}


@end
