//
//  UserInfo.h
//  NewsGathering
//
//  Created by XiguaZerg on 12-2-23.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfo : NSObject {
@private
    NSString *_userID;
    NSString *_userName;
}

@property (nonatomic, retain) NSString *userID;
@property (nonatomic, retain) NSString *userName;

@end
