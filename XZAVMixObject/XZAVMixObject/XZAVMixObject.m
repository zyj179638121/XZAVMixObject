//
//  XZAVMixObject.m
//  XZAVMixObject
//
//  Created by MYKJ on 17/1/9.
//  Copyright © 2017年 zhaoyongjie. All rights reserved.
//

#import "XZAVMixObject.h"
#import <AVFoundation/AVFoundation.h>

@interface XZAVMixObject ()

@property (nonatomic, strong) NSMutableArray *audioMixParams;

@end

@implementation XZAVMixObject

/**
 音频合成
 
 @param firstURL  第一个音频的url
 @param secondURL 第二个音频的url
 @param outputURL 合成音频的url
 @param complete  完成的回调
 */
- (void)audioMixWithFirstURL:(NSURL *)firstURL
                   secondURL:(NSURL *)secondURL
                   outputURL:(NSURL *)outputURL
                    complete:(void (^) (void))complete
{
    AVMutableComposition *composition = [AVMutableComposition composition];
    self.audioMixParams = [NSMutableArray array];
    
    //Add Audio Tracks to Composition
    
    AVURLAsset *songAsset = [AVURLAsset URLAssetWithURL:firstURL options:nil];
    CMTime startTime = CMTimeMakeWithSeconds(0, 1);
    CMTime trackDuration = songAsset.duration;
    
    [self setUpAndAddAudioAtPath:firstURL toComposition:composition start:startTime dura:trackDuration offset:CMTimeMake(0, 22050)];
    
    [self setUpAndAddAudioAtPath:secondURL toComposition:composition start:startTime dura:trackDuration offset:CMTimeMake(0, 22050)];
    
    AVMutableAudioMix *audioMix = [AVMutableAudioMix audioMix];
    audioMix.inputParameters = [NSArray arrayWithArray:self.audioMixParams];
    
    AVAssetExportSession *exporter = [[AVAssetExportSession alloc]
                                      initWithAsset: composition
                                      presetName: AVAssetExportPresetAppleM4A];
    exporter.audioMix = audioMix;
    exporter.outputFileType = @"com.apple.m4a-audio";
    
    // set up export
    if ([[NSFileManager defaultManager] fileExistsAtPath:outputURL.absoluteString]) {
        [[NSFileManager defaultManager] removeItemAtPath:outputURL.absoluteString error:nil];
    }
    exporter.outputURL = outputURL;
    
    // do the export
    [exporter exportAsynchronouslyWithCompletionHandler:^{
        complete();
    }];
}

/**
 音视频合成
 
 @param audioURL  音频的url
 @param videoURL  视频的url
 @param outputURL 合成音视频的url
 @param complete  完成的回调
 */
