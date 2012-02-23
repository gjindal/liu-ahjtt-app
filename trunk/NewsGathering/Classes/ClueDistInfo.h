//
//  ClueDistInfo.h
//  NewsGathering
//
//  Created by XiguaZerg on 12-2-23.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ClueDistInfo : NSObject {
@private
    NSString *_begtimeshow;
    NSString *_endtimeshow;
    NSString *_keyid;
    NSString *_keyword;
    NSString *_note;
    NSString *_sendUserName;
    NSString *_status;
    NSString *_title;
    NSString *_type;
}

@property (nonatomic, retain) NSString *begtimeshow;
@property (nonatomic, retain) NSString *endtimeshow;
@property (nonatomic, retain) NSString *keyid;
@property (nonatomic, retain) NSString *keyword;
@property (nonatomic, retain) NSString *note;
@property (nonatomic, retain) NSString *sendUserName;
@property (nonatomic, retain) NSString *status;
@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSString *type;

@end
