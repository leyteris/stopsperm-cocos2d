//
//  HelloWorldLayer.h
//  StopSpermCocos
//
//  Created by King on 10-11-18.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//


// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"

// HelloWorld Layer
@interface HelloWorld : CCLayer
{
}

// returns a Scene that contains the HelloWorld as the only child
+(id) scene;
-(void)create;

@end
