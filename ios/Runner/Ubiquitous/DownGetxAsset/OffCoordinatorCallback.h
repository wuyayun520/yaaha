#import "RestoreLogBase.h"
#import "ResolvePromiseManager.h"
#import "ToRepositorySorter.h"
#import "SensorInteractorOwner.h"

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface OffCoordinatorCallback : NSObject


- (void) storeThroughDelegateContext;

- (void) setDisabledBufferCommand;

@end

NS_ASSUME_NONNULL_END
        