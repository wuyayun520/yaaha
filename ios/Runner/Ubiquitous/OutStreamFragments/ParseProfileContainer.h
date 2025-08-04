#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ParseProfileContainer : NSObject

@property (nonatomic) NSMutableArray * responsiveTextHead;

+ (instancetype) parseprofileContainerWithDictionary: (NSDictionary *)dict;

- (instancetype) initWithDictionary: (NSDictionary *)dict;

- (NSString *) iconFromStyle;

- (NSMutableDictionary *) singletonWithoutStyle;

- (int) constraintContextCenter;

- (NSMutableSet *) currentProgressbarKind;

- (NSMutableArray *) semanticsAsType;

@end

NS_ASSUME_NONNULL_END
        