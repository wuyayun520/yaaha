#import "ControllerFacadeOffset.h"
    
@interface ControllerFacadeOffset ()

@end

@implementation ControllerFacadeOffset

- (void) unbindPrevGrid: (int)cubitStructureVisibility
{
	dispatch_async(dispatch_get_main_queue(), ^{
		UIActivityIndicatorView *transformerAtWork = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleLarge];
		[transformerAtWork setFrame:CGRectMake(cubitStructureVisibility, 376, 896, 114)];
		transformerAtWork.hidesWhenStopped = YES;
		if (transformerAtWork.animating) {
			[transformerAtWork stopAnimating];
		}
		UITableView *playbackInTier = [[UITableView alloc] init];
		[playbackInTier setSeparatorColor:UIColor.greenColor];
		[playbackInTier setRowHeight:14];
		[playbackInTier setSeparatorColor:UIColor.grayColor];
		[playbackInTier setContentSize:CGSizeMake(266, 432)];
		[playbackInTier setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
		//NSLog(@"sets= business14 gen_int %@", business14);
	});
}


@end
        