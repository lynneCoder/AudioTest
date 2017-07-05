//
//  GlobalAudioTopView.m
//  CNEduVoice
//
//  Created by Lynne on 2017/5/24.
//  Copyright © 2017年 TRSZD. All rights reserved.
//

#import "GlobalAudioTopView.h"
#import "AudioPlayerManager.h"

@interface GlobalAudioTopView()

@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UIButton *playOrPauseBtn;

@end
@implementation GlobalAudioTopView
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self = [[NSBundle mainBundle]loadNibNamed:@"GlobalAudioTopView" owner:nil options:nil].lastObject;
        if ([[AudioPlayerManager shareAudioManager]isplay]) {
            self.playOrPauseBtn.selected = YES;
        }
        self.title.text = [AudioPlayerManager shareAudioManager].audioModel.musicName;
        
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changeAudioModel:) name:@"changeModel" object:nil];
    }
    self.frame = frame;
    return self;
}

//关闭播放悬浮条
- (IBAction)offBtnClick:(id)sender {
    
    [self removeFromSuperview];
    [[AudioPlayerManager shareAudioManager]close];
}


//暂停和播放当前的音频
- (IBAction)playOrPauseBtnClick:(UIButton *)sender {
    
    if (sender.selected) {
        
        [[AudioPlayerManager shareAudioManager]pause];
    }else
    {
        [[AudioPlayerManager shareAudioManager]play];
    }
    sender.selected = !sender.selected;
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    self.backgroundColor = [[UIColor blueColor]colorWithAlphaComponent:0.5];

    [self.playOrPauseBtn  setImage:[UIImage imageNamed:@"pause"] forState:UIControlStateSelected];
    [self.playOrPauseBtn setImage:[UIImage imageNamed:@"play"] forState:UIControlStateNormal];
}


-(void)setAudioModel:(AudioModel *)audioModel
{
    self.title.text = audioModel.musicName;
    self.playOrPauseBtn.selected = YES;
}


/**
 实时更新标题

 @param noti 通知详情
 */
-(void)changeAudioModel:(NSNotification *)noti
{
    self.audioModel = (AudioModel *)noti.object;
}

-(void)dealloc
{
    //移除通知
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"changModel" object:nil];
    
}
@end





