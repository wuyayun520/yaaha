#import "BeforeRemainderScheduler.h"
#import "InteractiveTopicPublisher.h"
#import "ThemeDecorationCreator.h"
#import "SimilarWidgetAmortization.h"

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ForChallengeCommand : NSObject


- (void) cancelAsyncStream;

- (void) releaseTemporaryAperture;

@end

NS_ASSUME_NONNULL_END
        