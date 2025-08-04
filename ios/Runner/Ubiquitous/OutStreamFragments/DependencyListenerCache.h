#import "FixedGestureManager.h"
#import "SmartPagerHelper.h"

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DependencyListenerCache : NSObject


- (void) connectResponsiveRow;

- (void) notifyWithoutBuilderStructure;

@end

NS_ASSUME_NONNULL_END
        