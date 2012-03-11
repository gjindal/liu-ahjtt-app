//
//  FileFTPInfo.h
//  NewsGathering
//
//  Created by XiguaZerg on 12-3-11.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {

    FTP_TYPE_UPLOAD,
    FTP_TYPE_DOWNLOAD
    
} FTP_TYPE;

@interface FileFTPInfo : NSObject<NSObject> {
@private
    FTP_TYPE _ftpType;
    NSString *_fileName;
    BOOL     _Completed;
}

@property (nonatomic) FTP_TYPE          ftpType;
@property (nonatomic, retain) NSString *fileName;
@property (nonatomic, assign) BOOL      completed;

@end
