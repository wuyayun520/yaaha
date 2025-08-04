#import "InPresenterSensor.h"
    
@interface InPresenterSensor ()

@end

@implementation InPresenterSensor

- (void) augmentSharedInterpolation: (NSMutableArray *)navigatorWorkFlags
{
	dispatch_async(dispatch_get_main_queue(), ^{
		NSString *featureMediatorOffset = [navigatorWorkFlags objectAtIndex:0];
		UISegmentedControl *notifierFromJob = [[UISegmentedControl alloc] init];
		[notifierFromJob insertSegmentWithTitle:featureMediatorOffset atIndex:0 animated:YES];
		notifierFromJob.enabled = YES;
		notifierFromJob.selected = YES;
		//NSLog(@"sets= bussiness6 gen_arr %@", bussiness6);
	});
}


@end
        