//
//  PCViewController.m
//  WavFileRepairTool
//
//  Created by JJSon on 05/04/2018.
//  Copyright (c) 2018 JJSon. All rights reserved.
//

#import "PCViewController.h"
#import <WavFileRepairTool/WavFileRepairTool.h>
#import <WavFileRepairTool/SHA1ObjForAQ.h>
@interface PCViewController ()

@end

@implementation PCViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    NSString * filaPath = @"broken wav file path";
    SHA1ObjForAQ * sha1Obj = [[SHA1ObjForAQ alloc] init];
    [WavFileRepairTool repairFile:filaPath sliceHandle:^(void *dataWrited, size_t length) {
        [sha1Obj updateSha1ForNewBuff:dataWrited length:length];
    }];
    NSLog(@"repaired wav fila sha1:%@", [sha1Obj getResult]);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
