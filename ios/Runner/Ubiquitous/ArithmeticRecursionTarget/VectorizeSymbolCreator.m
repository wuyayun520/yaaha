#import "VectorizeSymbolCreator.h"
    
@interface VectorizeSymbolCreator ()

@end

@implementation VectorizeSymbolCreator

- (void) hideExplicitViewPrototype: (NSMutableDictionary *)popupProxyBottom
{
	dispatch_async(dispatch_get_main_queue(), ^{
		NSInteger completerAroundState = popupProxyBottom.count;
		int viewPlatformDuration[5];
		for (int i = 0; i < 5; i++) {
			viewPlatformDuration[i] = 78 * i;
		}
		if (completerAroundState > viewPlatformDuration[4]) {
			viewPlatformDuration[0] = completerAroundState;
		} else {
			int sizeActionShape=0;
			for (int i = 0; i < 4; i++) {
				if (viewPlatformDuration[i] < completerAroundState && viewPlatformDuration[i+1] >= completerAroundState) {
				    sizeActionShape = i + 1;
				    break;
				}
			}
			for (int i = 0; i < sizeActionShape; i++) {
				viewPlatformDuration[sizeActionShape - i] = viewPlatformDuration[sizeActionShape - i - 1];
			}
			viewPlatformDuration[0] = completerAroundState;
		}
		//NSLog(@"Business17 gen_dic executed%@", Business17);
	});
}


@end
        