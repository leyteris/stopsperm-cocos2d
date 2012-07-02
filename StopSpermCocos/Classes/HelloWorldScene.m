//
//  HelloWorldLayer.m
//  StopSpermCocos
//
//  Created by King on 10-11-18.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

// Import the interfaces
#import "HelloWorldScene.h"
#import "AdPartOne1.h"
#import "CreateOne.h"
#import "SpermForMenu.h"

// HelloWorld implementation
@implementation HelloWorld

+(id) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	HelloWorld *layer = [HelloWorld node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
	if( (self=[super init] )) {
		
		self.isTouchEnabled = YES;
		SpermForMenu *sperm = [SpermForMenu spriteWithFile:@"sperm.png"];
		[self addChild:sperm];
		[sperm nextpos];
		
		// create and initialize a Label
		CCLabel *adventurelabel = [CCLabel labelWithString:@"Adventure" fontName:@"Marker Felt" fontSize:50];
		CCLabel *createlabel = [CCLabel labelWithString:@"Create" fontName:@"Marker Felt" fontSize:50];
		
		
		CCMenuItemLabel *adventure = [CCMenuItemLabel itemWithLabel:adventurelabel target:self selector:@selector(adventure)];
		
		CCMenuItemLabel *create = [CCMenuItemLabel itemWithLabel:createlabel target:self selector:@selector(create)];
		
		CCMenu *myMenu = [CCMenu menuWithItems:adventure, create, nil];
		
		[myMenu alignItemsVertically];
		
		
		
		// ask director the the window size
		CGSize size = [[CCDirector sharedDirector] winSize];
	
		// position the label on the center of the screen
		myMenu.position =  ccp( size.width /2 + 200 , size.height/2 );
		
		// add the label as a child to this Layer
		[self addChild: myMenu];
		//CCAction *jump = [CCJumpBy actionWithDuration:3.0 position:ccp(150,-150 ) height:50 jumps:3];
		
		[myMenu runAction:[CCEaseBackOut actionWithAction:[CCMoveBy actionWithDuration:0.5 position:ccp(-150, 0)]]];
		
		
	}
	return self;
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

-(void)adventure{
	if ([[GameData sharedGameData] spermnumber]<=0) {
		[self create];
	}
	else {
		
		[[CCDirector sharedDirector] replaceScene:[CCShrinkGrowTransition transitionWithDuration:0.5 scene:[AdPartOne1 scene]]];
		
	}
}
-(void)create{
	[[CCDirector sharedDirector] replaceScene:[CCShrinkGrowTransition transitionWithDuration:0.5 scene:[CreateOne scene]]];
}
@end
