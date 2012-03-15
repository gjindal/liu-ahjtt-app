//
//  NewsClueParserHelperDelegate.h
//  NewsGathering
//
//  Created by XiguaZerg on 12-2-21.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol NewsClueParserHelperDelegate <NSObject>

- (void)parserDidFinished:(NSArray *)newsCLueInfoArray;

@end
