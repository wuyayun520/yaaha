#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ShowInstructionCache : NSObject

@property (nonatomic) int largeProviderOpacity;

@property (nonatomic) NSMutableSet * storagePhaseVisibility;

+ (instancetype) showInstructionCacheWithDictionary: (NSDictionary *)dict;

- (instancetype) initWithDictionary: (NSDictionary *)dict;

- (NSString *) timerTierType;

- (NSMutableDictionary *) offsetPlatformSize;

- (int) permissiveTaskFlags;

- (NSMutableSet *) allocatorOrMode;

- (NSMutableArray *) textureScopeMargin;

@end

NS_ASSUME_NONNULL_END
        