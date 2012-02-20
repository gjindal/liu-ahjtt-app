//
//  LoginParserHelperDelegate.h
//  NewsGathering
//
//  Created by XiguaZerg on 12-2-20.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LoginResultInfo;

@protocol LoginParserHelperDelegate <NSObject>
@optional

- (void)parserDidFinished:(LoginResultInfo *)resultInfo;

@end
