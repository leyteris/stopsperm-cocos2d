//
//  StopSpermCocosAppDelegate.h
//  StopSpermCocos
//
//  Created by King on 10-11-18.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GameData.h"

@interface StopSpermCocosAppDelegate : NSObject <UIApplicationDelegate> {
	UIWindow *window;
	GameData *gamedata;
}

@property (nonatomic, retain) UIWindow *window;
@property (nonatomic, retain) GameData *gamedata;

@end
