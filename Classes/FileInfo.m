//
//  FileInfo.m
//  NewsGathering
//
//  Created by 刘 学雁 on 12-3-11.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "FileInfo.h"

@implementation FileInfo

+ (NSURL *)smartURLForString:(NSString *)str
{
    NSURL *     result;
    NSString *  trimmedStr;
    NSRange     schemeMarkerRange;
    NSString *  scheme;
    
    assert(str != nil);
	
    //result = nil;
    
    trimmedStr = [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if ( (trimmedStr != nil) && (trimmedStr.length != 0) ) {
        schemeMarkerRange = [trimmedStr rangeOfString:@"://"];
        
        if (schemeMarkerRange.location == NSNotFound) {
            NSString *url = [NSString stringWithFormat:@"ftp://%@", trimmedStr];
            result = [[NSURL alloc] initWithString:url];
            
            NSLog(@"=====%@",[NSString stringWithFormat:@"ftp://%@", trimmedStr]);
        } else {
            scheme = [trimmedStr substringWithRange:NSMakeRange(0, schemeMarkerRange.location)];
            assert(scheme != nil);
            
            if ( ([scheme compare:@"ftp"  options:NSCaseInsensitiveSearch] == NSOrderedSame) ) {
                result = [NSURL URLWithString:trimmedStr];
            } else {
                // It looks like this is some unsupported URL scheme.
            }
        }
    }
    
    return [result retain];
}


+ (uint64_t) getFTPStreamSize:(CFReadStreamRef)stream {
	return 0ll;
}


+ (NSString*) pathForDocument {
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	if ([paths count] > 0) {
		NSString *userDocumentsPath = [paths objectAtIndex:0];
		// Implementation continues...
		return userDocumentsPath;
	}
	
	return nil;
}

+ (uint64_t) getFileSize:(NSString *)filePath {
	NSFileManager * fileManager = [NSFileManager defaultManager];
	NSDictionary  * dict = [fileManager attributesOfItemAtPath:filePath error:nil];
	return [dict fileSize];
}

@end
