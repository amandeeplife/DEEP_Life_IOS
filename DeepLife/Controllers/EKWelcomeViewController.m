//>---------------------------------------------------------------------------------------------------
// Page/Module Name	: EKWelcomeViewController
// Author Name		: Paul Prashant
// Date             : Oct, 10 2016
// Purpose			: Implementation file.
//>---------------------------------------------------------------------------------------------------


#import "EKWelcomeViewController.h"
#import "EKWelcomeView.h"

@class SignupViewController;

static NSString * const kEKSegueIdentifier = @"signupSegue";

@interface EKWelcomeViewController () <EKDismissWelcomeScreenDelegate>

@property (nonatomic, strong) EKWelcomeView *welcomeView;

@end


@implementation EKWelcomeViewController

- (void)loadView
{
	EKWelcomeView *view = [[EKWelcomeView alloc] init];
	self.view = view;
	self.welcomeView = view;
}

- (void)viewDidLoad
{
	[super viewDidLoad];
	self.welcomeView.delegate = self;
}

- (void)didReceiveMemoryWarning
{
	[super didReceiveMemoryWarning];
}

#pragma mark - EKDismissWelcomeScreenDelegate's & segue's stuff

- (void)dismissWelcomeScreen
{
	[self performSegueWithIdentifier:kEKSegueIdentifier sender:self];
    
}
/*
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
	if ([segue.identifier isEqualToString:kEKSegueIdentifier]) {
		self.myDestinationViewController = (EKDestinationViewController *)segue.destinationViewController;
		self.myDestinationViewController = [segue destinationViewController];
        
	}
}*/

@end
