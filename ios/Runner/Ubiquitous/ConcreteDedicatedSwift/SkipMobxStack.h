#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SkipMobxStack : NSObject


- (void) mitigateVariantStore: (NSMutableSet *)grainWithoutCommand;

@end

NS_ASSUME_NONNULL_END
        