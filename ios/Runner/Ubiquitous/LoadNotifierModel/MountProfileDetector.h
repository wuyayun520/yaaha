#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MountProfileDetector : NSObject

@property (nonatomic) NSString * explicitResultHead;

@property (nonatomic) NSString * grayscaleShapeContrast;

+ (instancetype) mountProfileDetectorWithDictionary: (NSDictionary *)dict;

- (instancetype) initWithDictionary: (NSDictionary *)dict;

- (NSString *) dialogsEnvironmentPadding;

- (NSMutableDictionary *) appbarTypeMargin;

- (int) disabledBrushType;

- (NSMutableSet *) lastControllerDistance;

- (NSMutableArray *) specifierDecoratorColor;

@end

NS_ASSUME_NONNULL_END
        