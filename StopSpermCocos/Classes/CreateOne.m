//
//  CreateOne.m
//  StopSpermCocos
//
//  Created by King on 10-11-18.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "CreateOne.h"

@implementation CreateOne
+(id) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	CreateOne *layer = [CreateOne node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

-(void)winandcontinue{
	[[CCDirector sharedDirector] replaceScene:[CreateWin scene]];
}
-(void)initothers{
	finger = [CCSprite spriteWithFile:@"touchpoint.png"];
	[finger runAction:[CCHide action]];
	[self addChild:finger];
	
	timelabel = [CCLabelAtlas labelAtlasWithString:@"0" charMapFile:@"fps_images.png" itemWidth:16 itemHeight:24 startCharMap:'.'];
	[self addChild:timelabel];
	timelabel.position = ccp(200, 300);
	flytime = 0;
	
	SpermCreateOne *sperm;
	for (int i = 0; i<4; i++) {
		sperm = [SpermCreateOne spriteWithFile:@"sperm.png"];
		[self addChild:sperm];
		sperm.scale = 0.8;
		[sperm swimatbottom];
	}
	
}

-(void) onEnterTransitionDidFinish{
	//[[CCDirector sharedDirector] pause];
}
-(void)trytodraw{
	//CGColorRef color = [UIColor whiteColor].CGColor;
//	const CGFloat * components = CGColorGetComponents(color);
//	CGFloat red = components[0];
//	CGFloat green = components[1];
//	CGFloat blue = components[2];
//
//	glColor4f(0, 0, 0, 1.0);
//
//	//glDisable(GL_TEXTURE_2D);
//	GLfloat vertices[4];
//
//	CGPoint first = ccp(50,	50);
//	CGPoint second = ccp(100, 100);
//
//	vertices[0] = first.x;
//	vertices[1] = first.y;
//	vertices[2] = second.x;
//	vertices[3] = second.y;
//
//	glLineWidth(2.0);
//
//	glVertexPointer(2, GL_FLOAT, 0, vertices);
//	glDrawArrays(GL_LINES, 0, 2);
}
- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	
	// don't forget to call "super dealloc"
	[super dealloc];
}


-(void)gameLogic:(ccTime)dt {
	
	if (flytime>=NKFLYTIMEWIN ) {
		[self wingame];
	}
}

#pragma mark -----
#pragma mark player touch


- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event{
	CGPoint point = [touch locationInView: [touch view]];
	point = [[CCDirector sharedDirector] convertToGL: point];
	startpoint = point;
	finger.position = point;
	[finger runAction:[CCShow action]];
	return YES;
}

- (void)ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event{
	CGPoint point = [touch locationInView: [touch view]];
	point = [[CCDirector sharedDirector] convertToGL: point];
	finger.position = point;
	
	if (ccpDistance(point, startpoint)>NKFLYDISTANCE) {
		flytime++;
		startpoint = point;
		NSString *flystring = [NSString stringWithFormat:@"%d", flytime];
		//timelabel.position = ccp(arc4random()%320, arc4random()%480);
		[timelabel setString:flystring ];
		[timelabel setScale:2.0];
		[timelabel runAction:[CCScaleTo actionWithDuration:0.2 scale:1.0]];
	}
	
}
- (void)ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event{
	[finger runAction:[CCHide action]];
	flytime = 0;
	//[timelabel setScale:1.0];
	[timelabel setString:@"0" ];
}
- (void)ccTouchCancelled:(UITouch *)touch withEvent:(UIEvent *)event{
	[self ccTouchEnded:touch withEvent:event];
}

- (void) onEnter  
{  
    [[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];  
    [super onEnter];

}  
- (void) onExit  
{  
    [[CCTouchDispatcher sharedDispatcher]   removeDelegate:self];  
    [super onExit];  
}  
@end
