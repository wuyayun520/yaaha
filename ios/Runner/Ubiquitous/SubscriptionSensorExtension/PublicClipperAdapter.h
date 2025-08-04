#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PublicClipperAdapter : NSObject

@property (nonatomic) int secondSubpixelHue;

@property (nonatomic) NSMutableSet * temporaryGraphTint;

@property (nonatomic) NSMutableDictionary * prevNavigatorType;

@property (nonatomic) NSMutableArray * smallAxisSkewy;

+ (instancetype) publicClipperAdapterWithDictionary: (NSDictionary *)dict;

- (instancetype) initWithDictionary: (NSDictionary *)dict;

- (NSString *) zoneFromState;

- (NSMutableDictionary *) nibOrProxy;

- (int) parallelTransformerSpacing;

- (NSMutableSet *) gesturedetectorInterpreterScale;

- (NSMutableArray *) fusedExceptionStatus;

@end

NS_ASSUME_NONNULL_END
        