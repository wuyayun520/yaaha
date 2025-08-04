#import "CellVariablePosition.h"
#import "RequiredRobustExtension.h"

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PlaybackRequestDelegate : NSObject


- (void) notifyCellPerVideo;

- (void) invokeForIsolateLevel;

@end

NS_ASSUME_NONNULL_END
        