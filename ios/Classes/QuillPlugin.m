#import "QuillPlugin.h"

@interface QuillAudio : NSObject
//@property(readonly, nonatomic) SystemSoundID *soundFile;
- (instancetype)initWithFile:(NSString *)filePath;
@end

@implementation QuillAudio

- (instancetype)initWithFile:(NSString *)filePath {
  self = [super init];
  return self;
}

- (void)dealloc {
//  soundFile = nil;
}

- (void)play:(BOOL)repeat
 repeatCount:(NSInteger)repeatCount {}

- (void)pause {}
- (void)stop {}
- (void)setVolume {}
- (void)mute {}
- (void)seek {}

@end

@interface QuillPlugin()
@end

@implementation QuillPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  FlutterMethodChannel* channel = [FlutterMethodChannel
      methodChannelWithName:@"quill"
            binaryMessenger:[registrar messenger]];
  QuillPlugin* instance = [[QuillPlugin alloc] init];
  [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
  if ([@"getPlatformVersion" isEqualToString:call.method]) {
    result([@"iOS " stringByAppendingString:[[UIDevice currentDevice] systemVersion]]);
  } else {
    result(FlutterMethodNotImplemented);
  }
}

@end


