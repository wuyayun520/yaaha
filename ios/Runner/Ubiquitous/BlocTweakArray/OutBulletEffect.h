#import "LogFlyweightEdge.h"
#import "PagerMediatorDelay.h"
#import "HandleActiveMaterial.h"
#import "DedicatedConsumerDetector.h"
#import "SinkActivityBehavior.h"

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface OutBulletEffect : NSObject


- (void) mixinThroughServiceLevel;

- (void) processOtherException;

@end

NS_ASSUME_NONNULL_END
        