//
//  MyAlertView.m
//  NewsGathering
//
//  Created by XiguaZerg on 12-2-11.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "AudioRecorder.h"
#import "StorageHelper.h"

@interface AudioRecorder (PrivateMethod)

- (void)start;
- (void)stop;

@end

@implementation AudioRecorder


-(void)dismissWithClickedButtonIndex:(NSInteger)buttonIndex animated:(BOOL)animated {
    
    if(buttonIndex == 0) {
    
        UIView *subView = [self viewWithTag:1];
        if(subView != nil) {
            
            UILabel *subLabel = (UILabel *)[subView viewWithTag:101];
            if([subLabel.text isEqualToString:@"开始"]) {
                
                [self start];
                [subView setBackgroundColor:[UIColor redColor]];
                subLabel.text = @"停止";
            }else {
                
                [self stop];
                [super dismissWithClickedButtonIndex:buttonIndex animated:animated];
            }
//            if([[subView performSelector:@selector(title)] isEqualToString:@"开始"]) {
//                
//                [subView setBackgroundColor:[UIColor redColor]];
//                if([subView respondsToSelector:@selector(setTitle:)]) {
//                    [subView performSelector:@selector(setTitle:) withObject:@"结束"];
//                    
//                    for (UIView *sub in [subView subviews]) {
//                        if([[[sub class] description] isEqualToString:@"UIButtonLabel"]) {
//                            if([sub respondsToSelector:@selector(setText:)]) {
//                                NSLog(@"----");
//                                [sub performSelector:@selector(setText:) withObject:@"结束"];
//                            }
//                        }
//                    }
//                }
//
//                
//            } else {
//            
//                [super dismissWithClickedButtonIndex:buttonIndex animated:animated];
//            }
        }
        
    }else {
    
        [self stop];
        if(_fileName != nil) {
            
            [[NSFileManager defaultManager] removeItemAtPath:_fileName error:nil];
        }
        [super dismissWithClickedButtonIndex:buttonIndex animated:animated];
    }
    
}

- (void)dealloc {

    [_recorder release];
    [_fileName release];
    
    [super dealloc];
}

#pragma -
#pragma Private Methods.

- (void)start {
    
    [_fileName release];
    _fileName = nil;
    
    NSDateFormatter *dataFormatter = [[NSDateFormatter alloc] init];
    [dataFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
//    NSString *temp = [[NSString stringWithFormat:@"%@/StoreMedia", [paths objectAtIndex:0]] retain];
//    
//    // Check if the directory already exists
//    if (![[NSFileManager defaultManager] fileExistsAtPath:temp]) {
//        // Directory does not exist so create it
//        [[NSFileManager defaultManager] createDirectoryAtPath:temp withIntermediateDirectories:YES attributes:nil error:nil];
//    }
//    NSString *baseDirectory = [NSString stringWithFormat:@"%@/StoreMedia", [paths objectAtIndex:0]];
    //_fileName = [[baseDirectory stringByAppendingString:] retain];
    //_fileName = [[baseDirectory stringByAppendingString:@"/2.mp3"] retain];
    StorageHelper *storeHelper = [[StorageHelper alloc] init];
    _fileName = [[NSString stringWithFormat:@"%@/Audio_%@.caf", storeHelper.baseDirectory, [dataFormatter stringFromDate:[NSDate date]], nil] retain];
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    [audioSession setActive:YES error:nil];
    [audioSession setCategory:AVAudioSessionCategoryRecord error:nil];
    
    NSDictionary *recordSettings = [[NSDictionary alloc] initWithObjectsAndKeys:
                                    [NSNumber numberWithFloat: 44100.0],                 AVSampleRateKey,
                                    [NSNumber numberWithInt: kAudioFormatAppleLossless], AVFormatIDKey,
                                    [NSNumber numberWithInt: 1],                         AVNumberOfChannelsKey,
                                    [NSNumber numberWithInt: AVAudioQualityMax],         AVEncoderAudioQualityKey,
                                    nil];

    _recorder = [[AVAudioRecorder alloc] initWithURL: [NSURL fileURLWithPath:_fileName]
                                                               settings: recordSettings
                                                                  error: nil];
    if( [_recorder prepareToRecord] == YES) {
    
        [_recorder record];
    }
    
    [recordSettings release];
    [dataFormatter release];
}

- (void)stop {
    
    if(_recorder != nil) {
    
        [_recorder stop];
        [_recorder release];
        _recorder = nil;
        
    }
}

@end
