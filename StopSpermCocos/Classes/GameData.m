//
//  GameData.m
//  StopSpermCocos
//
//  Created by King on 10-11-18.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "GameData.h"


@implementation GameData
@synthesize spermnumber;
@synthesize currentlevel;

-(id)init{
	if ((self=[super init])) {
		self.spermnumber = 7;
		self.currentlevel = 1;
	}
	return self;
}
static GameData *sharedGameData = nil;

+(GameData *)sharedGameData{
	@synchronized(self)
	{
		if(!sharedGameData)
		{
			sharedGameData = [ [ self alloc] init];
		}
	}
	return sharedGameData; //singleton destroyed when app terminates
	
}


@end
