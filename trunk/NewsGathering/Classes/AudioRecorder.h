//
//  MyAlertView.h
//  NewsGathering
//
//  Created by XiguaZerg on 12-2-11.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@class StorageHelper;

@interface AudioRecorder : UIAlertView {

@private
    AVAudioRecorder     *_recorder;
    NSString            *_fileName;
    UILabel             *_timeLabel;
    NSTimer             *_timer;
    NSDate              *_fireDate;
    StorageHelper       *_storeHelper;
}

@property (nonatomic, retain) NSString *fileName;

@end
