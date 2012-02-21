//
//  NewsClueRequestDelegate.h
//  NewsGathering
//
//  Created by XiguaZerg on 12-2-21.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#ifndef NewsGathering_NewsClueRequestDelegate_h
#define NewsGathering_NewsClueRequestDelegate_h

#import <Foundation/Foundation.h>

@protocol NewsClueRequestDelegate <NSObject>

- (void)dataDidResponsed:(NSArray *)newsCLueInfoArray flag:(int)flag;

@end

#endif
