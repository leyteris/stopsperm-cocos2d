//
//  GameData.h
//  StopSpermCocos
//
//  Created by King on 10-11-18.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface GameData : NSObject {
	int spermnumber;
	int currentlevel;
}
@property (nonatomic, assign) int spermnumber;
@property (nonatomic, assign) int currentlevel;

+(GameData *)sharedGameData;

@end
