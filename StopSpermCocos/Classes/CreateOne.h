//
//  CreateOne.h
//  StopSpermCocos
//
//  Created by King on 10-11-18.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "BaseCreate.h"
#import "SpermCreateOne.h"

#define NKFLYDISTANCE  100
#define NKFLYTIMEWIN   25

@interface CreateOne : BaseCreate {
	CCSprite *finger;
	CGPoint startpoint;
	int flytime;
	CCLabelAtlas *timelabel;
}

-(void)trytodraw;
@end
