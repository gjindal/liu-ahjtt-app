//
//  ImagePlayViewController.h
//  NewsGathering
//
//  Created by XiguaZerg on 12-2-16.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImagePlayViewController : UIViewController {

@private
    UIImage *_image;
    NSString *_imageName;
    NSString *_selectedImageName;
}

@property (nonatomic, retain) UIImage *image;
@property (nonatomic, retain) NSString *imageName;
@property (nonatomic, retain) NSString *selectedImageName;
@property (nonatomic, assign) BOOL      showSelectButton;

- (void)selectImage;

@end
