//
//  NewsClueInfo.h
//  NewsGathering
//
//  Created by XiguaZerg on 12-2-21.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewsClueInfo : NSObject {
@private
    NSString    *_keyID;
    NSString    *_title;
    NSString    *_keyword;
    NSString    *_status;
    NSString    *_note;
    NSString    *_type;
    NSString    *_begTimeShow;
    NSString    *_endTimeShow;
    
    NSString    *_flag;
    NSString    *_message;
}

@property (nonatomic, retain) NSString  *keyid;
@property (nonatomic, retain) NSString  *title;
@property (nonatomic, retain) NSString  *keyword;
@property (nonatomic, retain) NSString  *status;
@property (nonatomic, retain) NSString  *note;
@property (nonatomic, retain) NSString  *type;
@property (nonatomic, retain) NSString  *begtimeshow;
@property (nonatomic, retain) NSString  *endtimeshow;

@property (nonatomic, retain) NSString  *flag;
@property (nonatomic, retain) NSString  *message;

@end