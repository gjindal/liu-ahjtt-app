//
//  FTPStoreHelper.h
//  NewsGathering
//
//  Created by XiguaZerg on 12-3-11.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DocFTPInfo;

@interface FTPStoreHelper : NSObject {
@private
    NSMutableArray  *_DocList;
    NSString        *_baseDirectory;
}

- (DocFTPInfo *)getDocFTPWithFlowID:(NSString *)flowID;
- (BOOL)Insert:(DocFTPInfo *)ftpInfo;
- (BOOL)Delete:(NSString *)flowID;
@end
