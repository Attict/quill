#import <Flutter/Flutter.h>
#import <AVFoundation/AVFoundation.h>

@interface QuillPlugin : NSObject<FlutterPlugin>
@property(strong, nonatomic) AVAudioPlayer *player;
@end
