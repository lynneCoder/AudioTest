//
//  AudioPlayerVC.m
//  LYLAudioDemo
//
//  Created by Lynne on 2017/5/26.
//  Copyright © 2017年 Lynne. All rights reserved.
//

#import "AudioPlayerVC.h"
#import "AudioModelManager.h"
#import "AudioDetailPlayer.h"
#import "AudioPlayerManager.h"
#import <notify.h>
#import <MediaPlayer/MediaPlayer.h>



@interface AudioPlayerVC ()

@property (nonatomic,strong)AudioDetailPlayer *audioPlayer;

@property (nonatomic,strong)NSMutableArray *audioArr;

@end

static uint64_t isScreenBright;
static uint64_t isLocked;

#define kSetLockScreenLrcNoti @"kSetLockScreenLrcNoti"


@implementation AudioPlayerVC


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
    // 监听锁屏状态
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, updateEnabled, CFSTR("com.apple.iokit.hid.displayStatus"), NULL, CFNotificationSuspensionBehaviorDeliverImmediately);
        
        
        CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, lockState, CFSTR("com.apple.springboard.lockstate"), NULL, CFNotificationSuspensionBehaviorDeliverImmediately);
    });
    AudioPlayerManager *manager = [[AudioPlayerManager alloc]init];
    AudioPlayerManager *managerShare = [AudioPlayerManager shareAudioManager];
    
    AudioPlayerManager *managerShareTwo = [AudioPlayerManager shareAudioManager];

    NSLog(@"manager的地址是%@\n,managerShare的地址是%@\n,managerShareTwo的地址是%@\n",manager,managerShare,managerShareTwo);
    
}

// 监听在锁定状态下，屏幕是黑暗状态还是明亮状态
static void updateEnabled(CFNotificationCenterRef center, void* observer, CFStringRef name, const void* object, CFDictionaryRef userInfo) {
    
    //    uint64_t state;
    
    int token;
    
    notify_register_check("com.apple.iokit.hid.displayStatus", &token);
    
    notify_get_state(token, &isScreenBright);
    
    notify_cancel(token);
    
    [AudioPlayerVC checkoutIfSetLrc];
    
    // NSLog(@"锁屏状态：%llu",isScreenBright);
}

// 监听屏幕是否被锁定
static void lockState(CFNotificationCenterRef center, void* observer, CFStringRef name, const void* object, CFDictionaryRef userInfo) {
    
    uint64_t state;
    
    int token;
    
    notify_register_check("com.apple.springboard.lockstate", &token);
    
    notify_get_state(token, &state);
    
    notify_cancel(token);
    isLocked = state;
    [AudioPlayerVC checkoutIfSetLrc];
    //    NSLog(@"lockState状态：%llu",state);
}

+(void)checkoutIfSetLrc {
    if (isLocked && isScreenBright) {
        [[NSNotificationCenter defaultCenter] postNotificationName:kSetLockScreenLrcNoti object:nil];
    }
}


- (void)setup{
    
    self.audioArr = [AudioModelManager getDataArrWithPlist:@"AudioFile.plist"].mutableCopy;
    [self.view addSubview:self.audioPlayer];
    self.audioPlayer.audioArr = self.audioArr;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)remoteControlReceivedWithEvent:(UIEvent *)event
{
    /*
     UIEventSubtypeRemoteControlPlay                 播放
     UIEventSubtypeRemoteControlPause                暂停
     UIEventSubtypeRemoteControlStop                 停止
     UIEventSubtypeRemoteControlTogglePlayPause      从暂停到播放
     UIEventSubtypeRemoteControlNextTrack            下一曲
     UIEventSubtypeRemoteControlPreviousTrack        上一曲
     UIEventSubtypeRemoteControlBeginSeekingBackward 开始快退
     UIEventSubtypeRemoteControlEndSeekingBackward   结束快退
     UIEventSubtypeRemoteControlBeginSeekingForward  开始快进
     UIEventSubtypeRemoteControlEndSeekingForward    结束快进
     */
    switch (event.subtype) {
        case UIEventSubtypeRemoteControlPlay:
            [[AudioPlayerManager shareAudioManager] play];
            break;
        case UIEventSubtypeRemoteControlPause:
            [[AudioPlayerManager shareAudioManager] pause];
            break;
        case UIEventSubtypeRemoteControlNextTrack:
            [self.audioPlayer next];
            break;
        case UIEventSubtypeRemoteControlPreviousTrack:
            [self.audioPlayer previous];
            break;
            
        default:
            break;
    }
}

#pragma getter

-(AudioDetailPlayer *)audioPlayer
{
    if (!_audioPlayer) {
        _audioPlayer = [[AudioDetailPlayer alloc]initWithFrame:CGRectMake(0, 100, 375, 100)];
    }
    return _audioPlayer;
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
