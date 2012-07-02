//
//  SpermLevel1-5.h
//  StopSpermCocos
//
//  Created by King on 10-11-20.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "BaseSperm.h"

@interface SpermLevel1_5 : BaseSperm {
	UITouch *touched;
}
@property (nonatomic, retain) UITouch *touched;
@end
