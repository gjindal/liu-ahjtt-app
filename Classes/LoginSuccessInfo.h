//
//  LoginSuccessInfo.h
//  NewsGathering
//
//  Created by XiguaZerg on 12-2-22.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LoginResultInfo.h"

@interface FTPInfo : NSObject {
@private
    NSString *_ftpUsername;
    NSString *_ftpPassword;
    NSString *_ftpURL;
}
@property (nonatomic, retain) NSString *ftpUsername;
@property (nonatomic, retain) NSString *ftpPassword;
@property (nonatomic, retain) NSString *ftpURL;

@end

@interface DirtInfo : NSObject {
@private
    NSString *_dic_desc;
    NSString *_dic_key;
    NSString *_dic_type;
    NSString *_dic_value;
}

@property (nonatomic, retain) NSString *dic_desc;
@property (nonatomic, retain) NSString *dic_key;
@property (nonatomic, retain) NSString *dic_type;
@property (nonatomic, retain) NSString *dic_value;

@end

@interface MenuInfo : NSObject {
@private
    NSString *_linkURL;
    NSString *_nodeCode;
    NSString *_nodeName;
    NSString *_viewSec;
    NSMutableArray *_funcs;
}

@property (nonatomic, retain) NSString *linkURL;
@property (nonatomic, retain) NSString *nodeCode;
@property (nonatomic, retain) NSString *nodeName;
@property (nonatomic, retain) NSString *viewSec;
@property (nonatomic, retain) NSMutableArray *funcs;

@end

@interface FuncationInfo : NSObject {
@private
    NSString *_funcationCode;
    NSString *_funcationName;
    NSString *_id;
}

@property (nonatomic, retain) NSString *funcationCode;
@property (nonatomic, retain) NSString *funcationName;
@property (nonatomic, retain) NSString *id;

@end

@interface LoginSuccessInfo : LoginResultInfo {
@private
    NSString *_id;
    NSString *_roleName;
    NSString *_sex;
    NSString *_userName;
    NSMutableArray *_dictList;
    NSMutableArray *_menuList;
    FTPInfo *_ftpInfo;
}

@property (nonatomic, retain) FTPInfo *ftpInfo;
@property (nonatomic, retain) NSString *id;
@property (nonatomic, retain) NSString *roleName;
@property (nonatomic, retain) NSString *sex;
@property (nonatomic, retain) NSString *userName;
@property (nonatomic, retain) NSMutableArray *dictList;
@property (nonatomic, retain) NSMutableArray *menuList;

@end
