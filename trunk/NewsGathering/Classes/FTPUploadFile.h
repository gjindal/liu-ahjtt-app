//
//  FTPUploadFile.h
//  NewsGathering
//
//  Created by 刘 学雁 on 12-3-11.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FTPTransFileDelegate.h"
#import "StorageHelper.h"

@interface FTPUploadFile : NSObject{
    id<FTPTransFileDelegate>   *delegate;
	NSString *					userName;
	NSString *					passWord;
	
	NSString *					serverPath;
	uint64_t					serverSize;
	
	NSString *                  localPath;
	NSString *					fileName;
    uint64_t					localSize;
	
	uint64_t					bufferOffset;
	uint64_t					bufferLimit;
	uint8_t						_buffer[kBufferSize];
	
    CFWriteStreamRef			ftpStream;
    NSInputStream       *       fileStream;
	
	NSString *					strStatus;
	
	CFRunLoopRef		        runLoop;
}

- (uint8_t *)buffer;

- initWithLocalPath:(NSString *)localStr withServer:(NSString*)serverStr withName:(NSString*)theName withPass:(NSString*)thePass;
- initWithLocalPath:(NSString *)localStr withServer:(NSString*)serverStr;

- (void)parseLocalPath:(NSString*)localStr withServer:(NSString*)serverStr;

- (void)start;
- (void)threadMain:(id)arg;
- (void)resume;
- (void)resumeRead;
- (void)stopWithStatus:(NSString *)statusString;


@property (nonatomic) id<FTPTransFileDelegate> *delegate;
@property (nonatomic, retain) NSString * serverPath;
@property (nonatomic, retain) NSString * userName;
@property (nonatomic, retain) NSString * passWord;
@property (nonatomic, retain) NSString * localPath;
@property (nonatomic, retain) NSString * fileName;
@property (nonatomic, assign) CFWriteStreamRef ftpStream;
@property (nonatomic, retain) NSInputStream * fileStream;
@property (nonatomic, retain) NSString * strStatus;

@property (nonatomic, assign) uint64_t   serverSize;
@property (nonatomic, assign) uint64_t   localSize;
@property (nonatomic, assign) uint64_t   bufferOffset;
@property (nonatomic, assign) uint64_t   bufferLimit;


@end
