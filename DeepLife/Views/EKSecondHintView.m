//>---------------------------------------------------------------------------------------------------
// Page/Module Name	: EKSecondHintView
// Author Name		: Paul Prashant
// Date             : Oct, 10 2016
// Purpose			: Implementation file.
//>---------------------------------------------------------------------------------------------------


#import "EKSecondHintView.h"

@interface EKSecondHintView ()
{
    CGFloat screenHeight;
}
@property (nonatomic, strong) UILabel *lblTitle;
@property (nonatomic, strong) UILabel *lblText;
@property (nonatomic, strong) UILabel *hint;
@property (nonatomic, strong) UILabel *line1;
@property (nonatomic, strong) UILabel *line2;

@end

@implementation EKSecondHintView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    
    self.lblTitle = [[UILabel alloc] init];
    self.lblTitle.backgroundColor = [UIColor clearColor];
    self.lblTitle.textAlignment = NSTextAlignmentCenter;
    self.lblTitle.text = @"Pray | Meet | Call";
    self.lblTitle.textColor = [UIColor colorWithRed:255.0f/255.0f green:201.0f/255.0f blue:64.0f/255.0f alpha:1.0f];
    self.lblTitle.numberOfLines = 0;
    [self addSubview:self.lblTitle];
    
    self.line1 = [[UILabel alloc] init];
    self.line1.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.line1];
    
    self.lblText = [[UILabel alloc] init];
    self.lblText.backgroundColor = [UIColor clearColor];
    self.lblText.textAlignment = NSTextAlignmentCenter;

    self.lblText.text = @"Lets make disciples, its our calling. Add your new disciples with their full information.";
    self.lblText.textColor = [UIColor whiteColor];
    self.lblText.numberOfLines = 0;
    [self addSubview:self.lblText];
    
    self.line2 = [[UILabel alloc] init];
    self.line2.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.line2];
    
    self.hint = [[UILabel alloc] init];
    self.hint.backgroundColor = [UIColor clearColor];
    self.hint.textAlignment = NSTextAlignmentCenter;
    self.hint.text = @"go and make disciples of all nations Matthew 28:19.";
    self.hint.textColor = [UIColor whiteColor];
    self.hint.numberOfLines = 0;
    [self addSubview:self.hint];
    
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
    
    self.lblTitle.frame = CGRectMake(self.bounds.origin.x, screenHeight/2.5, self.frame.size.width, self.bounds.size.height/10);
    [self.lblTitle setFont: [UIFont fontWithName:@"HelveticaNeue-Bold" size:self.lblTitle.frame.size.height/1.6]];
    self.lblTitle.adjustsFontSizeToFitWidth = YES;
    
    self.line1.frame = CGRectMake(self.bounds.origin.x+self.frame.size.width/3.3, screenHeight/2.4+self.lblTitle.frame.size.height, self.frame.size.width-self.frame.size.width/1.6, 1);
    
    self.lblText.frame = CGRectMake(self.bounds.origin.x, screenHeight/2.25+self.lblTitle.frame.size.height, self.frame.size.width, self.bounds.size.height - self.lblTitle.frame.size.height);
    [self.lblText sizeToFit];
    [self.lblText setFont: [UIFont fontWithName:@"HelveticaNeue-Light" size:self.lblTitle.frame.size.height/2.5]];
    
    self.line2.frame = CGRectMake(self.bounds.origin.x+self.frame.size.width/3.3, screenHeight/2.5+self.lblTitle.frame.size.height*1.8+self.lblText.frame.size.height, self.frame.size.width-self.frame.size.width/1.6, 1);
    
    self.hint.frame = CGRectMake(self.bounds.origin.x+15, screenHeight/2.5 + self.lblTitle.frame.size.height*2.2 + self.lblText.frame.size.height, self.frame.size.width-30, self.bounds.size.height - (self.lblTitle.frame.size.height+self.lblText.frame.size.height));
    [self.hint sizeToFit];
    [self.hint setFont: [UIFont fontWithName:@"HelveticaNeue-Bold" size:self.lblTitle.frame.size.height/2.5]];
}

@end
