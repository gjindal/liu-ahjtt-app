//
//  UITableViewCellEx.h
//  NewsGathering
//
//  Created by 刘 学雁 on 12-2-15.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UITableViewCell (UITableViewCellEx)

- (void)setBackgroundImage:(UIImage*)image;
- (void)setBackgroundImageByName:(NSString*)imageName;

@end