//
//  AudioPlayerManager.m
//  LYLAudioDemo
//
//  Created by Lynne on 2017/5/26.
//  Copyright © 2017年 Lynne. All rights reserved.
//

#import "AudioPlayerManager.h"
#import <AVFoundation/AVFoundation.h>

@interface AudioPlayerManager()<AVAudioPlayerDelegate>

@property (nonatomic,strong) AVAudioPlayer *player;
@property (nonatomic,copy) NSURL *fileName;
@property (nonatomic,copy) void(^complete)();

@end

@implementation AudioPlayerManager

+(instancetype)shareAudioManager
{
    static AudioPlayerManager *_audioManager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _audioManager = [[AudioPlayerManager alloc]init];
    });
    return _audioManager;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(audioSessionInterruptionNotification:) name:AVAudioSessionInterruptionNotification object:nil];
    }
    return self;
}

- (void)playerWithUrl:(AudioModel *)model andDidComplete:(void(^)())completeBlock
{
    
    if (_fileName!= model.musicFilePath) {
        
        AVAudioPlayer *player = [[AVAudioPlayer alloc]initWithContentsOfURL:model.musicFilePath error:nil];
        self.player = player;
        self.player.delegate = self;
        self.complete = completeBlock;
        self.fileName = model.musicFilePath;
        self.audioModel = model;
        [_player prepareToPlay];
    }
    [self.player play];
}
- (void)play
{
    [self.player play];
}

- (void)pause
{
    [self.player pause];
}

- (void)close
{
    self.audioModel = nil;
    [self.player stop];
    self.player = nil;
}


/**
 干扰处理

 @param noti 干扰信息
 */
-(void)audioSessionInterruptionNotification:(NSNotification *)noti
{
    if ([noti.userInfo[AVAudioSessionInterruptionTypeKey] integerValue]== AVAudioSessionInterruptionTypeBegan) {
        
        [self.player pause];
        
    }else if([noti.userInfo[AVAudioSessionInterruptionTypeKey] integerValue]== AVAudioSessionInterruptionTypeBegan)
    {
        [self.player play];
    }
}

#pragma  AVAudioPlayerDelegate
- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    self.complete();
}

#pragma setter&getter

-(void)setCurrentTime:(NSTimeInterval)currentTime
{
    self.player.currentTime = currentTime;
}
-(NSTimeInterval)currentTime
{
    return self.player.currentTime;
}
-(NSTimeInterval)duration
{
    return self.player.duration;
}

-(BOOL)isplay
{
    return self.player.isPlaying;
}
-(void)setAudioModel:(AudioModel *)audioModel
{
    _audioModel = audioModel;
    [[NSNotificationCenter defaultCenter]postNotificationName:@"changeModel" object:audioModel];
}

-(void)dealloc
{
    [self.player stop];
    self.player = nil;
    NSLog(@"player 吊销啦...");
}

@end







