//
//  DocRequest.h
//  NewsGathering
//
//  Created by XiguaZerg on 2/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Contants.h"
#import "ContributeInfo.h"
#import "DocParserHelperDelegate.h"
#import "DocParserHelper.h"
#import "DocRequestDelegate.h"
#import "NetRequest.h"


@interface DocRequest : NetRequest<DocParserHelperDelegate> {
@private
    id<DocRequestDelegate>      _delegate;
    DocParserHelper            *_parser;
}

@property (nonatomic, assign) id<DocRequestDelegate> delegate;

- (void)getDocListWithTitle:(NSString *)title Keyword:(NSString *)keyword 
                       Type:(NSString *)type Begtime:(NSString *)begtime
                    Endtime:(NSString *)endtime;
- (void)getDocDetailWithConid:(NSString *)conid;
- (void)addDocWithTitle:(NSString *)title Keyword:(NSString *)keyword
                   Note:(NSString *)note Source:(NSString *)source
                   Type:(NSString *)type Level:(NSString *)level;
- (void)updateDocWithTitle:(NSString *)title Keyword:(NSString *)keyword
                      Note:(NSString *)note Source:(NSString *)source
                      Type:(NSString *)type Level:(NSString *)level
                     Conid:(NSString *)conid;
- (void)deleteDocWithConid:(NSString *)conid;
- (void)submitDocWithConid:(NSString *)conid Receptuserid:(NSString *)receptuserid
                    Status:(NSString *)status;
- (void)resumeDocWithConid:(NSString *)conid;
- (void)removeDocWithConid:(NSString *)conid;
- (void)getAppListWithTitle:(NSString *)title Keyword:(NSString *)keyword
                       Type:(NSString *)type Begtime:(NSString *)begtime
                    Endtime:(NSString *)endtime;
- (void)approveWithConid:(NSString *)conid Apps:(NSString *)apps;
@end
