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

@end

@implementation AudioPlayer

@synthesize audioData = _audioData;

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
            [_player prepareToPlay];
            [_player play];
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
}

#pragma -
#pragma AVAudioPlayer Delegate.

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag {

    if(flag == YES) {
    
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
