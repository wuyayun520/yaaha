#import "PositionedInformationStack.h"
#import "BelowTransitionFilter.h"
#import "UnmountInteractiveChallenge.h"
#import "ExitLiteStream.h"

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ConnectDescriptorHelper : NSObject


- (void) hideParallelTransitionContext;

- (void) persistTouchLabel;

@end

NS_ASSUME_NONNULL_END
        