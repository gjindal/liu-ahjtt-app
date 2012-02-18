//
//  StorageHelper.h
//  NewsGathering
//
//  Created by XiguaZerg on 12-2-14.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StorageHelper : NSObject {
@private
    NSString *_baseDirectory;
}

@property (nonatomic, retain) NSString *baseDirectory;

- (NSArray *)getSubFiles;
- (BOOL)createFileWithName:(NSString *)fileName data:(NSData *)data;
- (BOOL)deleteFileWithName:(NSString *)fileName;
- (NSData *)readFileWithName:(NSString *)fileName;
- (void)checkUserFloder:(NSString *)userName;

@end
