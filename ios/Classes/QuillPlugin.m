#import "QuillPlugin.h"

@interface QuillAudio : NSObject<FlutterPlugin>
@property(readonly, nonatomic) NSString *filename;
@property(readonly, nonatomic) NSString *filepath;
@property(strong, nonatomic) AVAudioPlayer *player;
@end

@implementation QuillAudio

- (instancetype)initWithCall:(FlutterMethodCall *)call {
  self = [super init];
  _filename = call.arguments[@"filename"];
  _filepath = call.arguments[@"filepath"];
  
  //NSLog(call.arguments[@"rate"]);

  NSInteger repeat = [call.arguments[@"repeat"] intValue];
  float volume = [call.arguments[@"volume"] floatValue];
  float rate = [call.arguments[@"rate"] floatValue];

  NSURL *path = [NSURL fileURLWithPath:_filepath];
  NSError *error;
  _player = [[AVAudioPlayer alloc] initWithContentsOfURL:path error:&error];
  [self numberOfLoops:repeat];
  [self volume:volume];
  [self rate:rate];

  path = nil;
  NSLog(@"Audio %@ initialized successfully", _filename);
  return self;
}

- (void)handleMethodCall:(FlutterMethodCall *)call result:(FlutterResult) result {
  if ([@"play" isEqualToString:call.method]) {
    [self play];
  }
}

- (void)dealloc {
  _filename = nil;
  _filepath = nil;
  // TODO: stop playing
  _player = nil;
}

- (void)play {
  [_player play];
}

- (void)pause {
  [_player pause];
}

- (void)stop {
  [_player stop];
}

- (void)numberOfLoops:(NSInteger)numberOfLoops {
  _player.numberOfLoops = numberOfLoops;
}

- (void)volume:(float)volume {
  _player.volume = volume;
}

- (void)setVolume:(float)volume
     fadeDuration:(NSTimeInterval)duration {
  //[_player setVolume:volume fadeDuration:duration];
}

- (void)mute {}
- (void)unmute {}
- (void)seek {}

- (void)rate:(float)rate {
  /// Range is between 0.5 to 2.0
  _player.rate = rate;
}

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
    [self addAudio:call];
    result(nil);
  } else {
    result(FlutterMethodNotImplemented);
  }
}

- (NSString *)basePath {
  return [[NSBundle mainBundle] resourcePath];
}

- (void)addAudio:(FlutterMethodCall *)call {
  NSString *filename = call.arguments[@"filename"];
  FlutterMethodChannel *audioChannel = [FlutterMethodChannel
    methodChannelWithName:[NSString stringWithFormat:@"quill/audio/%@", filename]
          binaryMessenger:[_registrar messenger]];
  QuillAudio *audio = [[QuillAudio alloc] initWithCall:call];
  [_registrar addMethodCallDelegate:audio channel:audioChannel];
}

@end


