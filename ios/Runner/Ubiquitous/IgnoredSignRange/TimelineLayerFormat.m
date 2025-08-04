#import "TimelineLayerFormat.h"
    
@interface TimelineLayerFormat ()

@end

@implementation TimelineLayerFormat

- (void) captureLiteDuration: (NSMutableArray *)rowWithoutChain
{
	dispatch_async(dispatch_get_main_queue(), ^{
		NSString *stampForActivity = [rowWithoutChain objectAtIndex:0];
		UISegmentedControl *constPreviewIndex = [[UISegmentedControl alloc] init];
		[constPreviewIndex insertSegmentWithTitle:stampForActivity atIndex:0 animated:YES];
		constPreviewIndex.enabled = YES;
		constPreviewIndex.selected = YES;
		UILabel *viewInterpreterSpeed = [[UILabel alloc] init];
		viewInterpreterSpeed.center = CGPointMake(263, 113);
		//NSLog(@"sets= bussiness6 gen_arr %@", bussiness6);
	});
}


@end
        