//>---------------------------------------------------------------------------------------------------
// Page/Module Name	: EKWelcomeView
// Author Name		: Paul Prashant
// Date             : Oct, 10 2016
// Purpose			: Header file.
//>---------------------------------------------------------------------------------------------------


#import <UIKit/UIKit.h>

@protocol EKDismissWelcomeScreenDelegate <NSObject>

- (void)dismissWelcomeScreen;

@end


@interface EKWelcomeView : UIView

@property (nonatomic, unsafe_unretained) id <EKDismissWelcomeScreenDelegate> delegate;

@end
