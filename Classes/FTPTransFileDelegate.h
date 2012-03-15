//
//  FTPTransFileDelegate.h
//  NewsGathering
//
//  Created by 刘 学雁 on 12-3-10.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#define kBufferSize 81920

typedef enum {
    FTP_ERROR_NO,
    FTP_ERROR_NETWORK,
    FTP_ERROR_WRITEFILE,
    FTP_ERROR_READFILE,
    FTP_ERROR_REMOTEFILE,
    FTP_ERROR_STOPCMD,
    FTP_ERROR_OTHERS
}FTP_ERROR;

@protocol FTPTransFileDelegate <NSObject>
@optional

- (void)sendFileDidfinished;
- (void)receiveFileDidfinished;
- (void)sendFileStoped:(FTP_ERROR) ftpError;
- (void)receiveFileStoped:(FTP_ERROR) ftpError;

@end
