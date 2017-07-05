//
//  AudioDetailPlayer.h
//  CNEduVoice
//
//  Created by Lynne on 2017/5/24.
//  Copyright © 2017年 TRSZD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AudioDetailPlayer : UIView

@property (nonatomic,strong)NSMutableArray *audioArr;
@property (assign,nonatomic)NSInteger currentIndex;

/*
    以下接口用于远程控制歌曲的播放
 */
/**
 上一首
 */
-(void)previous;

/**
 下一首
 */
-(void)next;


@end
