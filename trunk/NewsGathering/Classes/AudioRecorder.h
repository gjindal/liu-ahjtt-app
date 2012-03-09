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
    BOOL                 _recording;
    NSTimeInterval       _timeInterval;
}

@property (nonatomic, retain) NSString *fileName;
@property (nonatomic, assign) BOOL      Recoding;

- (void)start;
- (void)stop;
- (void)pause;
- (void)resume;

@end
