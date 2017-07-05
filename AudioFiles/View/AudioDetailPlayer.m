//
//  AudioDetailPlayer.m
//  CNEduVoice
//
//  Created by Lynne on 2017/5/24.
//  Copyright © 2017年 TRSZD. All rights reserved.
//

#import "AudioDetailPlayer.h"
#import "AudioPlayerManager.h"
#import "AudioModel.h"
#import "AudioTimeTool.h"
#import <MediaPlayer/MediaPlayer.h>




#define kSetLockScreenLrcNoti @"kSetLockScreenLrcNoti"

@interface AudioDetailPlayer()

@property (weak, nonatomic) IBOutlet UILabel *currentTime;
@property (weak, nonatomic) IBOutlet UILabel *duration;
@property (weak, nonatomic) IBOutlet UIButton *playOrPauseBtn;
@property (weak, nonatomic) IBOutlet UIProgressView *audioProgress;
@property (weak, nonatomic) IBOutlet UILabel *audioName;
@property (strong,nonatomic)AudioModel *audioModel;

/**
 进度计时器 每秒调用一次
 */
@property (strong,nonatomic)NSTimer *progressTimer;

@end
@implementation AudioDetailPlayer

-(void)awakeFromNib
{
    [super awakeFromNib];
    self.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.2];
    [self.playOrPauseBtn setImage:[UIImage imageNamed:@"播放器-播放"] forState:UIControlStateNormal];
    [self.playOrPauseBtn setImage:[UIImage imageNamed:@"播放器-暂停"] forState:UIControlStateSelected];
    
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self = [[NSBundle mainBundle]loadNibNamed:@"AudioDetailPlayer" owner:nil options:nil].firstObject;
        if ([AudioPlayerManager shareAudioManager].isplay) {
            //正在播放
            self.playOrPauseBtn.selected = YES;
            self.audioModel = [AudioPlayerManager shareAudioManager].audioModel;
        }
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateLockScreen) name:kSetLockScreenLrcNoti object:nil];

    }
    self.frame = frame;
    return self;
}

/**
 暂停或播放

 */
- (IBAction)playOrPause:(UIButton *)sender {
    
    if (sender.selected) {
        //暂停
        [[AudioPlayerManager shareAudioManager] pause];
        [self stopTimer];
    }else
    {
        [self play];
        [self startUpdateTimer];
        //播放
    }
    sender.selected = !sender.selected;
}
/**
 下一首
 */
- (IBAction)next:(id)sender {
    
    self.currentIndex = self.currentIndex+1==self.audioArr.count?0:self.currentIndex+1;
    [self play];
    [self startUpdateTimer];
}

/**
 上一首
 */
- (IBAction)previousBtnClick:(id)sender {
    
    self.currentIndex = self.currentIndex==0?self.audioArr.count-1:self.currentIndex-1;
    [self play];
    [self startUpdateTimer];

 }

-(void)play
{
    
    AudioPlayerManager *manager = [AudioPlayerManager shareAudioManager];
    AudioModel *model = self.audioArr[self.currentIndex];
    self.audioName.text = [NSString stringWithFormat:@"%ld %@",self.currentIndex+1,model.musicName];
    [manager playerWithUrl:model andDidComplete:^{
        [self next:nil];
        [self startUpdateTimer];
    }];
    self.duration.text = [AudioTimeTool timeStringWithTimeInterval:manager.duration];
    
}

/**
 创建计时器
 */
-(void)startUpdateTimer
{
    self.progressTimer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(updateProgress) userInfo:nil repeats:YES];
}


/**
 销毁计时器
 */
-(void)stopTimer
{
    [self.progressTimer invalidate];
    self.progressTimer = nil;
}

/**
 更新播放进度
 */
-(void)updateProgress
{
    AudioPlayerManager *manager = [AudioPlayerManager shareAudioManager];
    self.audioProgress.progress = manager.currentTime/manager.duration;
    self.currentTime.text = [AudioTimeTool timeStringWithTimeInterval:manager.currentTime];
    
}

-(void)setAudioModel:(AudioModel *)audioModel
{
    self.duration.text = [AudioTimeTool timeStringWithTimeInterval:[AudioPlayerManager shareAudioManager].duration];
    self.audioName.text = [NSString stringWithFormat:@"%ld %@",self.currentIndex+1,audioModel.musicName];;
    [self startUpdateTimer];
}



/**
 更新锁屏的音乐信息
 */
- (void)updateLockScreen
{
    // 获取音乐播放信息中心
    MPNowPlayingInfoCenter *nowPlayingInfoCenter = [MPNowPlayingInfoCenter defaultCenter];
    // 创建可变字典存放信息
    NSMutableDictionary *info = [NSMutableDictionary dictionary];
    // 获取当前正在播放的音乐对象
    AudioModel *music = self.audioArr[self.currentIndex];
    
    AudioPlayerManager *playManager = [AudioPlayerManager shareAudioManager];
    // 专辑名称
    info[MPMediaItemPropertyAlbumTitle] = music.musicName;
    // 歌手
    info[MPMediaItemPropertyArtist] = @"中国教育之声";
    // 专辑图片
    info[MPMediaItemPropertyArtwork] = [[MPMediaItemArtwork alloc] initWithImage:[UIImage imageNamed:@"Defaultimage"]];
    // 当前播放进度
    info[MPNowPlayingInfoPropertyElapsedPlaybackTime] = @(playManager.currentTime);
    // 音乐总时间
    info[MPMediaItemPropertyPlaybackDuration] = @(playManager.duration);
    // 音乐名称
    info[MPMediaItemPropertyTitle] = music.musicName;
    
    nowPlayingInfoCenter.nowPlayingInfo = info;

}

#pragma 远程接口

-(void)previous
{
    [self previousBtnClick:nil];
    //更新锁屏信息
    [self updateLockScreen];
}
-(void)next
{
    [self next:nil];
    //更新锁屏信息
    [self updateLockScreen];

}

#pragma dealloc

-(void)dealloc
{
    NSLog(@"player 吊销啦...");
}



@end









