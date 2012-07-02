//
//  BaseCreate.h
//  StopSpermCocos
//
//  Created by King on 10-11-18.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Setting.h"
#import "GameData.h"
#import "CreateWin.h"

@interface BaseCreate : CCLayer {

}
+(id) scene;
-(void)initothers;
-(void)winandcontinue;
-(void)wingame;

@end
