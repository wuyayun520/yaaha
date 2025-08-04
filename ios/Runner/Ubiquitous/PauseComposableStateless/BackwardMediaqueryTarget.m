#import "BackwardMediaqueryTarget.h"
    
@interface BackwardMediaqueryTarget ()

@end

@implementation BackwardMediaqueryTarget

- (void) listenSeguePerItem: (int)textWithoutVisitor
{
	dispatch_async(dispatch_get_main_queue(), ^{
		UIActivityIndicatorView *inkwellPerSingleton = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleMedium];
		[inkwellPerSingleton setFrame:CGRectMake(textWithoutVisitor, 70, 198, 178)];
		if (inkwellPerSingleton.animating) {
			[inkwellPerSingleton stopAnimating];
			[inkwellPerSingleton startAnimating];
			[inkwellPerSingleton startAnimating];
			[inkwellPerSingleton startAnimating];
		}
		inkwellPerSingleton.hidesWhenStopped = YES;
		//NSLog(@"sets= bussiness4 gen_int %@", bussiness4);
	});
}


@end
        