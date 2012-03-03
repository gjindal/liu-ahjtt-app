//
//  DocDetail.h
//  NewsGathering
//
//  Created by XiguaZerg on 12-2-20.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#define DOC_STATUS_UNSUMMIT @"1024"
#define DOC_STATUS_SUMMITED @"2048"

@interface DocDetail : NSObject<NSCoding> {
@private
    NSString            *_UUID;
    NSString            *_title;
    NSString            *_docType;
    NSString            *_key;
    NSString            *_source;
    NSString            *_level;
    NSString            *_recevicer;
    NSString            *_content;
    NSString            *_saveTime;
    NSString            *_status;
    NSMutableArray      *_attachments;
}

@property (nonatomic, retain)   NSString          *UUID;
@property (nonatomic, retain)   NSString          *title;
@property (nonatomic, retain)   NSString          *docType;
@property (nonatomic, retain)   NSString          *key;
@property (nonatomic, retain)   NSString          *source;
@property (nonatomic, retain)   NSString          *level;
@property (nonatomic, retain)   NSString          *recevicer;
@property (nonatomic, retain)   NSString          *content;
@property (nonatomic, retain)   NSString          *saveTime;
@property (nonatomic, retain)   NSString          *status;
@property (nonatomic, retain)   NSMutableArray    *attachments;

@end
