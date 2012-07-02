//
//  BaseAdventure.h
//  StopSpermCocos
//
//  Created by King on 10-11-18.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Setting.h"
#import "GameData.h"
#import "BaseSperm.h"

@interface BaseAdventure : CCLayer {
	CCLabel *gameLevel;
	CCLabel *spermnumber;
	BaseSperm *sperm;
	ccTime gametime;
	ccTime presstime;
	ccTime tailpresstime;
	CCLabel *tipLabel;
	
	BOOL shouldShowTip;
	CCLabelAtlas *bloodLabel;
	
}
@property (nonatomic, retain) CCLabel *gameLevel;
@property (nonatomic, retain) CCLabel *spermnumber;

+(id) scene;
-(void)initothers;
-(BOOL)gamedatachangewin;
-(void)gotonextlevel;

-(void)losegame;
-(void)wingame;

-(void)specialGameLogic:(ccTime)dt;
-(void)specialupDate:(ccTime)dt;
@end
