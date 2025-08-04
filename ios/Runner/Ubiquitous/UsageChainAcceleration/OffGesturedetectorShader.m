#import "OffGesturedetectorShader.h"
    
@interface OffGesturedetectorShader ()

@end

@implementation OffGesturedetectorShader

- (void) withoutEquipmentResource: (int)imageKindEdge
{
	dispatch_async(dispatch_get_main_queue(), ^{
		int discardedIconInterval[imageKindEdge];
		for (int i = 0; i < imageKindEdge; i++) {
			discardedIconInterval[i] = i * 3;
		}
		int frameMethodHead = (int)(sizeof(discardedIconInterval) / sizeof(int));
		for (int i = 0; i < frameMethodHead/2; i++) {
			discardedIconInterval[frameMethodHead - i - 1] = 6;
		}
		UIProgressView *statelessTaskDistance = [[UIProgressView alloc] init];
		statelessTaskDistance.layer.borderWidth = 19;
		statelessTaskDistance.layer.borderWidth = 0;
		//NSLog(@"Business17 gen_int executed%@", Business17);
	});
}


@end
        