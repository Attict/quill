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

- (void)play:(NSInteger)repeat {}
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
  if ([@"addAudio" isEqualToString:call.method]) {
    NSString *filename = call.arguments[@"filename"];
    [self addAudio:filename];
    result(nil);
  } else if ([@"baseAppPath" isEqualToString:call.method]) {
    NSString *path = [self baseAppPath];
    result(@{@"path" : path});
  } else {
    result(FlutterMethodNotImplemented);
  }
}

- (NSString *)baseAppPath {
  return [[NSBundle mainBundle] resourcePath];
}

- (void)addAudio:(NSString *)filename {
  NSLog(@"iOS - AddAudio:%@", filename);
  NSURL *path = [NSURL fileURLWithPath:filename];
  NSError *error;
  _player = [[AVAudioPlayer alloc] initWithContentsOfURL:path error:&error];
  _player.delegate = self;
  _player.numberOfLoops = -1;
  [_player play];
}

@end


