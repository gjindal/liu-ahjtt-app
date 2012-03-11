//
//  DocFTPInfo.h
//  NewsGathering
//
//  Created by XiguaZerg on 12-3-11.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FileFTPInfo;

@interface DocFTPInfo : NSObject<NSCoding> {
@private
    NSString        *_flowID;
    NSMutableArray  *_fileFTPList;
}

@property (nonatomic, retain) NSString          *flowID;
@property (nonatomic, retain) NSMutableArray    *fileFTPList;

- (FileFTPInfo *)getFileInfoWithFileName:(NSString *)fileName;
@end
