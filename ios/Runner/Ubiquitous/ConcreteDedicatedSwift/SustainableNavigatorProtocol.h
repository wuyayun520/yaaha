#import "SignHandlerObserver.h"
#import "RetainedDetectorObserver.h"

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SustainableNavigatorProtocol : NSObject


- (void) storeVisibleUsecase;

- (void) updateIterativeUsecase;

@end

NS_ASSUME_NONNULL_END
        