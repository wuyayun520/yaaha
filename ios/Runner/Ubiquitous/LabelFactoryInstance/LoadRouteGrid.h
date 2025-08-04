#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LoadRouteGrid : NSObject

@property (nonatomic) NSMutableSet * activatedTouchName;

+ (instancetype) loadRouteGridWithDictionary: (NSDictionary *)dict;

- (instancetype) initWithDictionary: (NSDictionary *)dict;

- (NSString *) handlerAtContext;

- (NSMutableDictionary *) blocDespiteCycle;

- (int) rowFunctionOffset;

- (NSMutableSet *) finalRowIndex;

- (NSMutableArray *) presenterThroughComposite;

@end

NS_ASSUME_NONNULL_END
        