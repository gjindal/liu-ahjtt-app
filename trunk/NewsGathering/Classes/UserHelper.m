//
//  UserHelper.m
//  NewsGathering
//
//  Created by XiguaZerg on 2/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "UserHelper.h"
#import "NewsGatheringAppDelegate.h"

@implementation UserHelper

+ (NSString *)userName {

    NewsGatheringAppDelegate *delegate = (NewsGatheringAppDelegate *)[[UIApplication sharedApplication] delegate];
    if(delegate != nil) {
    
        return delegate.username;
    }
    
    return nil;
}

+ (NSString *)password {

    NewsGatheringAppDelegate *delegate = (NewsGatheringAppDelegate *)[[UIApplication sharedApplication] delegate];
    if(delegate != nil) {
        
        return delegate.password;
    }
    
    return nil;
}

@end
