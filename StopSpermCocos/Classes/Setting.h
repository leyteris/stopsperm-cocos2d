//
//  Setting.h
//  StopSpermCocos
//
//  Created by King on 10-11-18.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#define NKTOPLABELOFFSETY 465
#define NKTOPLABELLEVELSHOWX 50

#define NKLEFTSPERMNUMBERLABELX 75

#define NKSPERMNUMBER @"Your pollywogs: %d",[[GameData sharedGameData] spermnumber]

#define NKBOTTOMMENUOFFSETY 465
#define NKBOTTOMMENUOFFSETX 30


#define NKWINDOWSIZE [[CCDirector sharedDirector] winSize]
#define NKLOSTPOSITION ccp(NKWINDOWSIZE.width/2, NKWINDOWSIZE.height - 20)


#define NKSPERMDEADTIME 1.5
#define NKTAILPRESSTIME 1.5
#define NKSPERMSPEADVERYSLOW 50
#define NKSPERMSPEADSLOW 80
#define NKSPERMSPEADMID 160
#define NKSPERMSPEADFAST 300

#define NKFADEINDURATION 2.0

@interface Setting : NSObject {

}

@end
