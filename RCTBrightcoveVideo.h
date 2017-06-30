#import <React/RCTView.h>
#import <AVFoundation/AVFoundation.h>
#import "AVKit/AVKit.h"
#import <BrightcovePlayerSDK/BrightcovePlayerSDK.h>
//#import "RCTBrightcoveVideoDelegate.h"

@class RCTEventDispatcher;
@class RCTBrightcoveVideo;

@protocol RCTBrightcoveVideoDelegate
- (NSString *) onVideoLoad:(RCTBrightcoveVideo*)view;
@end

@interface RCTBrightcoveVideo : UIView <RCTBrightcoveVideoDelegate, BCOVPlaybackControllerDelegate>

    @property (nonatomic, strong) BCOVPlaybackService *playbackService;
    @property (nonatomic) RCTEventDispatcher *eventDispatcher;
    @property (nonatomic) id<BCOVPlaybackController> playbackController;
    @property (nonatomic) id<BCOVPlaybackSession> playbackSession;
    @property (nonatomic) BCOVPUIPlayerView *playerView;

    @property (nonatomic, weak) id <RCTBrightcoveVideoDelegate> delegate;

    @property (nonatomic, copy) RCTBubblingEventBlock onVideoLoadStart;
    @property (nonatomic, copy) RCTBubblingEventBlock onVideoLoad;
    //@property (nonatomic, copy) RCTBubblingEventBlock onVideoBuffer;
    //@property (nonatomic, copy) RCTBubblingEventBlock onVideoError;
    //@property (nonatomic, copy) RCTBubblingEventBlock onVideoProgress;
    //@property (nonatomic, copy) RCTBubblingEventBlock onVideoSeek;
    //@property (nonatomic, copy) RCTBubblingEventBlock onVideoEnd;
    //@property (nonatomic, copy) RCTBubblingEventBlock onVideoFullscreenPlayerWillPresent;
    //@property (nonatomic, copy) RCTBubblingEventBlock onVideoFullscreenPlayerDidPresent;
    //@property (nonatomic, copy) RCTBubblingEventBlock onVideoFullscreenPlayerWillDismiss;
    //@property (nonatomic, copy) RCTBubblingEventBlock onVideoFullscreenPlayerDidDismiss;
    //@property (nonatomic, copy) RCTBubblingEventBlock onReadyForDisplay;
    //@property (nonatomic, copy) RCTBubblingEventBlock onPlaybackStalled;
    //@property (nonatomic, copy) RCTBubblingEventBlock onPlaybackResume;
    //@property (nonatomic, copy) RCTBubblingEventBlock onPlaybackRateChange;

    @property (nonatomic, copy) NSDictionary *video;
        
    - (instancetype)initWithEventDispatcher:(RCTEventDispatcher *)eventDispatcher;

@end
