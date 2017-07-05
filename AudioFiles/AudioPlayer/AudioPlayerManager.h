//
//  AudioPlayerManager.h
//  LYLAudioDemo
//
//  Created by Lynne on 2017/5/26.
//  Copyright © 2017年 Lynne. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AudioModel.h"

@interface AudioPlayerManager : NSObject
/**
 实时获取当前的播放时间和总时长
 */
@property(nonatomic,assign)NSTimeInterval currentTime;
@property(nonatomic,assign)NSTimeInterval duration;
@property(nonatomic,assign)BOOL isplay;
@property(nonatomic,strong)AudioModel * audioModel;
@property(nonatomic,assign)NSInteger currentIndex;

/**
 单例创建

 @return 返回单例实例对象
 */
+(instancetype)shareAudioManager;

/**
 播放文件

 @param model 文件的地址
 @param completeBlock 文件播放完成后的回调
 */
- (void)playerWithUrl:(AudioModel *)model andDidComplete:(void(^)())completeBlock;

- (void)play;

/**
 暂停播放
 */
- (void)pause;

/**
 关闭播放
 */
- (void)close;
@end














