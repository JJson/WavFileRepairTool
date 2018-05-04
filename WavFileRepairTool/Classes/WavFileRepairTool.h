//
//  WavFileRepairTool.h
//  wavFileRepair
//
//  Created by linjj on 2017/8/31.
//  Copyright © 2017年 linjj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WavFileRepairTool : NSObject

/**
 wav文件修复

 @param filePath 文件路径
 @param sliceHandle 切片回调，在修复过程中，新文件写入操作的实时回调，如果需要对新文件进行一些耗时计算，比如sha1值的计算，可以在这个回调里update buffer，避免重复读取，节省时间
 @return 是否成功
 */
+(BOOL)repairFile:(NSString *)filePath sliceHandle:(void (^)(void * dataWrited,size_t length))sliceHandle;
@end
