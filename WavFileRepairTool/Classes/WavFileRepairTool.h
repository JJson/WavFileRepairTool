//
//  WavFileRepairTool.h
//  wavFileRepair
//
//  Created by linjj on 2017/8/31.
//  Copyright © 2017年 linjj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WavFileRepairTool : NSObject
+(BOOL)repairFile:(NSString *)filePath sliceHandle:(void (^)(void * dataWrited,size_t length))sliceHandle;
@end
