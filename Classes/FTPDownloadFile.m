//
//  FTPTransFile.m
//  NewsGathering
//
//  Created by 刘 学雁 on 12-3-10.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "FTPDownloadFile.h"
#import "FileInfo.h"
#import "FTPTransFileDelegate.h"

@implementation FTPDownloadFile

@synthesize delegate;
@synthesize serverPath;
@synthesize userName;
@synthesize passWord;
@synthesize localPath;
@synthesize fileName;
@synthesize ftpStream;
@synthesize fileStream;
@synthesize strStatus;
@synthesize serverSize;
@synthesize localSize;
@synthesize bStop;

- initWithServerPath:(NSString *)serverStr withLocal:(NSString*)localStr
			withName:(NSString*)theName withPass:(NSString*)thePass {
	self = [super init];
	if (self == nil)
		return nil;
	[self parseServerUrl: serverStr withLocal:localStr];
	
	self.userName = theName;
	self.passWord = thePass;
	self.bStop = NO;
	return self;
}

- initWithServerPath:(NSString *)serverStr withLocal:(NSString*)localStr {
	return [self initWithServerPath:serverStr withLocal:localStr withName:nil withPass:nil];
}

// assume everything is right
- (void)parseServerUrl:(NSString*)serverStr withLocal:(NSString*)localStr {
	self.serverPath = serverStr;
	self.fileName  = [serverStr lastPathComponent];
	self.localPath = @"";//[FileInfo pathForDocument];
	self.localPath = localStr;//[self.localPath stringByAppendingPathComponent:localStr];
	NSString * name = [self.localPath lastPathComponent];
	if ([name compare:self.fileName] != NSOrderedSame){
		self.localPath = [self.localPath stringByAppendingPathComponent: self.fileName];
	}
	
	// get local file size
	self.localSize = [FileInfo getFileSize: self.localPath];
	NSLog(@"Downloading %@ from %@ to %@", self.fileName, self.serverPath, self.localPath);
}

- (void)start {
    
   [self resume];
	///[NSThread detachNewThreadSelector:@selector(threadMain:) toTarget:self withObject:nil];
}

- (void)threadMain:(id)arg {
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    
	runLoop = CFRunLoopGetCurrent();
	void * p = runLoop;
	NSLog(@" the current thread's loop is %p", p);
	
	[self resume];	
	 //CFRunLoopRunInMode(kCFRunLoopDefaultMode, 1000, NO);
	CFRunLoopRun();
    
	NSLog(@"thread exiting...");
	[pool release];
    
}

