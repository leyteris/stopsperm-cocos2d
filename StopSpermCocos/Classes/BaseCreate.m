//
//  BaseCreate.m
//  StopSpermCocos
//
//  Created by King on 10-11-18.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "BaseCreate.h"
#import "HelloWorldScene.h"

@implementation BaseCreate
+(id) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	BaseCreate *layer = [BaseCreate node];
	
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
		self.isTouchEnabled = YES;
		
		CCLabel *createtime = [CCLabel labelWithString:@"Create Time!" fontName:@"Marker Felt" fontSize:30];
		
		CGSize size = [[CCDirector sharedDirector] winSize];
		
		// position the label on the center of the screen
		createtime.position =  ccp( size.width /2  , size.height /2  );
		[self addChild:createtime];
		
		createtime.scale = 1.9;
		id easeout = [CCEaseOut actionWithAction:[CCScaleTo actionWithDuration:2.0 scale:1.0] rate:0.2];
		[createtime runAction:[CCSequence actions:easeout, [CCMoveBy actionWithDuration:1.0 position:ccp(0,0)], [CCFadeOut actionWithDuration:1.0],nil ]];
		
		
		CCLabel *menulabel = [CCLabel labelWithString:@"Menu" fontName:@"Marker Felt" fontSize:20];
		CCMenuItemLabel *menuitem = [CCMenuItemLabel itemWithLabel:menulabel target:self selector:@selector(tomenu)];
		CCMenu *menu = [CCMenu menuWithItems:menuitem, nil];
		
		menu.position = ccp(size.width-NKBOTTOMMENUOFFSETX, NKBOTTOMMENUOFFSETY);
		
		[menu alignItemsVertically];
		[self addChild:menu];
		
		//CCLabel *win = [CCLabel labelWithString:@"Win" fontName:@"Marker Felt" fontSize:40];
//		CCMenuItemLabel *winlabel = [CCMenuItemLabel itemWithLabel:win target:self selector:@selector(wingame)];
//		CCMenu *menuwin = [CCMenu menuWithItems:winlabel, nil];
//		
//		menuwin.position = ccp(size.width/2, size.height/2);
//		
//		[menuwin alignItemsHorizontally];
//		[self addChild:menuwin];
		//[menu runAction:[CCHide action]];
		menu.opacity = 0.0;
		[menu runAction:[CCFadeIn actionWithDuration:NKFADEINDURATION]];
		
		[self initothers];
		
		[self schedule:@selector(gameLogic:) interval:0.5];	
	}
	return self;
}
-(void)wingame{
	[GameData sharedGameData].spermnumber += 4; 
	[self winandcontinue];
}
-(void)winandcontinue{
	
}
-(void)initothers{
}
-(void)gameLogic:(ccTime)dt {
}
-(void)tomenu{
	[[CCDirector sharedDirector] replaceScene:[HelloWorld scene ]];
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
