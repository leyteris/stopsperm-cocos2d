//
//  BaseSperm.m
//  StopSpermCocos
//
//  Created by King on 10-11-19.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "BaseSperm.h"


@implementation BaseSperm

@synthesize islive;
@synthesize ispressed;
@synthesize swimspeed;
@synthesize moveAction;
@synthesize shaketail;
@synthesize bodyrect;
@synthesize headrect;
@synthesize tailrect;
@synthesize isTailPressed;
@synthesize istailcut, isheadcut;

#pragma mark -----

- (id)initWithFile:(NSString *)file {
    if ((self = [super initWithFile:file])) {
		
		CGSize s = self.textureRect.size;
		self.headrect = CGRectMake(-s.width/2, 8, s.width, s.height/2);
		self.tailrect = CGRectMake(-s.width/2, -s.height/2, s.width, s.height/2+8);
		self.bodyrect = CGRectMake(-s.width/2, -s.height/2, s.width, s.height);
		
		
        self.position = ccp(arc4random()%320, 20);
		self.islive = YES;
		self.ispressed = NO;
		self.istailcut = NO;
		self.isheadcut = NO;
		self.isTailPressed = NO;
		self.swimspeed = NKSPERMSPEADSLOW;
		
		turntime = 0.3;
		
		NSMutableArray *animFrames = [NSMutableArray array];
		for(int i = 1; i < 6; i++) {
			
			CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"sperm%d.png",i]];
			[animFrames addObject:frame];
		}
		CCAnimation *animation = [CCAnimation animationWithName:@"dance" delay:0.1f frames:animFrames];
		self.shaketail =[CCSpeed actionWithAction:[CCRepeatForever actionWithAction: [CCAnimate actionWithAnimation:animation restoreOriginalFrame:NO]] speed:1.0];
		
		//[self runAction:[CCFadeIn actionWithDuration:2.0]];
		closeeye = [[CCSprite alloc] initWithFile:@"close.png"];
		//[CCSprite spriteWithFile:@"close.png"];
		[self addChild:closeeye];
		[closeeye release];
		closeeye.position = ccp(s.width/2+5.5,s.height-12);
		
		//[CCRepeatForever actionWithAction:[CCSequence actions:[CCHide action],[CCCallFunc ],[]]]
		
		
		
		
		
		
		
    }
    return self;
}

-(void)toPosition:(CGPoint)pos withspeed:(CGFloat)speed{
	// Rotate sperm to face the pos
    CGPoint swimVector = ccpSub(pos, self.position);
    CGFloat swimAngle = ccpToAngle(swimVector);
	CGFloat distance = ccpDistance(pos, self.position);
    CGFloat cocosAngle = CC_RADIANS_TO_DEGREES(-1 * swimAngle) + 90;
	
    CGFloat curAngle = self.rotation;
    CGFloat rotateDiff = cocosAngle - curAngle;    
    if (rotateDiff > 180)
		rotateDiff -= 360;
	if (rotateDiff < -180)
		rotateDiff += 360;    
	// CGFloat rotateSpeed = 0.5 / 180; // Would take 0.5 seconds to rotate half a circle
	// CGFloat rotateDuration = fabs(rotateDiff * rotateSpeed);
	
	CGFloat moveSpeed = 1.0 / speed; // Would take 1.0 second to move 240 point
	CGFloat moveDureation = fabs(distance * moveSpeed);
	
	id rotate = [CCRotateTo actionWithDuration:0.3 angle:cocosAngle];
	id move =[CCMoveTo actionWithDuration:moveDureation position:pos];
	id swim = [CCSpawn actions:rotate,move,nil];

	[self stopAction:moveAction];
	[self stopAction:shaketail];
	[self runAction:shaketail];
	self.moveAction = [CCSequence actions:swim,[CCCallFunc actionWithTarget:self selector:@selector(getthere)],nil];
	
	[self runAction:moveAction];
    
	
}

-(void)toPosition:(CGPoint)pos intime:(CGFloat)time{
	// Rotate sperm to face the pos
    CGPoint swimVector = ccpSub(pos, self.position);
    CGFloat swimAngle = ccpToAngle(swimVector);
	//CGFloat distance = ccpDistance(pos, self.position);
    CGFloat cocosAngle = CC_RADIANS_TO_DEGREES(-1 * swimAngle) + 90;
	
    CGFloat curAngle = self.rotation;
    CGFloat rotateDiff = cocosAngle - curAngle;    
    if (rotateDiff > 180)
		rotateDiff -= 360;
	if (rotateDiff < -180)
		rotateDiff += 360;    
	
	id rotate = [CCRotateTo actionWithDuration:0.3 angle:cocosAngle];
	id move =[CCMoveTo actionWithDuration:time position:pos];
	
	id swim = [CCSpawn actions:rotate,move,nil];
	[self stopAction:moveAction];
	[self stopAction:shaketail];
	[self runAction:shaketail];
	
	self.moveAction = [CCSequence actions:swim,[CCCallFunc actionWithTarget:self selector:@selector(getthere)],nil];
	
	[self runAction:moveAction];
	
}

