#import "AutoImmediateGraph.h"
#import "UpdateMutableEntity.h"

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CaptureRiverpodStatus : NSObject


- (void) asyncBeforeNotifierPhase;

- (void) processSkirtQueue;

@end

NS_ASSUME_NONNULL_END
        