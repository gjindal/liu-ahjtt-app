//
//  UpgradeChecker.h
//  SanTel
//
//  Created by liuxueyan on 8/6/10.
//  Copyright 2010 Sanntuu. All rights reserved.
//

#import <Foundation/Foundation.h>


static const int STATE_ROOT			= 0;
static const int STATE_VERINFO		= 1;
static const int STATE_APP			= 2;
static const int STATE_VER			= 3;
static const int STATE_APPSTORE     = 4;

@interface UpgradeChecker : NSThread<NSXMLParserDelegate> {
	int parsestate;
	
	NSMutableDictionary *_dict;
}

@property(nonatomic) int parsestate;



@end
