//
//  FTPTransFile.h
//  NewsGathering
//
//  Created by 刘 学雁 on 12-3-10.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FTPTransFileDelegate.h"
#import "StorageHelper.h"

#define BUFFER_SIZE  32768

@interface FTPDownloadFile : NSObject<NSStreamDelegate> {	
@private
    id<FTPTransFileDelegate>   *delegate;
	NSString *					userName;
	NSString *					passWord;
	
	NSString *					serverPath;
	uint64_t					serverSize;
	
	NSString *                  localPath;
	NSString *					fileName;
    uint64_t					localSize;
	
    NSInputStream  *            ftpStream;
    NSOutputStream *            fileStream;
	
	NSString *					strStatus;
	
	CFRunLoopRef		        runLoop;
}

- initWithServerPath:(NSString *)serverStr withLocal:(NSString*)localStr withName:(NSString*)theName withPass:(NSString*)thePass;
- initWithServerPath:(NSString *)serverStr withLocal:(NSString*)localStr;

- (void)parseServerUrl:(NSString*)serverStr withLocal:(NSString*)localStr;

- (void)start;
- (void)threadMain:(id)arg;
- (void)resume;
- (void)stopWithStatus:(NSString *)statusString;


@property (nonatomic) id<FTPTransFileDelegate> *delegate;
@property (nonatomic, retain) NSString * serverPath;
@property (nonatomic, retain) NSString * userName;
@property (nonatomic, retain) NSString * passWord;
@property (nonatomic, retain) NSString * localPath;
@property (nonatomic, retain) NSString * fileName;
@property (nonatomic, assign) NSInputStream * ftpStream;
@property (nonatomic, retain) NSOutputStream * fileStream;
@property (nonatomic, retain) NSString * strStatus;

@property (nonatomic, assign) uint64_t   serverSize;
@property (nonatomic, assign) uint64_t   localSize;



@end
