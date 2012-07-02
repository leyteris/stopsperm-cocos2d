//
//  CreateWin.m
//  StopSpermCocos
//
//  Created by King on 10-11-18.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "CreateWin.h"
#import "AdPartTwo1.h"


@implementation CreateWin

+(id) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	CreateWin *layer = [CreateWin node];
	
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
		
		CCLabel *gratuations = [CCLabel labelWithString:@"Thanks and Congratulations!" fontName:@"Marker Felt" fontSize:20];
		CCLabel *fourSperm = [CCLabel labelWithString:@"You've create 4 pollywogs!" fontName:@"Marker Felt" fontSize:20];
		CCLabel *onad = [CCLabel labelWithString:@"You can continue on Adventure now." fontName:@"Marker Felt" fontSize:20];

		
		
		CGSize size = [[CCDirector sharedDirector] winSize];
		onad.position = ccp(size.width/2, 260);
		fourSperm.position = ccp(size.width/2, 300);
		gratuations.position = ccp(size.width/2, 340);
		
		[self addChild:gratuations];
		[self addChild:fourSperm];
		[self addChild:onad];
		
		CCLabel *continuela = [CCLabel labelWithString:@"Continue" fontName:@"Marker Felt" fontSize:30];
		

		// position the label on the center of the screen
		CCMenuItemLabel *menuitem = [CCMenuItemLabel itemWithLabel:continuela target:self selector:@selector(continutoplay)];
		CCMenu *menu = [CCMenu menuWithItems:menuitem, nil];
		
		menu.position = ccp(size.width/2, 50);
		
		[menu alignItemsVertically];
		[self addChild:menu];
		
	}
	return self;
}
-(void)continutoplay{
	[[CCDirector sharedDirector] replaceScene:[AdPartTwo1 scene]];
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
