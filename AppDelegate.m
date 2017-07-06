//
//  AppDelegate.m
//  LYLAudioDemo
//
//  Created by Lynne on 2017/5/26.
//  Copyright © 2017年 Lynne. All rights reserved.
//

#import "AppDelegate.h"
#import <AVFoundation/AVFoundation.h>
#import "AudioPlayerManager.h"
#import "AudioDetailPlayer.h"
#import "AudioModelManager.h"

@interface AppDelegate ()

@end

@implementation AppDelegate
//Test 在父项目里面改子项目 push到子项目里
//Test 在子项目里面改动  父项目pull最新的子项目代码
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    /*
     注册后台播放
     */
    AVAudioSession *session = [AVAudioSession sharedInstance];
    [session setCategory:AVAudioSessionCategoryPlayback error:NULL];
    
    // 开启远程事件  -->自动切歌
    [application beginReceivingRemoteControlEvents];

    
    
    return YES;
}

//- (void)remoteControlReceivedWithEvent:(UIEvent *)event
//{
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
//    AudioDetailPlayer *player = [UIWindow
//    switch (event.subtype) {
//        case UIEventSubtypeRemoteControlPlay:
//            [[AudioPlayerManager shareAudioManager] play];
//            break;
//        case UIEventSubtypeRemoteControlPause:
//            [[AudioPlayerManager shareAudioManager] pause];
//            break;
//        case UIEventSubtypeRemoteControlNextTrack:
//            [[AudioPlayerManager shareAudioManager] playerWithUrl:audioArr[nextIndex] andDidComplete:<#^(void)completeBlock#>];
//            break;
//        case UIEventSubtypeRemoteControlPreviousTrack:
//            //            [audioPlayer previous];
//            break;
//            
//        default:
//            break;
//    }
//}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
