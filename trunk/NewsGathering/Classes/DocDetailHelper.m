//
//  DocDetailHelper.m
//  NewsGathering
//
//  Created by XiguaZerg on 12-2-20.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "DocDetailHelper.h"
#import "DocDetail.h"

@interface DocDetailHelper (PrivateMethods)

- (DocDetail *)getDocByFileName:(NSString *)fileName;

@end

@implementation DocDetailHelper

- (id)init {

    self = [super init];
    if(self != nil) {
    
    }
    return self;
}

#pragma -
#pragma Public Methods.

- (NSArray *)getAllDocDetail {

    NSMutableArray *docArray = [[NSMutableArray alloc] initWithCapacity:0];
    NSString *tempString = _baseDirectory;
    NSArray *subFiles = [self getSubFiles];
    NSString *fileType = nil;
    BOOL isDoc = NO;
    for (NSString *subFile in subFiles) {
        isDoc = NO;
        if([subFile length] >= 5) {
        
            fileType = [subFile substringWithRange:NSMakeRange(0, 5)];
            
            if([fileType isEqualToString:kMediaType_Docum]) {
            
                isDoc = YES;
            }
            
        }else {
        
            isDoc = YES;
        }
        
        if(isDoc == YES) {
        
            [docArray addObject:[self getDocByFileName:subFile]];
        }
    }
    
    return [(NSArray *)docArray autorelease];
}

- (DocDetail *)getDocByUUID:(NSString *)UUID {
    
    NSArray *tempArray = [self getAllDocDetail];
    
    for (DocDetail *doc in tempArray) {
        if([doc.UUID isEqualToString:UUID] == YES) {
        
            return doc;
        }
    }
    
    return nil;
}

- (BOOL)writeToFile:(DocDetail *)docDetail {
    
    if(docDetail != nil) {
    
        NSString *fileName = [NSString stringWithFormat:@"%@_%@", kMediaType_Docum, docDetail.UUID, nil];
        NSString *filePath = [_baseDirectory stringByAppendingPathComponent:fileName];
        
        BOOL result = [NSKeyedArchiver archiveRootObject:docDetail toFile:filePath];
        return  result;
    }

    return NO;
}

- (BOOL)updateDoc:(DocDetail *)docDetail {
    
    if(docDetail != nil) {
    
        //NSString *fileName = [NSString stringWithFormat:@"%@_%@", kMediaType_Docum, docDetail.UUID, nil];
        BOOL result = [self deleteDoc:docDetail];
        if(result == YES) {
        
            return [self writeToFile:docDetail];   
        }else {
        
            return NO;
        }
    }
    
    return NO;
}

- (BOOL)deleteDoc:(DocDetail *)docDetail {

    if(docDetail != nil) {
    
        NSString *fileName = [NSString stringWithFormat:@"%@_%@", kMediaType_Docum, docDetail.UUID, nil];
        BOOL result = [self deleteFileWithName:fileName];
        return result;
    }
    
    
    return NO;
}

#pragma -
#pragma Private Methods.

- (DocDetail *)getDocByFileName:(NSString *)fileName {

    if(fileName != nil && [fileName length] > 0) {
    
        NSString *filePath = [_baseDirectory stringByAppendingPathComponent:fileName];
        DocDetail *docDetail = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
        return  docDetail;
    }
    
    return nil;
}

@end
