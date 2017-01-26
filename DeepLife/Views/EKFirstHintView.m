//>---------------------------------------------------------------------------------------------------
// Page/Module Name	: EKFirstHintView
// Author Name		: Paul Prashant
// Date             : Oct, 10 2016
// Purpose			: Implementation file.
//>---------------------------------------------------------------------------------------------------


#import "EKFirstHintView.h"

@interface EKFirstHintView ()
{
    CGFloat screenHeight;
}

@property (nonatomic, strong) UILabel *lblWelcome;
@property (nonatomic, strong) UILabel *lblText;

@end


@implementation EKFirstHintView

- (id)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	if (self) {
		self.backgroundColor = [UIColor clearColor];
	}
    
	self.lblWelcome = [[UILabel alloc] init];
	self.lblWelcome.backgroundColor = [UIColor clearColor];
	self.lblWelcome.textAlignment = NSTextAlignmentCenter;
	self.lblWelcome.text = @"Welcome";
	self.lblWelcome.textColor = [UIColor whiteColor];
    self.lblWelcome.numberOfLines = 1;
	[self addSubview:self.lblWelcome];
    
    self.lblText = [[UILabel alloc] init];
    self.lblText.backgroundColor = [UIColor clearColor];
    self.lblText.textAlignment = NSTextAlignmentCenter;
    self.lblText.text = @"Deeplife is a web based system which enables you to create your descipls and make accountable in discipling them. To see multiple tree of generation in your ministry.";
    self.lblText.textColor = [UIColor whiteColor];
    self.lblText.numberOfLines = 0;
    [self addSubview:self.lblText];
	
    screenHeight = [[UIScreen mainScreen] bounds].size.height;
	return self;
}

- (void)layoutSubviews
{
    
    NSLog(@"height=%f",screenHeight);
    if(screenHeight < 568){
        screenHeight = screenHeight - screenHeight/16;
    }else if(screenHeight < 667){
        screenHeight = screenHeight - screenHeight/6;
    }else{
        screenHeight = screenHeight - screenHeight/5;
    }
    
	self.lblWelcome.frame = CGRectMake(self.bounds.origin.x, screenHeight/2.5, self.frame.size.width, self.bounds.size.height/10);
    [self.lblWelcome setFont: [UIFont fontWithName:@"HelveticaNeue" size:self.lblWelcome.frame.size.height/1.7]];
    self.lblWelcome.adjustsFontSizeToFitWidth = YES;
    
    self.lblText.frame = CGRectMake(self.bounds.origin.x, screenHeight/2.5 + self.lblWelcome.frame.size.height*1.2, self.frame.size.width, self.bounds.size.height - self.lblWelcome.frame.size.height);
    [self.lblText sizeToFit];
    [self.lblText setFont: [UIFont fontWithName:@"HelveticaNeue-Light" size:self.lblWelcome.frame.size.height/2.2]];
}

@end
