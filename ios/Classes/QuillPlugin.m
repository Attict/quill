#import "QuillPlugin.h"

@interface QuillAudio : NSObject<FlutterPlugin>
@property(readonly, nonatomic) NSString *filename;
@property(readonly, nonatomic) NSString *filepath;
@property(strong, nonatomic) AVAudioPlayer *player;
@end

@implementation QuillAudio

- (instancetype)initWithFilename:(NSString *)filename
                        filepath:(NSString *)filepath{
  self = [super init];
  _filename = filename;
  _filepath = filepath;

  NSURL *path = [NSURL fileURLWithPath:filepath];
  NSError *error;
  _player = [[AVAudioPlayer alloc] initWithContentsOfURL:path error:&error];
//  _player.delegate = self;
  path = nil;
  NSLog(@"Audio %@ initialized successfully", _filename);
  return self;
}

- (void)handleMethodCall:(FlutterMethodCall *)call result:(FlutterResult) result {
  if ([@"play" isEqualToString:call.method]) {
    NSInteger repeat = call.arguments[@"repeat"];
    [self play:repeat];
  }
}

- (void)dealloc {
  _filename = nil;
  _filepath = nil;
  // TODO: stop playing
  _player = nil;
}

- (void)play:(NSInteger)repeat {
  NSLog(@"Audio %@ played successfully with repeat %@", _filename, repeat);
//  _player.numberOfLoops = -1;
//  [_player play];
}

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
  QuillPlugin* instance = [[QuillPlugin alloc] initWithRegistrar:registrar];
  [registrar addMethodCallDelegate:instance channel:channel];
}

- (instancetype)initWithRegistrar:(NSObject<FlutterPluginRegistrar> *)registrar {
  self = [super init];
  _registrar = registrar;
  return self;
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
  if ([@"basePath" isEqualToString:call.method]) {
    NSString *path = [self basePath];
    result(@{@"path" : path});
  } else if ([@"addAudio" isEqualToString:call.method]) {
    NSString *filename = call.arguments[@"filename"];
    NSString *filepath = call.arguments[@"filepath"];
    [self addAudio:filename filepath:filepath];
    result(nil);
  } else {
    result(FlutterMethodNotImplemented);
  }
}

- (NSString *)basePath {
  return [[NSBundle mainBundle] resourcePath];
}

- (void)addAudio:(NSString *)filename
        filepath:(NSString *)filepath {
  NSLog(@"iOS - AddAudio:%@", filename);

  FlutterMethodChannel *audioChannel = [FlutterMethodChannel
    methodChannelWithName:[NSString stringWithFormat:@"quill/audio/%@", filename]
          binaryMessenger:[_registrar messenger]];
  QuillAudio *audio = [[QuillAudio alloc] initWithFilename:filename filepath:filepath];
  [_registrar addMethodCallDelegate:audio channel:audioChannel];
}

@end


