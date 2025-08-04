#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ResilienceContextEdge : NSObject


- (void) markUnderAsyncVar;

- (void) getCriticalStepProcess: (NSMutableDictionary *)isolateIncludeEnvironment;

@end

NS_ASSUME_NONNULL_END
        