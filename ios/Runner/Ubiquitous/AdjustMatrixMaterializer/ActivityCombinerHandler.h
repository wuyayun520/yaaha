#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ActivityCombinerHandler : NSObject

@property (nonatomic) NSMutableSet * listenerAsWork;

+ (instancetype) activityCombinerHandlerWithDictionary: (NSDictionary *)dict;

- (instancetype) initWithDictionary: (NSDictionary *)dict;

- (NSString *) newestStoreForce;

- (NSMutableDictionary *) dialogsDuringScope;

- (int) flexWithoutTier;

- (NSMutableSet *) viewInsideComposite;

- (NSMutableArray *) hierarchicalLocalizationTint;

@end

NS_ASSUME_NONNULL_END
        