-(void)nextpos{
	[self toPosition:CGPointMake(arc4random()%320, arc4random()%480) intime:1.0f];
}
-(void)getthere{
	[self stopAction:shaketail];
	int delaytime = arc4random()%10;
	if (delaytime < 1) {
		delaytime =1;
	}
	[self performSelector:@selector(nextpos) withObject:nil afterDelay:delaytime];
	
}

- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	
	// don't forget to call "super dealloc"
	//[[CCSpriteFrameCache sharedSpriteFrameCache] removeUnusedSpriteFrames];
	
	self.moveAction = nil;
	self.shaketail = nil;
	[super dealloc];
}

-(void)runAway{
	[self toPosition:NKLOSTPOSITION withspeed:swimspeed+50];
}
-(void)runAwayAndTurn{
	turntime = 0.3;
	[self toPosition:CGPointMake(arc4random()%320, arc4random()%480) withspeed:swimspeed+50];
}
-(void)bite{
	self.isTailPressed = NO;

	[self runAway];
}
-(CGPoint)tailCutPoint{
	CGFloat dis = 30; // The distance between the sperm's point to the cut point
	CGFloat angle = self.rotation;
	angle = 360 - angle + 90;
	angle = angle/180*M_PI;
	
	return  ccp(self.position.x - cosf(angle)*dis, self.position.y - sinf(angle)*dis);
	
}
-(CGPoint)headCutPoint{
	CGFloat dis = 50; // The distance between the sperm's point to the cut point
	CGFloat angle = self.rotation;
	angle = 360 - angle + 90;
	angle = angle/180*M_PI;
	
	return  ccp(self.position.x + cosf(angle)*dis, self.position.y + sinf(angle)*dis);
	
	
}
-(void)die{
	self.islive = NO;
	self.visible = NO;
}
-(void)cutthehead{
	if (isheadcut) {
		return;
	}
	self.isheadcut = YES;
	
	[self stopAllActions];
	NSMutableArray *animFrames = [NSMutableArray array];
	for(int i = 4; i < 10; i++) {
		
		CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"cut00%d.png",i]];
		[animFrames addObject:frame];
	}
	
	CCAnimation *animation = [CCAnimation animationWithName:@"headcut" delay:0.05f frames:animFrames];
	CCRepeat *repeat = [CCRepeat actionWithAction:[CCAnimate actionWithAnimation:animation] times:1];
	[self runAction:[CCSequence actions:repeat,[CCCallFunc actionWithTarget:self selector:@selector(die)],nil]];;
	
}
-(void)cutthetail{
	if (istailcut || isheadcut) {
		return;
	}
	self.istailcut = YES;
	self.swimspeed = swimspeed / 2;
	
	
	NSMutableArray *animFrames = [NSMutableArray array];
	for(int i = 6; i < 11; i++) {
		
		CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"sperm%d.png",i]];
		[animFrames addObject:frame];
	}
	CCAnimation *animation = [CCAnimation animationWithName:@"dance2" delay:0.1f frames:animFrames];
	self.shaketail =[CCSpeed actionWithAction:[CCRepeatForever actionWithAction: [CCAnimate actionWithAnimation:animation restoreOriginalFrame:NO]] speed:1.0];
	self.shaketail.speed = 1.5;
	
	CGSize s = self.textureRect.size;
	NSLog(@"{%f, %f}",s.width,s.height);
	self.headrect = CGRectMake(-s.width/2, 8, s.width, s.height/2);
	self.tailrect = CGRectMake(-s.width/2, -30, s.width, s.height/2+8);
	self.bodyrect = CGRectMake(-s.width/2, -30, s.width, s.height);
	[self todestination];
	
}

-(void)todestination{
	[self toPosition:NKLOSTPOSITION withspeed:self.swimspeed];
}
#pragma mark -----
#pragma mark player touch

-(BOOL)headTouched:(UITouch*)touch{
	return CGRectContainsPoint(self.headrect, [self convertTouchToNodeSpaceAR:touch]);
}
-(BOOL)tailTouched:(UITouch*)touch{
	return CGRectContainsPoint(self.tailrect, [self convertTouchToNodeSpaceAR:touch]);
}

-(BOOL)bodyTouched:(UITouch*)touch{
	return CGRectContainsPoint(self.bodyrect, [self convertTouchToNodeSpaceAR:touch]);

}
- (BOOL)containsTouchLocation:(UITouch *)touch  
{  
	return CGRectContainsPoint(self.headrect, [self convertTouchToNodeSpaceAR:touch]);  
}  

- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event{
	return NO;
}

- (void)ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event{
	
}
- (void)ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event{
	
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
