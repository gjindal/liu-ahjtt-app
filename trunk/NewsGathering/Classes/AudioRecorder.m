//
//  MyAlertView.m
//  NewsGathering
//
//  Created by XiguaZerg on 12-2-11.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "AudioRecorder.h"
#import "StorageHelper.h"
#import "NewsGatheringAppDelegate.h"

@interface AudioRecorder (PrivateMethod)

- (void)setLabelText;

@end

@implementation AudioRecorder

@synthesize fileName = _fileName;
@synthesize Recoding = _recording;

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
        
        _storeHelper = [[StorageHelper alloc] init];
    }
    
    return self;
}

- (void)dismissWithClickedButtonIndex:(NSInteger)buttonIndex animated:(BOOL)animated {
    
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
        }
        
    }else {
    
        [self stop];
        if(_fileName != nil) {
            
            [_storeHelper deleteFileWithName:_fileName];
//            [[NSFileManager defaultManager] removeItemAtPath:_fileName error:nil];
        }
        [super dismissWithClickedButtonIndex:buttonIndex animated:animated];
    }
    
}

- (void)dealloc {

    [_recorder release];
    [_fileName release];
    [_storeHelper release];
    
    _recorder = nil;
    _fileName = nil;
    _storeHelper = nil;
    
    [super dealloc];
}

#pragma -
#pragma Private Methods.

- (void)start {

    [_fileName release];
    _fileName = nil;
    
    NewsGatheringAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    
    NSDateFormatter *dataFormatter = [[NSDateFormatter alloc] init];
    [dataFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    _fileName = [[NSString stringWithFormat:@"%@_Audio_%@.aif",appDelegate.loginId,[dataFormatter stringFromDate:[NSDate date]], nil] retain];
    NSString *filePath = [_storeHelper.baseDirectory stringByAppendingPathComponent:_fileName];
//    _fileName = [[NSString stringWithFormat:@"%@/Audio_%@.caf", storeHelper.baseDirectory, [dataFormatter stringFromDate:[NSDate date]], nil] retain];
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    [audioSession setActive:YES error:nil];
    [audioSession setCategory:AVAudioSessionCategoryRecord error:nil];
    
    NSDictionary *recordSettings = [[NSDictionary alloc] initWithObjectsAndKeys:
                                    [NSNumber numberWithFloat: 22050.0],                 AVSampleRateKey,
                                    [NSNumber numberWithInt: kAudioFormatAppleIMA4], AVFormatIDKey,
                                    [NSNumber numberWithInt: 1],                         AVNumberOfChannelsKey,
                                    [NSNumber numberWithInt: AVAudioQualityMin],         AVEncoderAudioQualityKey,
                                    nil];

    _recorder = [[AVAudioRecorder alloc] initWithURL: [NSURL fileURLWithPath:filePath]
                                                               settings: recordSettings
                                                                  error: nil];
    if( [_recorder prepareToRecord] == YES) {

        ((NewsGatheringAppDelegate *)([UIApplication sharedApplication].delegate)).recorder = self;
        _recording = YES;
        [_recorder record];
        _fireDate = [[NSDate date] retain];
        _timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(setLabelText) userInfo:nil repeats:YES];
    }
    
    [recordSettings release];
    [dataFormatter release];
}

- (void)pause {

    if(_recorder != nil) {
    
        _timeInterval += [[NSDate date] timeIntervalSinceDate:_fireDate];
        _recording = NO;
        
        if([_timer isValid] == YES) {
            
            [_timer invalidate];
            _timer = nil;
        }
    }
}

- (void)resume {

    if(_recorder != nil) {
    
        _fireDate = [[NSDate date] retain];
        _timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(setLabelText) userInfo:nil repeats:YES];
        [_recorder record];
    }
}

- (void)stop {
    
    if(_recorder != nil) {
    
        ((NewsGatheringAppDelegate *)([UIApplication sharedApplication].delegate)).recorder = nil;
        [_recorder stop];
        [_recorder release];
        _recorder = nil;
    }
    
    if(_timer != nil) {
        
        if([_timer isValid] == YES) {
        
            [_timer invalidate];
            _timer = nil;
        }
        
        [_fireDate release];
        _fireDate = nil;
    }
    
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    [audioSession setCategory:AVAudioSessionCategoryPlayback error:nil];
}

- (void)setLabelText {
    
    NSTimeInterval intervalSeconds = [[NSDate date] timeIntervalSinceDate:_fireDate] + _timeInterval;
    int hour = 0;
    int minute = 0;
    int second = 0;
    
    hour = intervalSeconds / 3600;
    minute = (intervalSeconds - hour * 3600) / 60;
    second = intervalSeconds - hour * 3600 - minute * 60;
    
    NSString *labelString = [NSString stringWithFormat:@"%02d:%02d:%02d", hour, minute, second, nil];
    _timeLabel.text = labelString;
}

@end
