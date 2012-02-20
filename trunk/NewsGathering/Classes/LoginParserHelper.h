//
//  LoginParserHelper.h
//  NewsGathering
//
//  Created by XiguaZerg on 12-2-20.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LoginParserHelperDelegate.h"

@class LoginResultInfo;

@interface LoginParserHelper : NSObject<NSXMLParserDelegate> {
@private
    id<LoginParserHelperDelegate>   _delegate;
    NSXMLParser                     *_xmlParser;
    NSString                        *_currentValue;
    LoginResultInfo                 *_loginResultInfo;
}

@property (nonatomic, assign) id<LoginParserHelperDelegate> delegate;

- (void)startWithString:(NSString *)xmlInfo;

@end
