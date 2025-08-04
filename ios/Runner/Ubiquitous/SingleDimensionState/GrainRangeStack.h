#import "RestoreToolLifecycle.h"
#import "EuclideanImmutableLayout.h"

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GrainRangeStack : NSObject


- (void) notifyDescriptorFromEmitter;

- (void) mountPropagateUpAspect;

@end

NS_ASSUME_NONNULL_END
        