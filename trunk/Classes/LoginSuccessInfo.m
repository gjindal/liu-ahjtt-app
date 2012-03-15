//
//  LoginSuccessInfo.m
//  NewsGathering
//
//  Created by XiguaZerg on 12-2-22.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "LoginSuccessInfo.h"

#pragma -
#pragma DirtInfo Implementation.

@implementation FTPInfo

@synthesize ftpPassword = _ftpPassword;
@synthesize ftpUsername = _ftpUsername;
@synthesize ftpURL = _ftpURL;

-(void) dealloc{
    [_ftpPassword release];
    [_ftpUsername release];
    [_ftpURL release];
    
    [super dealloc];
}

@end

@implementation DirtInfo

@synthesize dic_desc = _dic_desc;
@synthesize dic_key = _dic_key;
@synthesize dic_type = _dic_type;
@synthesize dic_value = _dic_value;

- (void)dealloc {

    [_dic_desc release];
    [_dic_key release];
    [_dic_type release];
    [_dic_value release];
    
    _dic_desc = nil;
    _dic_key = nil;
    _dic_type = nil;
    _dic_value = nil;
    
    [super dealloc];
}

@end

#pragma -
#pragma MenuInfo Implementation.

@implementation MenuInfo

@synthesize linkURL = _linkURL;
@synthesize nodeCode = _nodeCode;
@synthesize nodeName = _nodeName;
@synthesize viewSec = _viewSec;
@synthesize funcs = _funcs;

- (id)init {

    self = [super init];
    if(self != nil) {
    
        _funcs = [[NSMutableArray alloc] initWithCapacity:0];
    }
    
    return self;
}

- (void)dealloc {

    [_linkURL release];
    [_nodeCode release];
    [_nodeName release];
    [_viewSec release];
    [_funcs release];
    
    _linkURL = nil;
    _nodeCode = nil;
    _nodeName = nil;
    _viewSec = nil;
    _funcs = nil;
    
    [super dealloc];
}

@end

#pragma -
#pragma FuncationInfo Implementation.

@implementation FuncationInfo

@synthesize funcationCode = _funcationCode;
@synthesize funcationName = _funcationName;
@synthesize id = _id;

- (void)dealloc {

    [_funcationCode release];
    [_funcationName release];
    [_id release];
    
    _funcationCode = nil;
    _funcationName = nil;
    _id = nil;
    
    [super dealloc];
}

@end

#pragma -
#pragma LoginSuccessInfo Implementation.

@implementation LoginSuccessInfo

@synthesize id = _id;
@synthesize roleName = _roleName;
@synthesize sex = _sex;
@synthesize userName = _userName;
@synthesize dictList = _dictList;
@synthesize menuList = _menuList;
@synthesize ftpInfo = _ftpInfo;

- (id)init {

    self = [super init];
    if(self != nil) {
    
        _dictList = [[NSMutableArray alloc] initWithCapacity:0];
        _menuList = [[NSMutableArray alloc] initWithCapacity:0];
    }
    
    return self;
} 

- (void)dealloc {

    [_id release];
    [_roleName release];
    [_sex release];
    [_userName release];
    [_dictList release];
    [_menuList release];
    
    _id = nil;
    _roleName = nil;
    _sex = nil;
    _userName = nil;
    _dictList = nil;
    _menuList = nil;
    
    [super dealloc];
}

@end