- (void)resume {
    
    if (bStop) {
        [self stopWithStatus:FTP_ERROR_STOPCMD];
        return;
    }
    
	// First get and check the URL.
    NSLog(@"=========%@",self.serverPath);
    NSURL * url = [FileInfo smartURLForString: self.serverPath];
    BOOL success = (url != nil);
	
    if ( ! success) {
        self.strStatus = @"Invalid URL";
    } else {
		// Open a CFFTPStream for the URL.
        CFReadStreamRef fs = CFReadStreamCreateWithFTPURL(NULL, (CFURLRef) url);
        assert(fs != NULL);
		self.ftpStream = (NSInputStream *) fs;
        
		if (self.userName != 0) {
			success = [self.ftpStream setProperty:self.userName forKey:(id)kCFStreamPropertyFTPUserName];
			assert(success);
			success = [self.ftpStream setProperty:self.passWord forKey:(id)kCFStreamPropertyFTPPassword];
			assert(success);
		}
		
		//success = [self.ftpStream setProperty:(id)kCFBooleanTrue forKey:(id)kCFStreamPropertyFTPFetchResourceInfo];
		//uint64_t lsize = self.localSize;
		//success = [self.ftpStream setProperty:[NSNumber numberWithUnsignedLongLong:lsize] forKey:(id)kCFStreamPropertyFTPFileTransferOffset];
        
        self.ftpStream.delegate = self;
        currentRunLoop = [[NSRunLoop currentRunLoop] retain];
        [self.ftpStream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
        [self.ftpStream open];
		
		CFRelease(fs);
    }	
}

- (void)stream:(NSStream *)aStream handleEvent:(NSStreamEvent)eventCode
// An NSStream delegate callback that's called when events happen on our 
// network stream.
{
    
    if (bStop) {
        [self stopWithStatus:FTP_ERROR_STOPCMD];
        return;
    }
#pragma unused(aStream)
    assert(aStream == self.ftpStream);
	
    switch (eventCode) {
        case NSStreamEventOpenCompleted: {
			self.strStatus = @"Opened connection";
			NSLog(@"connection opened for %@", self.serverPath);
			BOOL success = NO;
			
			self.serverSize = -1;
			// check server file's size
			NSNumber * cfSize = [self.ftpStream propertyForKey:(id)kCFStreamPropertyFTPResourceSize];
			if (cfSize != nil) {
				uint64_t size = [cfSize unsignedLongLongValue];
				self.strStatus = [NSString stringWithFormat:@"File size is %llu", size];
				self.serverSize = size;
				success = YES;
			} else {
				self.strStatus = @"File size is unknown. Uh oh.";
				self.serverSize = -1;
			}
			
            if (self.serverSize == self.localSize) {
                [self stopWithStatus:FTP_ERROR_NO];
            }else
			// Open a stream for the file we're going to receive into.
			if (self.serverSize > self.localSize){
				if (success){
					self.fileStream = [NSOutputStream outputStreamToFileAtPath:self.localPath append:YES];
					NSLog(@"local file existing, appending the data");
				} else {
					self.fileStream = [NSOutputStream outputStreamToFileAtPath:self.localPath append:NO];
					self.localSize = 0;
					NSLog(@"downloading the file from the starting point");
				}
				assert(self.fileStream != nil);
				[self.fileStream open];
			} else {
				NSLog(@"local file size >= server file, aborting...");
				[self stopWithStatus:FTP_ERROR_REMOTEFILE];
			}
        } break;
        case NSStreamEventHasBytesAvailable: {
            NSInteger       bytesRead;
            uint8_t         buffer[kBufferSize];
			
            // Pull some data off the network.
            
            bytesRead = [self.ftpStream read:buffer maxLength:sizeof(buffer)];
            if (bytesRead == -1) {
                [self stopWithStatus:FTP_ERROR_NETWORK];
				return;
            } else if (bytesRead == 0) {
                [self stopWithStatus:FTP_ERROR_NO];
				return;
            } else {
                NSInteger   bytesWritten;
                NSInteger   bytesWrittenSoFar;
                
                // Write to the file.
                
                bytesWrittenSoFar = 0;
                do {
                    bytesWritten = [self.fileStream write:&buffer[bytesWrittenSoFar] maxLength:bytesRead - bytesWrittenSoFar];
                    assert(bytesWritten != 0);
                    if (bytesWritten == -1) {
                        [self stopWithStatus:FTP_ERROR_WRITEFILE];
                        break;
                    } else {
                        bytesWrittenSoFar += bytesWritten;
                    }
                } while (bytesWrittenSoFar != bytesRead);
            }
			self.localSize += bytesRead;
			self.strStatus = [NSString stringWithFormat:@"receiving %llu/%llu", self.localSize, self.serverSize];
        } break;
        case NSStreamEventHasSpaceAvailable: {
            assert(NO);     // should never happen for the output stream
        } break;
        case NSStreamEventErrorOccurred: {
            [self stopWithStatus:FTP_ERROR_NETWORK];
        } break;
        case NSStreamEventEndEncountered: {
            [self stopWithStatus:FTP_ERROR_NO];
        } break;
        default: {
            assert(NO);
        } break;
    }
}


- (void)stopWithStatus:(FTP_ERROR)ftpError
{
    
    if (ftpError == FTP_ERROR_NO) {
//        [self.delegate performSelector:@selector(receiveFileDidfinished)];
//        [((NSObject *)delegate) performSelectorOnMainThread:@selector(receiveFileDidfinished) withObject:nil waitUntilDone:NO];
        [self.delegate receiveFileDidfinished];
    }else{
//        [((NSObject *)delegate) performSelectorOnMainThread:@selector(receiveFileStoped:) withObject:[NSNumber numberWithInt:ftpError] waitUntilDone:NO];
        //        [self.delegate performSelector:@selector(receiveFileStoped:) withObject:[NSNumber numberWithInt:ftpError]];
        [self.delegate receiveFileStoped:ftpError];
    }
    
    
    if (self.ftpStream != nil) {
        @try {
            [self.ftpStream removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
        }
        @catch (NSException *exception) {
            NSLog(@"======%@", [exception reason]);
        }
        @finally {
            
        }

        self.ftpStream.delegate = nil;
        [self.ftpStream close];
        self.ftpStream = nil;
        [currentRunLoop release];
        currentRunLoop = nil;
    }
    if (self.fileStream != nil) {
        [self.fileStream close];
        self.fileStream = nil;
    }

	//CFRunLoopStop(runLoop);
}

- (void)dealloc {
	[userName release];
	[passWord release];
	
	[serverPath release];
	[localPath release];
	[fileName release];
    
    [fileStream release];
	
	[strStatus release];
	
	[super dealloc];
}


@end
