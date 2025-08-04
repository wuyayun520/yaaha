#import "MarkTabviewVector.h"
#import "MeasureNextWidget.h"
#import "StandaloneQueryProtocol.h"
#import "CursorBufferInset.h"
#import "AttachTextPicker.h"

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BackwardInkwellDecorator : NSObject


- (void) navigateUpdateFromProjection;

- (void) pushLostProjection;

@end

NS_ASSUME_NONNULL_END
        