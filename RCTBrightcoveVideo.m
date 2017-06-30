#import "RCTBrightcoveVideo.h"
#import <React/RCTBridgeModule.h>
#import <React/RCTEventDispatcher.h>
#import <React/UIView+React.h>
#import <React/RCTConvert.h>

#import <BrightcovePlayerSDK/BrightcovePlayerSDK.h>
#import <BrightcovePLayerSDK/BCOVPUILayoutView.h>

@implementation RCTBrightcoveVideo
    NSDictionary *_video;
    BOOL _play;
    BOOL _autoPlay;
    BOOL _autoAdvance;
    BOOL isRequestingContent;

- (instancetype) initWithCoder:(NSCoder *)aDecoder {
    return [super initWithCoder:aDecoder];
}
    
- (instancetype) initWithFrame:(CGRect)frame {
    return [super initWithFrame:frame];
}
    
- (instancetype) initWithEventDispatcher:(RCTEventDispatcher *)eventDispatcher {
    self = [super init];

    self.eventDispatcher = eventDispatcher;
    BCOVPlayerSDKManager *manager = [BCOVPlayerSDKManager sharedManager];

        
    BCOVBasicSessionProviderOptions *options = [[BCOVBasicSessionProviderOptions alloc] init];
    options.sourceSelectionPolicy = [BCOVBasicSourceSelectionPolicy sourceSelectionHLSWithScheme:kBCOVSourceURLSchemeHTTPS];
    id<BCOVPlaybackSessionProvider> provider = [manager createBasicSessionProviderWithOptions:options];
    id<BCOVPlaybackController> playbackController = [manager createPlaybackControllerWithSessionProvider:provider viewStrategy:nil];

    playbackController.delegate = self;

    self.playbackController = playbackController;
    [self.playbackController setAllowsExternalPlayback:YES];

    BCOVPUIBasicControlView *controlView = [BCOVPUIBasicControlView basicControlViewWithVODLayout];
    [controlView.progressSlider setBufferProgressTintColor:[UIColor blueColor]];

    self.playerView = [[BCOVPUIPlayerView alloc] initWithPlaybackController:self.playbackController options:nil controlsView:controlView];
    self.playerView.frame = self.bounds;
    self.playerView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;

    [self addSubview:self.playerView];
    self.playerView.frame = self.bounds;

    self.playerView.playbackController = self.playbackController;
        
    [self requestContentFromPlaybackService];
    

    NSDictionary *dict = @{
        @"Hello": @"world"
    };
    
    if (self.onVideoLoad == nil) {
        NSLog(@"onvideoload is null");
    }
    
    return self;
}
    
- (void)layoutSubviews {
    [super layoutSubviews];
    self.playerView.frame = self.bounds;
}
    
- (void)RCTBrightcoveVideo:(id<BCOVPlaybackController>)controller didAdvanceToPlaybackSession:(id<BCOVPlaybackSession>)session {
    NSLog(@"ARE WE HERE");
}

-(void)play {
    NSLog(@"I AM CALLING PLAY BRO");
}

- (void)requestContentFromPlaybackService
{
    NSString *videoId = @"5485940056001";
    NSString *accountId = @"5483960609001";
    NSString *policyKey = @"BCpkADawqM1WgAxgNSiE0AAis1PaBc1_pFCiXWJtS9qGsAqs9WkwVxxTejioTEFfuUFh_sg8KLBJJ6vAd_KwIcSYDBmcWenrZjwlNIwZeB6mscizpbIyL2_vczMqEucYONKs6oUmMje05ozj";

    self.playbackService = [[BCOVPlaybackService alloc] initWithAccountId:accountId policyKey:policyKey];
    [self.playbackService findVideoWithVideoID:videoId parameters:nil completion:^(BCOVVideo *video, NSDictionary *jsonResponse, NSError *error) {
        if (jsonResponse != nil) {
            NSLog(@"JSON RESPONSEEXISTS");
            for(NSString *key in [jsonResponse allKeys]) {
                NSLog(@"%@",[jsonResponse objectForKey:key]);
            }
        }
        if (video) {
            BCOVPlaylist *playlist = [[BCOVPlaylist alloc] initWithVideo:video];
            [self.playerView.playbackController setAutoPlay:YES];
            [self.playerView.playbackController setVideos:playlist.videos];
            [self.playerView.playbackController play];
            [self.playerView.playbackController pause];
            
            
            
        } else {
            RCTLogError(@"Error finding video from service: %@", error);
        }

    }];
}
@end
