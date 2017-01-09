//
//  ViewController.m
//  XZAVMixObject
//
//  Created by MYKJ on 17/1/9.
//  Copyright © 2017年 zhaoyongjie. All rights reserved.
//

#import "ViewController.h"
#import "XZAVMixObject.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}

// 音频合成
- (IBAction)audionMixAction:(UIButton *)sender {
    XZAVMixObject *mixObj = [[XZAVMixObject alloc] init];
    NSURL *firstAudioURL;
    NSURL *secondAudioURL;
    NSURL *outputURL;
    [mixObj audioMixWithFirstURL:firstAudioURL secondURL:secondAudioURL outputURL:outputURL complete:^{
        NSLog(@"音频合成成功");
    }];
}

// 音视频
- (IBAction)audioMixVideoAction:(UIButton *)sender {
    XZAVMixObject *mixObj = [[XZAVMixObject alloc] init];
    NSURL *audioURL;
    NSURL *videoURL;
    NSURL *outputURL;
    [mixObj audioMixVideoWithAudioURL:audioURL videoURL:videoURL outputURL:outputURL complete:^{
        NSLog(@"音视频合成成功");
    }];
}

// 两音频一视频
- (IBAction)twoAudioMixVideoAction:(UIButton *)sender {
    XZAVMixObject *mixObj = [[XZAVMixObject alloc] init];
    NSURL *firstAudioURL;
    NSURL *secondAudioURL;
    NSURL *mixAudioURL;
    NSURL *videoURL;
    NSURL *outputURL;
    [mixObj twoAudioMixVideoWithFirstAudioURL:firstAudioURL secondAudioURL:secondAudioURL mixAudioURL:mixAudioURL videoURL:videoURL outputURL:outputURL complete:^{
        NSLog(@"合成成功");
    }];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
