//
//  AudioModelManager.h
//  LYLAudioDemo
//
//  Created by Lynne on 2017/5/26.
//  Copyright © 2017年 Lynne. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AudioModelManager : NSObject
+(NSArray *)getDataArrWithPlist:(NSString *)plistFilePath;
@end
