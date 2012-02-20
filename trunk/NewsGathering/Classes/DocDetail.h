//
//  DocDetail.h
//  NewsGathering
//
//  Created by XiguaZerg on 12-2-20.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DocDetail : NSObject<NSCoding> {
@private
    NSString            *_UUID;
    NSString            *_title;
    NSString            *_docType;
    NSString            *_key;
    NSString            *_source;
    NSString            *_content;
    NSMutableArray      *_attachments;
}

@property (nonatomic, readonly) NSString          *UUID;
@property (nonatomic, retain)   NSString          *title;
@property (nonatomic, retain)   NSString          *docType;
@property (nonatomic, retain)   NSString          *key;
@property (nonatomic, retain)   NSString          *source;
@property (nonatomic, retain)   NSString          *content;
@property (nonatomic, retain)   NSMutableArray    *attachments;

@end
