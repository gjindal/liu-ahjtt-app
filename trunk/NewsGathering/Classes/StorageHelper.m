//
//  StorageHelper.m
//  NewsGathering
//
//  Created by XiguaZerg on 12-2-14.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "StorageHelper.h"

@implementation StorageHelper

- (id)init {
    
    self = [super init];
    if(self != nil) {
        
        // Generate the path to the new directory
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
        _baseDirectory = [[NSString stringWithFormat:@"%@/StoreMedia", [paths objectAtIndex:0]] retain];
        
        // Check if the directory already exists
        if (![[NSFileManager defaultManager] fileExistsAtPath:_baseDirectory]) {
            // Directory does not exist so create it
            [[NSFileManager defaultManager] createDirectoryAtPath:_baseDirectory withIntermediateDirectories:YES attributes:nil error:nil];
        }
    }
    
    return self;
}

- (NSArray *)getSubFiles {

    NSArray * tempArray = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:_baseDirectory error:nil ];
    return tempArray;
}

- (BOOL)createFileWithName:(NSString *)fileName data:(NSData *)data {
    
    NSString *appFile = [_baseDirectory stringByAppendingPathComponent:fileName];
    return ([data writeToFile:appFile atomically:YES]);
}

- (BOOL)deleteFileWithName:(NSString *)fileName {
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSSharedPublicDirectory, NSUserDomainMask, YES);
    NSString *sharedPublicDirectory = [paths objectAtIndex:0];
    if(!sharedPublicDirectory) {
        return NO;
    }
    NSString *deleteFile = [sharedPublicDirectory stringByAppendingPathComponent:fileName];
    return  [[NSFileManager defaultManager] removeItemAtPath:deleteFile error:nil];
}

- (NSData *)readFileWithName:(NSString *)fileName {

//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSSharedPublicDirectory, NSUserDomainMask, YES);
//    NSString *sharedPublicDirectory = [paths objectAtIndex:0];
    NSString *readFile = [_baseDirectory stringByAppendingPathComponent:fileName];
    NSData *fileData = [[[NSData alloc] initWithContentsOfFile:readFile] autorelease];
    return fileData;
}

@end
