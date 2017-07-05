//
//  AudioTimeTool.m
//  LYLAudioDemo
//
//  Created by Lynne on 2017/5/27.
//  Copyright © 2017年 Lynne. All rights reserved.
//

#import "AudioTimeTool.h"

@implementation AudioTimeTool
+(NSString *)timeStringWithTimeInterval:(NSTimeInterval)timeInterval
{
    int minute = timeInterval/60;
    int second = (int)timeInterval % 60;
    return [NSString stringWithFormat:@"%02d:%02d",minute,second];

}

@end
