//
//  StorageHelper.h
//  NewsGathering
//
//  Created by XiguaZerg on 12-2-14.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kMediaType_Image @"Image"
#define kMediaType_Video @"Video"
#define kMediaType_Audio @"Audio"
#define kMediaType_Docum @"Docum"

@interface StorageHelper : NSObject {
@protected
    NSString *_baseDirectory;
}

@property (nonatomic, retain) NSString *baseDirectory;

- (NSArray *)getSubFiles;
- (BOOL)createFileWithName:(NSString *)fileName data:(NSData *)data;
- (BOOL)deleteFileWithName:(NSString *)fileName;
- (NSData *)readFileWithName:(NSString *)fileName;
- (void)checkUserFloder:(NSString *)userName;

@end
