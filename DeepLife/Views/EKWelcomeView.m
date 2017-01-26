//>---------------------------------------------------------------------------------------------------
// Page/Module Name	: EKWelcomeView
// Author Name		: Paul Prashant
// Date             : Oct, 10 2016
// Purpose			: Implementation file.
//>---------------------------------------------------------------------------------------------------


#import "EKWelcomeView.h"
#import "EKFirstHintView.h"
#import "EKSecondHintView.h"

@interface EKWelcomeView () <UIScrollViewDelegate,UIGestureRecognizerDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong) UIButton *button;
@property (nonatomic, assign) BOOL pageControlBeingUsed;
@property (nonatomic, strong) EKFirstHintView *firstView;
@property (nonatomic, strong) EKSecondHintView *secondView;

@property (nonatomic, copy) NSArray *pages;

@end


@implementation EKWelcomeView

- (id)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
    
	if (self) {
		self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"step1"]];
		[self createSubViews];
		self.pages = @[self.firstView, self.secondView];
	}
    
	return self;
}

- (void)createSubViews
{
    self.scrollView                                = [[UIScrollView alloc] init];
    self.scrollView.backgroundColor                = [UIColor clearColor];
    self.scrollView.delegate                       = self;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.pagingEnabled                  = YES;
	[self addSubview:self.scrollView];
    
	self.firstView = [[EKFirstHintView alloc] init];
	[self.scrollView addSubview:self.firstView];
    
	self.secondView = [[EKSecondHintView alloc] init];
	[self.scrollView addSubview:self.secondView];
    
    
    self.pageControl               = [[UIPageControl alloc] init];
    self.pageControl.numberOfPages = 2;
    self.pageControl.currentPage   = 0;
    self.pageControl.transform = CGAffineTransformMakeScale(1.5, 1.5);
    self.pageControl.currentPageIndicatorTintColor = [UIColor colorWithRed:255.0f/255.0f green:201.0f/255.0f blue:64.0f/255.0f alpha:1.0f];
	[self.pageControl addTarget:self action:@selector(changePage:) forControlEvents:UIControlEventTouchUpInside];
	[self addSubview:self.pageControl];
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
    [self addGestureRecognizer:singleTap];
    
    UISwipeGestureRecognizer *recognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeFrom:)];
    recognizer.delegate = self;
    [recognizer setDirection: UISwipeGestureRecognizerDirectionLeft];
    [self addGestureRecognizer:recognizer];
}
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    return YES;
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    return YES;
}
- (void)handleSingleTap:(UITapGestureRecognizer *)recognizer {
    NSLog(@"singletap");
    if (self.pageControl.currentPage==1) {
        [self.delegate dismissWelcomeScreen];
    }
}
-(void)handleSwipeFrom:(UISwipeGestureRecognizer *)recognizer {
    NSLog(@"Swipe received.");
    if (self.pageControl.currentPage==1) {
        [self.delegate dismissWelcomeScreen];
    }
}

#pragma mark - Layout subviews stuff

- (void)layoutSubviews
{
	[super layoutSubviews];
    
	self.scrollView.frame = CGRectMake(0.0f, self.frame.origin.y, self.bounds.size.width, self.bounds.size.height);
	self.scrollView.contentSize = CGSizeMake(self.bounds.size.width * [self.pages count], self.scrollView.bounds.size.height);
	self.scrollView.contentOffset = CGPointMake(self.bounds.size.width * self.pageControl.currentPage, 0);
    
	self.pageControl.frame = CGRectMake(self.bounds.origin.x, self.bounds.size.height/1.3, self.bounds.size.width, 40.0f);
    
	for (NSUInteger i = 0; i < [self.pages count]; i++) {
		[[[self.scrollView subviews] objectAtIndex:i] setFrame:CGRectMake(30.0f + (i * self.bounds.size.width), 40.0f,
		                                                                  self.bounds.size.width - 60.0f, self.bounds.size.height - 150.0f)];
	}
    
    
	//self.button.frame = CGRectMake(self.bounds.size.width - 50.0f, 15.0f, 50.0f, 20.0f);
}

#pragma mark - ScrollView's delegate stuff

- (void)scrollViewDidScroll:(UIScrollView *)sender
{
	if (!self.pageControlBeingUsed) {
		NSInteger page = round(self.scrollView.contentOffset.x / self.scrollView.bounds.size.width);
		self.pageControl.currentPage = page;
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    NSLog(@"page1=%ld",(long)self.pageControl.currentPage);
	self.pageControlBeingUsed = NO;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSLog(@"page2=%ld",(long)self.pageControl.currentPage);
	self.pageControlBeingUsed = NO;
}

#pragma mark - Action on pageControl pressed

- (void)changePage:(id)sender
{
	if (sender) {
		[self.scrollView setContentOffset:CGPointMake(self.bounds.size.width * self.pageControl.currentPage, 0) animated:YES];
		self.pageControlBeingUsed = YES;
    }
}

#pragma mark - Delegate stuff

- (void)goNext
{
    NSLog(@"goNext");
	if (self.delegate) {
		[self.delegate dismissWelcomeScreen];
	}
}

@end
