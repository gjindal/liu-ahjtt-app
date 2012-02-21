//
//  NewClueParserHelper.h
//  NewsGathering
//
//  Created by XiguaZerg on 12-2-21.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NewsClueParserHelperDelegate.h"
#import "NewsClueInfo.h"

@interface NewsClueParserHelper : NSObject <NSXMLParserDelegate> {
@private
    id<NewsClueParserHelperDelegate>    _delegate;
    NSXMLParser                        *_xmlParser;
    NSString                           *_currentValue;
    NSMutableArray                     *_array;
    NewsClueInfo                       *_info;
}

@property (nonatomic, assign) id<NewsClueParserHelperDelegate>  delegate;

- (void)startWithXMLInfo:(NSString *)xmlInfo;

@end
