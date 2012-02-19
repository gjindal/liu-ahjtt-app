//
//  AudioPlayer.m
//  NewsGathering
//
//  Created by XiguaZerg on 12-2-18.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "AudioPlayer.h"

@interface AudioPlayer (PrivateMethods)

- (void)start;
- (void)pause;
- (void)stop;
- (void)setLabelText;

@end

@implementation AudioPlayer

@synthesize audioData = _audioData;

- (id)initWithTitle:(NSString *)title message:(NSString *)message delegate:(id /*<UIAlertViewDelegate>*/)delegate cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ... {
    
    //self = [super initWithTitle:title message:message delegate:delegate cancelButtonTitle:cancelButtonTitle otherButtonTitles:otherButtonTitles, nil];
    self = [super init];
    if(self != nil) {
        
        self.title = title;
		self.message = message;
		self.delegate = delegate;
        
		if ( nil != cancelButtonTitle )
		{
			[self addButtonWithTitle: cancelButtonTitle ];
			self.cancelButtonIndex = 0;
		}
        
		if ( nil != otherButtonTitles )
		{
			[self addButtonWithTitle: otherButtonTitles ];
            
			va_list args;
			va_start(args, otherButtonTitles);
            
			id arg;
			while ( nil != ( arg = va_arg( args, id ) ) ) 
			{
				if ( ![arg isKindOfClass: [NSString class] ] )
					return nil;
                
				[self addButtonWithTitle: (NSString*)arg ];
			}
		}
        
        _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 165.0f, 280.0f, 60.0f)];
        _timeLabel.backgroundColor = [UIColor clearColor];
        _timeLabel.textAlignment = UITextAlignmentCenter;
        _timeLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:40.0f];
        _timeLabel.textColor = [UIColor whiteColor];
        _timeLabel.text = @"00:00:00";
        [self addSubview:_timeLabel];
        [_timeLabel release];
    }
    
    return self;
}

-(void)dismissWithClickedButtonIndex:(NSInteger)buttonIndex animated:(BOOL)animated {
    
    if(buttonIndex == 0) {
        
        UIView *subView = [self viewWithTag:1];
        if(subView != nil) {
            
            UILabel *subLabel = (UILabel *)[subView viewWithTag:101];
            if([subLabel.text isEqualToString:@"开始"]) {
                
                [self start];
                
                subLabel.text = @"暂停";
            }else {
                
                [self pause];
                [super dismissWithClickedButtonIndex:buttonIndex animated:animated];
            }
        }
        
    }else {
        
        [self stop];
        [super dismissWithClickedButtonIndex:buttonIndex animated:animated];
    }
    
}

#pragma -
#pragma Private Methods.

- (void)start {

    if(_audioData != nil) {
    
        if(_playing == YES) {
        
            [_player play];
        }else {
        
            [_player release];
            _player = nil;
            
            _playing = YES;
            
            _player = [[AVAudioPlayer alloc] initWithData:_audioData error:nil];
            _player.delegate = self;
            if([_player prepareToPlay] == YES) {
            
                [_player play];
                _fireDate = [[NSDate date] retain];
                _timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(setLabelText) userInfo:nil repeats:YES];
            }
        }
    }
}

- (void)pause {

    if(_player != nil) {
    
        [_player pause];
    }
}

- (void)stop {

    if(_player != nil) {
    
        [_player stop];
        [_player release];
        _player = nil;
        
        _playing = NO;
    }
    
    if(_timer != nil) {
        
        if([_timer isValid] == YES) {
            
            [_timer invalidate];
            _timer = nil;
        }
        
        [_fireDate release];
        _fireDate = nil;
    }
}

- (void)setLabelText {
    
    NSTimeInterval intervalSeconds = [[NSDate date] timeIntervalSinceDate:_fireDate];
    int hour = 0;
    int minute = 0;
    int second = 0;
    
    hour = intervalSeconds / 3600;
    minute = (intervalSeconds - hour * 3600) / 60;
    second = intervalSeconds - hour * 3600 - minute * 60;
    
    NSString *labelString = [NSString stringWithFormat:@"%02d:%02d:%02d", hour, minute, second, nil];
    _timeLabel.text = labelString;
}

#pragma -
#pragma AVAudioPlayer Delegate.

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag {

    if(flag == YES) {
        
        if(_timer != nil) {
            
            if([_timer isValid] == YES) {
                
                [_timer invalidate];
                _timer = nil;
            }
            
            [_fireDate release];
            _fireDate = nil;
        }
    
        UIView *subView = [self viewWithTag:1];
        if(subView != nil) {
            
            UILabel *subLabel = (UILabel *)[subView viewWithTag:101];
            if([subLabel.text isEqualToString:@"暂停"]) {
                
                subLabel.text = @"开始";
            }
        }
    }
}    

@end
