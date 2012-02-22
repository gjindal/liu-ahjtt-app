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
    NSString    *_begTimeShow;
}

@property (nonatomic, retain) NSString  *keyid;
@property (nonatomic, retain) NSString  *status;
@property (nonatomic, retain) NSString  *title;
@property (nonatomic, retain) NSString  *begtimeshow;
@property (nonatomic, retain) NSString  *note;
@property (nonatomic, retain) NSString  *keword;

@end