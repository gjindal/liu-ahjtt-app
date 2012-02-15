//
//  MyAlertView.h
//  NewsGathering
//
//  Created by XiguaZerg on 12-2-11.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@interface MyAlertView : UIAlertView <AVAudioRecorderDelegate> {

@private
    AVAudioRecorder *_recorder;
    NSString *_fileName;
}
@end
