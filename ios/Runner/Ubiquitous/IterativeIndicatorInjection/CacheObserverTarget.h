#import "DirectlyZoneTransformer.h"
#import "LastBackwardClipper.h"

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CacheObserverTarget : NSObject


- (void) saveOldGroup;

- (void) propagateCrucialAction;

@end

NS_ASSUME_NONNULL_END
        