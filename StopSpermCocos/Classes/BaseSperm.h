//
//  BaseSperm.h
//  StopSpermCocos
//
//  Created by King on 10-11-19.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Setting.h"

@interface BaseSperm : CCSprite <CCTargetedTouchDelegate>{
	BOOL islive;
	BOOL ispressed;
	BOOL isTailPressed;
	
	
	CGFloat swimspeed;
	CCAction *moveAction;
	CCSpeed *shaketail;
	CGRect headrect;
	CGRect tailrect;
	CGRect bodyrect;
	CGFloat turntime;
	
	BOOL istailcut;
	BOOL isheadcut;
	
	CCSprite *closeeye;
	
}

@property (nonatomic, assign) BOOL isheadcut;
@property (nonatomic, assign) BOOL istailcut;
@property (nonatomic, assign) CGRect bodyrect;
@property (nonatomic, assign) CGRect headrect;
@property (nonatomic, assign) CGRect tailrect;
@property (nonatomic, assign) BOOL islive;
@property (nonatomic, assign) BOOL ispressed;
@property (nonatomic, assign) BOOL isTailPressed;
@property (nonatomic, assign) CGFloat swimspeed;
@property (nonatomic, retain) CCAction *moveAction;
@property (nonatomic, retain) CCSpeed *shaketail;

- (id)initWithFile:(NSString *)file;
-(void)toPosition:(CGPoint)pos intime:(CGFloat)time;
-(void)toPosition:(CGPoint)pos withspeed:(CGFloat)speed;
-(void)nextpos;
- (BOOL)containsTouchLocation:(UITouch *)touch;

-(void)runAway;
-(void)runAwayAndTurn;
-(void)bite;
-(void)todestination;


-(BOOL)headTouched:(UITouch*)touch;
-(BOOL)tailTouched:(UITouch*)touch;
-(BOOL)bodyTouched:(UITouch*)touch;

-(void)cutthetail;
-(void)cutthehead;

-(CGPoint)tailCutPoint;
-(CGPoint)headCutPoint;


@end
