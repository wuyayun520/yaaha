#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ParseIconComponent : NSObject

@property (nonatomic) NSMutableArray * semanticBoxshadowEdge;

+ (instancetype) parseIconComponentWithDictionary: (NSDictionary *)dict;

- (instancetype) initWithDictionary: (NSDictionary *)dict;

- (NSString *) blocInKind;

- (NSMutableDictionary *) reusableConfigurationFormat;

- (int) durationPerMode;

- (NSMutableSet *) missedSpineInteraction;

- (NSMutableArray *) baselinePlatformSize;

@end

NS_ASSUME_NONNULL_END
        