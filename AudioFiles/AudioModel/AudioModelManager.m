//
//  AudioModelManager.m
//  LYLAudioDemo
//
//  Created by Lynne on 2017/5/26.
//  Copyright © 2017年 Lynne. All rights reserved.
//

#import "AudioModelManager.h"
#import "AudioModel.h"
@implementation AudioModelManager
+(NSArray *)getDataArrWithPlist:(NSString *)plistFilePath
{
   
    NSMutableArray *dataArr = [NSMutableArray new];
    NSMutableArray *arr = [NSMutableArray arrayWithContentsOfFile: [[NSBundle mainBundle]pathForResource:plistFilePath ofType:nil]];
//    NSLog(@"音乐数组是%@",arr);
    for (NSDictionary *dict in arr) {
        
        AudioModel *model = [[AudioModel alloc]init];
        model.musicName = [dict objectForKey:@"musicName"];
        model.musicFilePath = [[NSBundle mainBundle] URLForResource:[dict objectForKey:@"musicFilePath"] withExtension:@".mp3"];
        [dataArr addObject:model];
    }
    return dataArr;
}
@end














