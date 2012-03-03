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
    
        _dataFormatter = [[NSDateFormatter alloc] init];
        [_dataFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    }
    return self;
}

- (void)dealloc {

    [_dataFormatter release];
    _dataFormatter = nil;
    
    [super dealloc];
}

#pragma -
#pragma Public Methods.

- (NSArray *)getAllDocDetail {

    NSMutableArray *docArray = [[NSMutableArray alloc] initWithCapacity:0];
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
    
    NSArray *tempArray = [docArray sortedArrayUsingComparator:^(DocDetail *path1, DocDetail *path2) {
        
        NSComparisonResult comp = [path1.saveTime compare: path2.saveTime];
        // invert ordering
        if (comp == NSOrderedDescending) {
            comp = NSOrderedAscending;
        }
        else if(comp == NSOrderedAscending){
            comp = NSOrderedDescending;
        }
        return comp;   
    }];
    
    [docArray removeAllObjects];
    [docArray addObjectsFromArray:tempArray];
    
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
        
        docDetail.saveTime = [_dataFormatter stringFromDate:[NSDate date]];
        
        BOOL result = [NSKeyedArchiver archiveRootObject:docDetail toFile:filePath];
        return  result;
    }

    return NO;
}

- (BOOL)updateDoc:(DocDetail *)docDetail {
    
    if(docDetail != nil) {
    
        return [self writeToFile:docDetail];   
    }
    
    return NO;
}

- (BOOL)deleteDoc:(DocDetail *)docDetail {

    if(docDetail != nil) {
    
        if(docDetail.attachments != nil) {
        
            for (NSString *attach in docDetail.attachments) {
                [self deleteFileWithName:attach];
            }
        }
        
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
