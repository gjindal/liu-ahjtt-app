//
//  DocDetailHelper.h
//  NewsGathering
//
//  Created by XiguaZerg on 12-2-20.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StorageHelper.h"

@class DocDetail;

@interface DocDetailHelper : StorageHelper {
@private
    NSDateFormatter *_dataFormatter;
}

- (NSArray *)getAllDocDetail;
- (DocDetail *)getDocByUUID:(NSString *)UUID;
- (BOOL)writeToFile:(DocDetail *)docDetail;
- (BOOL)updateDoc:(DocDetail *)docDetail;
- (BOOL)deleteDoc:(DocDetail *)docDetail;

@end
