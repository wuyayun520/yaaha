#import "CriticalFrameConfidentiality.h"
#import "ConnectWidgetDecorator.h"

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PresentTouchAnalyzer : NSObject


- (void) listenWithoutPageviewOperation;

- (void) validateScreenIncludeCallback;

@end

NS_ASSUME_NONNULL_END
        