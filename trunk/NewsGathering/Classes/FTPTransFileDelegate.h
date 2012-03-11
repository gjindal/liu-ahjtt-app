//
//  FTPTransFileDelegate.h
//  NewsGathering
//
//  Created by 刘 学雁 on 12-3-10.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#define kBufferSize 8000

@protocol FTPTransFileDelegate <NSObject>
@optional

- (void)sendFileDidfinished;
- (void)receiveFileDidfinished;
- (void)sendFilePaused;
- (void)receiveFilePaused;

@end
