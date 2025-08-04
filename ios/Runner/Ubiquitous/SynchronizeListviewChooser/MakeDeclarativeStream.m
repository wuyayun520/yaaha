#import "MakeDeclarativeStream.h"
    
@interface MakeDeclarativeStream ()

@end

@implementation MakeDeclarativeStream

- (void) onTaskCharacteristic: (int)sineMediatorDirection
{
	dispatch_async(dispatch_get_main_queue(), ^{
		UIActivityIndicatorView *dynamicGramAppearance = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleLarge];
		dynamicGramAppearance.color = UIColor.darkGrayColor;
		dynamicGramAppearance.hidesWhenStopped = NO;
		[dynamicGramAppearance startAnimating];
		dynamicGramAppearance.hidesWhenStopped = YES;
		//NSLog(@"sets= bussiness4 gen_int %@", bussiness4);
	});
}


@end
        