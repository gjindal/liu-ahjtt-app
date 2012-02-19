//
//  AudioPlayer.h
//  NewsGathering
//
//  Created by XiguaZerg on 12-2-18.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@interface AudioPlayer : UIAlertView <AVAudioPlayerDelegate> {
@private
    NSData *_audioData;
    AVAudioPlayer *_player;
    BOOL _playing;
    UILabel             *_timeLabel;
    NSTimer             *_timer;
    NSDate              *_fireDate;
}

@property (nonatomic, retain) NSData *audioData;

@end
