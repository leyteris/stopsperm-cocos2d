//
//  AdPartTwo1.m
//  StopSpermCocos
//
//  Created by King on 10-11-21.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "AdPartTwo1.h"
#import "AdPartTwo2.h"

void triangle(CGPoint* vertex, CGPoint p1, CGPoint p2, GLfloat w1);
void HandleArray(CGPoint *dst, CGPoint *src1, CGPoint *src2);

@implementation AdPartTwo1

@synthesize index, send;

- (CGPoint*)path{
	return path;
}
+(id) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	AdPartTwo1 *layer = [AdPartTwo1 node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}
// on "init" you need to initialize your instance
-(void)initothers{
	[gameLevel setString:@"Level 2-1"];
	self.index = 0;
	memset(path, 0, sizeof(path));
	
	tipLabel = [CCLabel labelWithString:@"You can cut his's tail to slow him down." fontName:@"Marker Felt" fontSize:15];
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
// on "dealloc" you need to release all your retained objects
-(void)gotonextlevel{
	[[CCDirector sharedDirector] replaceScene:[AdPartTwo2 scene]];
	
}		

-(void)losegame{
	[[CCDirector sharedDirector] replaceScene:[AdPartTwo1 scene ]];
}

-(void)specialGameLogic:(ccTime)dt{
	
}

-(void)specialupDate:(ccTime)dt{
}
- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	
	// don't forget to call "super dealloc"
	[super dealloc];
}

-(void)cuthead:(CGPoint)pt{
	
}
-(void)magnifier:(CGPoint)pt{
	
}
#pragma mark -----
#pragma mark player touch


- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event{
	CGPoint pt = [touch locationInView: [touch view]];
	CGPoint point2 = [[CCDirector sharedDirector] convertToGL: pt];	
	
	startpoint = point2;
	
	pt = ccp(pt.x, 480-pt.y);
	send = NO;
	index = 0;
	path[index++] = pt;

	return YES;
}

- (void)ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event{
	CGPoint pt = [touch locationInView: [touch view]];	
	CGPoint pt2 = [[CCDirector sharedDirector] convertToGL: pt];
	
	pt = ccp(pt.x, 480-pt.y);
	GLfloat dis = ccpDistance(pt, path[index-1]);
	if (dis<2.0) {
		return;
	}
	
	if (index<pt_count) {
		path[index++] = pt;
	}
	else {		
		memmove(path, &(path[1]), sizeof(CGPoint)*(pt_count-1));
		path[index-1] = pt;
	}
	
	if (ccpDistance(pt2, [sperm tailCutPoint])<20) {
		[sperm cutthetail];
	}
	[self cuthead:pt2];
	[self magnifier:pt2];
	

}

- (void)ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event{
	send = YES;
	//finger.visible = NO;
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

- (void)easeNail {
	
	if (self.index<4 && !self.send) {
		return;
	}
	
	if (self.index<2) {
		return;
	}
	
	CGPoint *p = self.path;
	self.index--;
	
	memmove(p, &(p[1]), sizeof(CGPoint)*(self.index));	
}

- (void)draw
{
	
	
	NSTimeInterval dt = CACurrentMediaTime();
	
	AdPartTwo1 *v = self;
	
	if (v.send) {
		timer += dt;
		if (timer > 1) {
			timer = 0.0;
			[self easeNail];
		}
	}
 	
	[self line];
}

- (void)line {
	
	AdPartTwo1 *v = self;
	if (v.index<2) {
		return;
	}
	
	CGPoint *p = v.path;
	CGPoint vertex1[512]={{0.0}};
	CGPoint vertex2[512]={{0.0}};
	CGPoint vertex3[512]={{0.0}};
	
	{
		memcpy(vertex1, p, sizeof(CGPoint)*v.index);
		
		CGPoint pt = ccpSub(p[v.index-1], p[v.index-2]);
		GLfloat angle = ccpToAngle(pt);
		vertex1[v.index-1].x += cosf(angle)*10;
		vertex1[v.index-1].y += sinf(angle)*10;
		
	}
	
	float w = (pt_count/(v.index-1)*0.5);
	{
		CGPoint pt = ccpSub(p[v.index-1], p[v.index-2]);
		GLfloat angle = ccpToAngle(pt);
		vertex2[0].x = p[v.index-1].x + cosf(angle)*10;
		vertex2[0].y = p[v.index-1].y + sinf(angle)*10;
		
		GLint count = 1;
		
		for (int i = (v.index-2); i>0; --i) {
			
			triangle(&(vertex2[count]),p[i],p[i-1], w*i);
			count++;
		}
		vertex2[count++] = p[0];
		
	}
	
	{
		
		CGPoint pt = ccpSub(p[v.index-1], p[v.index-2]);
		GLfloat angle = ccpToAngle(pt);
		vertex3[0].x = p[v.index-1].x + cosf(angle)*10;
		vertex3[0].y = p[v.index-1].y + sinf(angle)*10;
		
		GLint count = 1;
		
		for (int i = (v.index-2); i>0; --i) {
			
			triangle(&(vertex3[count]),p[i],p[i-1], -w*i);
			count++;
		}
		vertex3[count++] = p[0];
	}
	
	CGPoint finalvertex1[512]={{0.0}};
	finalvertex1[0]=vertex1[v.index-1];
	for (int i=0; i<v.index; i++) {		
		finalvertex1[i*2+1] = vertex2[i];
		finalvertex1[i*2+2] = vertex3[i];
	}
	glDisable(GL_TEXTURE_2D);
	glDisableClientState(GL_TEXTURE_COORD_ARRAY);
	glDisableClientState(GL_COLOR_ARRAY);
	
	glVertexPointer(2, GL_FLOAT, 0, finalvertex1);
	glEnableClientState(GL_VERTEX_ARRAY);	
	glColor4f(1.0f, 1.0f, 1.0f, 1.0f);
	glDrawArrays(GL_TRIANGLE_STRIP, 0, v.index*2+1);
	
	glEnableClientState(GL_COLOR_ARRAY);
	glEnableClientState(GL_TEXTURE_COORD_ARRAY);
	glEnable(GL_TEXTURE_2D);	
		
}

-(void)trytodraw{
}

@end
void triangle(CGPoint* vertex, CGPoint p1, CGPoint p2, GLfloat w) {
	
	CGPoint pt = ccpSub(p1, p2);
	GLfloat angle = ccpToAngle(pt);
	
	GLfloat x = sinf(angle) * w;
	GLfloat y = cosf(angle) * w;
	vertex->x = p1.x+x;
	vertex->y = p1.y-y;
}

void HandleArray(CGPoint *dst, CGPoint *src1, CGPoint *src2)
{
	int lock = 0;
	for (int i=0; i<2048; i++)
	{
		if (0 == lock)
		{
			dst[i] = src1[i / 2];
			lock = 1;
		}
		else
		{
			dst[i] = src2[i / 2];
			lock = 0;
		}
	}
}

