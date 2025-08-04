#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DispatchStoryboardFrame : NSObject


- (void) mountedCompositionalCallback;

- (void) pushTransformInDescriptor: (NSMutableArray *)navigatorExceptCycle;

@end

NS_ASSUME_NONNULL_END
        