- (void)audioMixVideoWithAudioURL:(NSURL *)audioURL
                         videoURL:(NSURL *)videoURL
                        outputURL:(NSURL *)outputURL
                         complete:(void (^) (void))complete
{
    
    // 时间起点
    NSLog(@"audio = %@,video = %@",audioURL,videoURL);
    CMTime nextClistartTime = kCMTimeZero;
    // 创建可变的音视频组合
    AVMutableComposition *comosition = [AVMutableComposition composition];
    
    // 声音采集
    AVURLAsset *audioAsset = [[AVURLAsset alloc] initWithURL:audioURL options:nil];
    // 因为音频短这里就直接用音频长度了
    CMTimeRange audioTimeRange = CMTimeRangeMake(kCMTimeZero, audioAsset.duration);
    // 音频通道
    AVMutableCompositionTrack *audioTrack = [comosition addMutableTrackWithMediaType:AVMediaTypeAudio preferredTrackID:kCMPersistentTrackID_Invalid];
    // 音频采集通道
    AVAssetTrack *audioAssetTrack = [[audioAsset tracksWithMediaType:AVMediaTypeAudio] firstObject];
    // 加入合成轨道之中
    [audioTrack insertTimeRange:audioTimeRange ofTrack:audioAssetTrack atTime:nextClistartTime error:nil];
    
    // 视频采集
    AVURLAsset *videoAsset = [[AVURLAsset alloc] initWithURL:videoURL options:nil];
    // 视频时间范围     // 因为音频短这里就直接用音频长度了,如果自动化需要自己写判断
    CMTimeRange videoTimeRange = audioTimeRange;
    // 视频通道 枚举 kCMPersistentTrackID_Invalid = 0
    AVMutableCompositionTrack *videoTrack = [comosition addMutableTrackWithMediaType:AVMediaTypeVideo preferredTrackID:kCMPersistentTrackID_Invalid];
    // 视频采集通道
    AVAssetTrack *videoAssetTrack = [[videoAsset tracksWithMediaType:AVMediaTypeVideo] firstObject];
    //  把采集轨道数据加入到可变轨道之中
    [videoTrack insertTimeRange:videoTimeRange ofTrack:videoAssetTrack atTime:nextClistartTime error:nil];
    
    // 创建一个输出
    AVAssetExportSession *assetExport = [[AVAssetExportSession alloc] initWithAsset:comosition presetName:AVAssetExportPresetPassthrough];
    // 输出类型
    assetExport.outputFileType = AVFileTypeQuickTimeMovie;
    // 输出地址
    assetExport.outputURL = outputURL;
    // 优化
    assetExport.shouldOptimizeForNetworkUse = YES;
    // 合成完毕
    [assetExport exportAsynchronouslyWithCompletionHandler:^{
        complete();
    }];
}


/**
 两音频一视频合成
 
 @param firstAudioURL 第一个音频url
 @param secondAudioURL 第二个音频url
 @param mixAudioURL 合成后音频保存的url
 @param videoURL 视频的url
 @param outputURL 合成音视频的url
 @param complete 完成的回调
 */
- (void)twoAudioMixVideoWithFirstAudioURL:(NSURL *)firstAudioURL
                           secondAudioURL:(NSURL *)secondAudioURL
                              mixAudioURL:(NSURL *)mixAudioURL
                                 videoURL:(NSURL *)videoURL
                                outputURL:(NSURL *)outputURL
                                 complete:(void (^)(void))complete
{
    [self audioMixWithFirstURL:firstAudioURL secondURL:secondAudioURL outputURL:mixAudioURL complete:^{
        [self audioMixVideoWithAudioURL:mixAudioURL videoURL:videoURL outputURL:outputURL complete:^{
            complete();
        }];
    }];
}

- (void)setUpAndAddAudioAtPath:(NSURL*)assetURL toComposition:(AVMutableComposition *)composition start:(CMTime)start dura:(CMTime)dura offset:(CMTime)offset{
    AVURLAsset *songAsset = [AVURLAsset URLAssetWithURL:assetURL options:nil];
    
    AVMutableCompositionTrack *track = [composition addMutableTrackWithMediaType:AVMediaTypeAudio preferredTrackID:kCMPersistentTrackID_Invalid];
    AVAssetTrack *sourceAudioTrack = [[songAsset tracksWithMediaType:AVMediaTypeAudio] objectAtIndex:0];
    
    NSError *error = nil;
    BOOL ok = NO;
    
    CMTime startTime = start;
    CMTime trackDuration = dura;
    CMTimeRange tRange = CMTimeRangeMake(startTime, trackDuration);
    
    //Set Volume
    AVMutableAudioMixInputParameters *trackMix = [AVMutableAudioMixInputParameters audioMixInputParametersWithTrack:track];
    [trackMix setVolume:0.8f atTime:startTime];
    [self.audioMixParams addObject:trackMix];
    
    //Insert audio into track  //offset CMTimeMake(0, 44100)
    ok = [track insertTimeRange:tRange ofTrack:sourceAudioTrack atTime:offset error:&error];
}


@end
