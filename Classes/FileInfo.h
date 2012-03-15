//
//  FileInfo.h
//  NewsGathering
//
//  Created by 刘 学雁 on 12-3-11.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FileInfo : NSObject{
    
}

+ (NSURL *)smartURLForString:(NSString *)str;
+ (uint64_t) getFTPStreamSize:(CFReadStreamRef)stream;

+ (NSString*) pathForDocument;
+ (uint64_t) getFileSize:(NSString *)filePath;

@end
