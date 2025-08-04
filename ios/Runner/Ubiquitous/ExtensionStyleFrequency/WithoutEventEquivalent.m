#import "WithoutEventEquivalent.h"
    
@interface WithoutEventEquivalent ()

@end

@implementation WithoutEventEquivalent

- (void) notifyVisualizeToTernary
{
	dispatch_async(dispatch_get_main_queue(), ^{
		NSMutableArray *segmentActionSpacing = [NSMutableArray array];
		for (int i = 2; i != 0; --i) {
			[segmentActionSpacing addObject:[NSString stringWithFormat:@"taskOutsideCycle%d", i]];
		}
		NSString *associatedTransitionType = segmentActionSpacing[0];
		//NSLog(@"sets= bussiness8 gen_arr %@", bussiness8);
	});
}


@end
        