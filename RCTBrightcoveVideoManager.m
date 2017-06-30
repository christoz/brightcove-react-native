#import "RCTBrightcoveVideoManager.h"
#import "RCTBrightcoveVideo.h"
#import <React/RCTBridge.h>

@implementation RCTBrightcoveVideoManager

    RCT_EXPORT_MODULE();
    
    RCTBrightcoveVideo *view;
    
    - (UIView *)view {
        view = [[RCTBrightcoveVideo alloc] initWithEventDispatcher:self.bridge.eventDispatcher];
        view.delegate = self;
        
        return view;
    }

    - (void) onVideoLoad:(RCTBrightcoveVideo*)view{
        NSLog(@"WHAT YOU WANT");
    }

    RCT_EXPORT_VIEW_PROPERTY(video, NSDictionary);
    RCT_EXPORT_VIEW_PROPERTY(onVideoLoad, RCTBubblingEventBlock);
    RCT_EXPORT_VIEW_PROPERTY(onVideoLoadStart, RCTBubblingEventBlock);

@end
