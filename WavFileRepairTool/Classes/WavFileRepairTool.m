//
//  WavFileRepairTool.m
//  wavFileRepair
//
//  Created by linjj on 2017/8/31.
//  Copyright © 2017年 linjj. All rights reserved.
//

#import "WavFileRepairTool.h"

@implementation WavFileRepairTool
#define BUFFER_SIZE (1024*5)

typedef struct _PRF_RIFF_HEADER
{
    char szRiffID[4];  // 'R','I','F','F'
    int32_t dwRiffSize;
    char szRiffFormat[4]; // 'W','A','V','E'
} PRF_RIFF_HEADER;

typedef struct _PRF_WAVE_FORMAT
{
    int16_t wFormatTag;
    int16_t wChannels;
    int32_t dwSamplesPerSec;
    int32_t dwAvgBytesPerSec;
    int16_t wBlockAlign;
    int16_t wBitsPerSample;
} PRF_WAVE_FORMAT;
typedef struct _PRF_FMT_BLOCK
{
    char  szFmtID[4]; // 'f','m','t',' '
    int32_t  dwFmtSize;
    PRF_WAVE_FORMAT wavFormat;
} PRF_FMT_BLOCK;

typedef  struct _PRF_FACT_BLOCK
{
    char  szFactID[4]; // 'f','a','c','t'
    int32_t  dwFactSize;
} PRF_FACT_BLOCK;

typedef struct _PRF_DATA_BLOCK
{
    char szDataID[4]; // 'd','a','t','a'
    int32_t dwDataSize;
} PRF_DATA_BLOCK;

typedef struct _PRF_WAVE_HEADER
{
    PRF_RIFF_HEADER riff;
    PRF_FMT_BLOCK fmt;
    PRF_DATA_BLOCK data;
} PRF_WAVE_HEADER;

+ (BOOL)repairFile:(NSString *)filePath sliceHandle:(void (^)(void * dataWrited,size_t length))sliceHandle
{
    if (![[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        return NO;
    }
    FILE * fp = fopen(filePath.UTF8String, "r");
    NSString * tmpFilePath = [NSString stringWithFormat:@"%@tmp_%d",NSTemporaryDirectory(),(int)[[NSDate date] timeIntervalSince1970]];
    FILE * fpw = fopen(tmpFilePath.UTF8String, "wb+");
    NSDictionary * dAttr = [[NSFileManager defaultManager] attributesOfItemAtPath:filePath error:nil];
    PRF_WAVE_HEADER waveHeader = {0};
    fread(&waveHeader, sizeof(PRF_WAVE_HEADER), 1, fp);
    NSString * str = [[NSString alloc] initWithBytes:waveHeader.riff.szRiffID length:sizeof(waveHeader.riff.szRiffID) encoding:NSUTF8StringEncoding];
    //修正RIFF WAVE Chunk中的Size值
    if ([str isEqualToString:@"RIFF"]) {
        if (dAttr.fileSize - 8 == waveHeader.riff.dwRiffSize) {//判断原本的值是否正确
            fclose(fp);
            return YES;
        }
        else {//值不正确，则做出修正
            waveHeader.riff.dwRiffSize = (unsigned int)dAttr.fileSize - 8;
        }
    }
    else {
        fclose(fp);
        return NO;//格式不对
    }
    str = [[NSString alloc] initWithBytes:waveHeader.data.szDataID length:sizeof(waveHeader.data.szDataID) encoding:NSUTF8StringEncoding];
    if ([str isEqualToString:@"data"]){
        if (waveHeader.data.dwDataSize == dAttr.fileSize - sizeof(waveHeader)) {//判断原本的值是否正确
            fclose(fp);
            return YES;
        }
        else {
            waveHeader.data.dwDataSize = (int32_t)dAttr.fileSize - sizeof(PRF_WAVE_HEADER);
        }
    }
    else {
        fclose(fp);
        return NO;
    }
    
    fwrite(&waveHeader, sizeof(waveHeader), 1, fpw);
    if (sliceHandle) {
        sliceHandle(&waveHeader,sizeof(waveHeader));
    }
    char buffer[BUFFER_SIZE];
    
    while (1) {
        memset(buffer, 0x0, BUFFER_SIZE);
        size_t count = fread(buffer, 1,BUFFER_SIZE,  fp);
        if (count == 0) {
            break;
        }
        else {
            fwrite(buffer, 1,count,  fpw);
            if (sliceHandle) {
                sliceHandle(buffer,count);
            }
        }
    }
    
    fclose(fp);
    fclose(fpw);
    NSFileManager * fm = [NSFileManager defaultManager];
    NSError * error = nil;
    [fm removeItemAtPath:filePath error:&error];
    [fm moveItemAtPath:tmpFilePath toPath:filePath error:&error];
    [fm setAttributes:dAttr ofItemAtPath:filePath error:&error];
    return YES;
}
@end
