//
//  AdPartTwo1.h
//  StopSpermCocos
//
//  Created by King on 10-11-21.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "BaseAdventure.h"
#import "SpermLevel1-6.h"


#define pt_count	16

@interface AdPartTwo1 : BaseAdventure {
	CCSprite *finger;
	CGPoint path[pt_count];
	NSUInteger index;
	BOOL send;
	
	CGPoint startpoint;
	
	NSTimeInterval timer;
	CCSprite *magnifier;
}

@property (nonatomic, readonly)CGPoint *path;
@property (nonatomic, assign)NSUInteger index;
@property (nonatomic, readonly)BOOL send;

-(void)line;

-(void)cuthead:(CGPoint)pt;
-(void)magnifier:(CGPoint)pt;


@end
