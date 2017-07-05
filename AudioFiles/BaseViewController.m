//
//  BaseViewController.m
//  LYLAudioDemo
//
//  Created by Lynne on 2017/5/28.
//  Copyright © 2017年 Lynne. All rights reserved.
//

#import "BaseViewController.h"
#import "GlobalAudioTopView.h"
#import "AudioPlayerManager.h"

@interface BaseViewController ()

@property(nonatomic,strong)GlobalAudioTopView *topView;


@end

@implementation BaseViewController


/**
 判断悬浮条的是否存在和取值
 */
-(void)viewWillAppear:(BOOL)animated
{
    /*
     悬浮条出现的标准?  是歌曲在播放的时候才显示  还是有歌曲在播放就算暂停的时候也显示?
     
     现在的标准是只有在播放的时候才显示   当然在当前界面暂停  悬浮条仍然显示
     
     不过体验不是很好  在项目里具体再改
     */
    
    if ([AudioPlayerManager shareAudioManager].isplay &&  [self.view.subviews containsObject:self.topView] && self.topView.audioModel!=[AudioPlayerManager shareAudioManager].audioModel) {
        _topView.audioModel = [AudioPlayerManager shareAudioManager].audioModel;
    }else if ([AudioPlayerManager shareAudioManager].isplay && ![self.view.subviews containsObject:self.topView])
    {
        self.topView.audioModel = [AudioPlayerManager shareAudioManager].audioModel;
        [self.view addSubview:self.topView];
        
    }else if (![AudioPlayerManager shareAudioManager].isplay && [self.view.subviews containsObject:self.topView])
    {
        [self.topView removeFromSuperview];
    }
}
- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    if ([AudioPlayerManager shareAudioManager].isplay) {
        //正在播放音频
        self.topView.audioModel = [AudioPlayerManager shareAudioManager].audioModel;
        
        [self.view addSubview:self.topView];
    }
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(GlobalAudioTopView *)topView
{
    if (!_topView) {
        _topView = [[GlobalAudioTopView alloc]initWithFrame:CGRectMake(0, 64, 375, 60)];
    }
    return _topView;
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
