//
//  XZAVMixObject.h
//  XZAVMixObject
//
//  Created by MYKJ on 17/1/9.
//  Copyright © 2017年 zhaoyongjie. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XZAVMixObject : NSObject

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
                    complete:(void (^) (void))complete;

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
                         complete:(void (^) (void))complete;



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
                                 complete:(void (^)(void))complete;


@end
