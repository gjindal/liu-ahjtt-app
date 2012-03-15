//
//  LoginResultInfo.h
//  NewsGathering
//
//  Created by XiguaZerg on 12-2-20.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoginResultInfo : NSObject {
@private
    BOOL        _isLoginSuccess;
    int         _flag;
    NSString   *_message;
}

@property (nonatomic, assign) BOOL      isLoginSuccess;
@property (nonatomic, assign) int       flag;
@property (nonatomic, retain) NSString  *message;

@end
