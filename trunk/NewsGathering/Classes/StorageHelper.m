//
//  StorageHelper.m
//  NewsGathering
//
//  Created by XiguaZerg on 12-2-14.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "StorageHelper.h"
#import "UserHelper.h"

@implementation StorageHelper

@synthesize baseDirectory = _baseDirectory;

- (id)init {
    
    self = [super init];
    if(self != nil) {
        
        // Generate the path to the new directory
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
        _baseDirectory = [[NSString stringWithFormat:@"%@/StoreMedia", [paths objectAtIndex:0]] retain];
        
        // Check if the directory already exists
        if (![[NSFileManager defaultManager] fileExistsAtPath:_baseDirectory]) {
            // Directory does not exist so create it
            if([[NSFileManager defaultManager] createDirectoryAtPath:_baseDirectory withIntermediateDirectories:YES attributes:nil error:nil] == YES) {
            
                [self checkUserFloder:[UserHelper userName]];
            }
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
    
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSSharedPublicDirectory, NSUserDomainMask, YES);
//    NSString *sharedPublicDirectory = [paths objectAtIndex:0];
//    if(!sharedPublicDirectory) {
//        return NO;
//    }
    NSString *deleteFile = [_baseDirectory stringByAppendingPathComponent:fileName];
    return  [[NSFileManager defaultManager] removeItemAtPath:deleteFile error:nil];
}

- (NSData *)readFileWithName:(NSString *)fileName {

//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSSharedPublicDirectory, NSUserDomainMask, YES);
//    NSString *sharedPublicDirectory = [paths objectAtIndex:0];
    NSString *readFile = [_baseDirectory stringByAppendingPathComponent:fileName];
    NSData *fileData = [[[NSData alloc] initWithContentsOfFile:readFile] autorelease];
    return fileData;
}

- (void)checkUserFloder:(NSString *)userName {

    if(userName == nil || [userName isEqualToString:@""]) {
        //_userDirectory = [_baseDirectory retain];
        return;
    }
    NSString *userFloderPath = [_baseDirectory stringByAppendingFormat:@"/%@", userName];
    if(![[NSFileManager defaultManager] fileExistsAtPath:userFloderPath]) {
    
        if([[NSFileManager defaultManager] createDirectoryAtPath:userFloderPath withIntermediateDirectories:YES attributes:nil error:nil] == YES) {
        
            [_baseDirectory release];
            _baseDirectory = nil;
            _baseDirectory = [userFloderPath retain];
        }
    }
}

- (void)dealloc {

    [_baseDirectory release];
    
    [super release];
}

@end
