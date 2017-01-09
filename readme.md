XZAVMixObject
====
### 音视频合成的一个小框架

## 集成说明
你可以在`Podfile`中加入下面一行代码来使用`XZAVMixObject`,别忘了`pod install`哦。

	pod 'XZAVMixObject'

你也可以手动添加源码来使用,将开源代码中的`XZAVMixObject.h`和`XZAVMixObject.m`添加到你的工程中。

## 使用说明
使用的时候需要注意:传入的url为需要合成的音视频文件的url,outputURL为合成后文件保存的位置,这个url下的路径/文件夹要存在才能保存成功。

导入头文件

```Objective-C
#import "XZAVMixObject.h"
```
音频合成

```Objective-C
    XZAVMixObject *mixObj = [[XZAVMixObject alloc] init];
    NSURL *firstAudioURL;
    NSURL *secondAudioURL;
    NSURL *outputURL;
    [mixObj audioMixWithFirstURL:firstAudioURL secondURL:secondAudioURL outputURL:outputURL complete:^{
        NSLog(@"音频合成成功");
    }];
```
音视频合成

```Objective-C
    XZAVMixObject *mixObj = [[XZAVMixObject alloc] init];
    NSURL *audioURL;
    NSURL *videoURL;
    NSURL *outputURL;
    [mixObj audioMixVideoWithAudioURL:audioURL videoURL:videoURL outputURL:outputURL complete:^{
        NSLog(@"音视频合成成功");
    }];
```
两个音频一个视频的合成。也就是先把两个音频合成,再将合成后的音频与视频进行合成。

```Objective-C
    XZAVMixObject *mixObj = [[XZAVMixObject alloc] init];
    NSURL *firstAudioURL;
    NSURL *secondAudioURL;
    NSURL *mixAudioURL;
    NSURL *videoURL;
    NSURL *outputURL;
    [mixObj twoAudioMixVideoWithFirstAudioURL:firstAudioURL secondAudioURL:secondAudioURL mixAudioURL:mixAudioURL videoURL:videoURL outputURL:outputURL complete:^{
        NSLog(@"合成成功");
    }];
```
