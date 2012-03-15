//
//  DeptInfo.h
//  NewsGathering
//
//  Created by XiguaZerg on 12-2-20.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DeptInfo : NSObject {
@private
    NSString    *_deptID;
    NSString    *_deptName;
    NSString    *_parentID;
}

@property (nonatomic, retain) NSString  *deptID;
@property (nonatomic, retain) NSString  *deptName;
@property (nonatomic, retain) NSString  *parentID;

@end
