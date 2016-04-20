//
//  DPCalendarTestStoryboardViewController.m
//  DPCalendar
//
//  Created by Shan Wang on 15/03/2014.
//  Copyright (c) 2014 Ethan Fang. All rights reserved.
//

#import "DPCalendarTestStoryboardViewController.h"
#import "DPCalendarMonthlyView.h"
#import "DPCalendarEvent.h"
#import "DPCalendarIconEvent.h"
#import "NSDate+DP.h"
#import <UIKit/UIKit.h>
#import "DPCalendarTestViewController.h"
#import "DPCalendarMonthlySingleMonthViewLayout.h"
#import "Technovation_2016-Swift.h"

#define IDIOM    UI_USER_INTERFACE_IDIOM()
#define IPAD     UIUserInterfaceIdiomPad

@interface DPCalendarTestStoryboardViewController ()<DPCalendarMonthlyViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *gtitle;
//@property (weak, nonatomic) IBOutlet DPCalendarMonthlyView *calendarMonthlyView;
@property (nonatomic, strong) NSMutableArray *events;
@property (nonatomic, strong) NSMutableArray *iconEvents;
@property (weak, nonatomic) IBOutlet UICollectionView *titleCollectionView;

@property (nonatomic, strong) UILabel *monthLabel;
@property (nonatomic, strong) UIButton *previousButton;
@property (nonatomic, strong) UIButton *nextButton;
//@property (nonatomic, strong) NSString *title;
//@property (nonatomic, strong) UIButton *addEventButton;
//@property (nonatomic, strong) UIButton *createEventButton;
//@property (nonatomic, strong) UIButton *optionsButton;
//@property (nonatomic, strong) UIButton *backButton;


@property (nonatomic, strong) DPCalendarMonthlyView *monthlyView;


@property (nonatomic, strong) NSArray *weektitles;
@end


@implementation DPCalendarTestStoryboardViewController

@dynamic title;

int i=0;

/*- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self generateData];
        [self commonInit];
        
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self generateData];
        [self commonInit];
    }
    return self;
}*/

-(void) commonInit {
    [self generateMonthlyView];
    [self updateLabelWithMonth:self.monthlyView.seletedMonth];
}

- (void) generateMonthlyView {
    CGFloat width = [self.class currentSize].width;
    CGFloat height = [self.class currentSize].height;
    
    [self.previousButton removeFromSuperview];
    [self.nextButton removeFromSuperview];
    [self.monthLabel removeFromSuperview];
    //[self.addEventButton removeFromSuperview];
    //[self.optionsButton removeFromSuperview];
    //[self.createEventButton removeFromSuperview];
    
    self.monthLabel = [[UILabel alloc] initWithFrame:CGRectMake((width - 100) / 2, 20, 100, 20)];
    [self.monthLabel setTextAlignment:NSTextAlignmentCenter];
    
    self.previousButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.previousButton setBackgroundImage:[UIImage imageNamed:@"IconArrowPrev"] forState:UIControlStateNormal];
    self.nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.nextButton setBackgroundImage:[UIImage imageNamed:@"IconArrowNext"] forState:UIControlStateNormal];
    //self.addEventButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    //self.backButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    //self.optionsButton  = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    //self.createEventButton = [UIButton buttonWithType:UIButtonTypeCustom];
    //[self.createEventButton setBackgroundImage:[UIImage imageNamed:@"BtnAddSomething"] forState:UIControlStateNormal];
    self.previousButton.frame = CGRectMake(self.monthLabel.frame.origin.x - 18, 20, 18, 20);
    self.nextButton.frame = CGRectMake(CGRectGetMaxX(self.monthLabel.frame), 20, 18, 20);
    //self.addEventButton.frame = CGRectMake(width - 60, 20, 60, 21);
    //self.backButton.frame = CGRectMake(40, 20, 50, 20);
    //    self.optionsButton.frame = CGRectMake(width - 50 * 3, 20, 50, 20);
    //self.createEventButton.frame = CGRectMake(10, 20, 20, 20);
    //[self.addEventButton setTitle:@"Add Event" forState:UIControlStateNormal];
    //[self.optionsButton setTitle:@"Option" forState:UIControlStateNormal];
    //[self.backButton setTitle:@"Back" forState:UIControlStateNormal];
    
    
    
    [self.previousButton addTarget:self action:@selector(previousButtonSelected:) forControlEvents:UIControlEventTouchUpInside];
    [self.nextButton addTarget:self action:@selector(nextButtonSelected:) forControlEvents:UIControlEventTouchUpInside];
    //[self.addEventButton addTarget:self action:@selector(todayButtonSelected:) forControlEvents:UIControlEventTouchUpInside];
    //[self.backButton addTarget:self action:@selector(backButtonSelected:) forControlEvents:UIControlEventTouchUpInside];
    /*[self.optionsButton addTarget:self action:@selector(optionsButtonSelected:) forControlEvents:UIControlEventTouchUpInside];
     [self.createEventButton addTarget:self action:@selector(createEventButtonSelected:) forControlEvents:UIControlEventTouchUpInside]; */
    
    [self.view addSubview:self.monthLabel];
    [self.view addSubview:self.previousButton];
    [self.view addSubview:self.nextButton];
    //[self.view addSubview:self.addEventButton];
    //[self.view addSubview:self.backButton];
    //    [self.view addSubview:self.optionsButton];
    //[self.view addSubview:self.createEventButton];
    [self.monthlyView removeFromSuperview];
    self.monthlyView = [[DPCalendarMonthlyView alloc] initWithFrame:CGRectMake(0, 100, width, height - 50) delegate:self];
    [self.view addSubview:self.monthlyView];
    
    AppDelegate *myAppDelegate = [[UIApplication sharedApplication] delegate];
    self.events = myAppDelegate.events;

    [self.monthlyView setEvents: myAppDelegate.events complete:nil];
    
    [self.monthlyView setIconEvents:self.iconEvents complete:nil];
}

- (void) backButtonSelected:(id)button {
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void) previousButtonSelected:(id)button {
    [self.monthlyView scrollToPreviousMonthWithComplete:nil];
}

-(void) nextButtonSelected:(id)button {
    [self.monthlyView scrollToNextMonthWithComplete:nil];
}

-(void) todayButtonSelected:(id)button {
    [self.monthlyView clickDate:[NSDate date]];
}

/*-(void) optionsButtonSelected:(id)button {
 DPCalendarTestOptionsViewController *optionController = [DPCalendarTestOptionsViewController new];
 UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:optionController];
 navController.modalPresentationStyle = UIModalPresentationFormSheet;
 
 UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
 [rightBtn setTitle:@"TEST" forState:UIControlStateNormal];
 rightBtn.frame = CGRectMake(0, 0, 70, 40 );
 UIBarButtonItem *rightBarBtn = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
 navController.navigationItem.rightBarButtonItem = rightBarBtn;
 if (IDIOM == IPAD) {
 [self presentViewController:navController animated:YES completion:nil];
 } else {
 
 }
 } */

/*- (void) createEventButtonSelected:(id)button {
 DPCalendarTestCreateEventViewController *createEventController = [DPCalendarTestCreateEventViewController new];
 createEventController.delegate = self;
 UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:createEventController];
 navController.modalPresentationStyle = UIModalPresentationFormSheet;
 
 UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
 [rightBtn setTitle:@"Done" forState:UIControlStateNormal];
 rightBtn.frame = CGRectMake(0, 0, 70, 40 );
 UIBarButtonItem *rightBarBtn = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
 navController.navigationItem.rightBarButtonItem = rightBarBtn;
 if (IDIOM == IPAD) {
 [self presentViewController:navController animated:YES completion:nil];
 } else {
 
 }
 }*/

#pragma DPCalendarMonthlyViewDelegate
-(void)didScrollToMonth:(NSDate *)month firstDate:(NSDate *)firstDate lastDate:(NSDate *)lastDate{
    [self updateLabelWithMonth:month];
}

-(void)didSkipToMonth:(NSDate *)month firstDate:(NSDate *)firstDate lastDate:(NSDate *)lastDate {
    [self updateLabelWithMonth:month];
}

-(void)didTapEvent:(DPCalendarEvent *)event onDate:(NSDate *)date {
    NSLog(@"Touched event %@, date %@", event.title, date);
}

-(BOOL)shouldHighlightItemWithDate:(NSDate *)date {
    return YES;
}

-(BOOL)shouldSelectItemWithDate:(NSDate *)date {
    return YES;
}

-(void)didSelectItemWithDate:(NSDate *)date {
    //NSLog(@"Select date %@ with \n events %@ \n and icon events %@", date, [self.calendarMonthlyView eventsForDay:date], [self.calendarMonthlyView iconEventsForDay:date]);
    NSLog(@"Select date %@ with \n events %@ \n and icon events %@", date, [self.monthlyView eventsForDay:date], [self.monthlyView iconEventsForDay:date]);
    
}

-(NSDictionary *)monthlyViewAttributes {
    if (IDIOM == IPAD) {
        return [self ipadMonthlyViewAttributes];
    } else {
        return [self iphoneMonthlyViewAttributes];
    }
}

#pragma mark - Utilities

+(CGSize) currentSize
{
    return [self sizeInOrientation:[UIApplication sharedApplication].statusBarOrientation];
}

+(CGSize) sizeInOrientation:(UIInterfaceOrientation)orientation
{
    CGSize size = [UIScreen mainScreen].bounds.size;
    if (UIInterfaceOrientationIsLandscape(orientation))
    {
        size = CGSizeMake(size.height, size.width);
    }
    return size;
}

/*#pragma mark - DPCalendarTestCreateEventViewControllerDelegate
 -(void)eventCreated:(DPCalendarEvent *)event {
 [self.events addObject:event];
 [self.monthlyView setEvents:self.events complete:nil];
 
 }*/

#pragma mark - Rotation
-(BOOL)shouldAutorotate {
    return YES;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    AppDelegate *myAppDelegate = [[UIApplication sharedApplication] delegate];
    self.events = myAppDelegate.events;
    self.titleCollectionView.backgroundColor = [UIColor whiteColor];
    self.titleCollectionView.delegate = self;
    self.titleCollectionView.dataSource = self;
    self.weektitles = @[@"Sun", @"Mon", @"Tue",@"Wed",@"Thu",@"Fri",@"Sat"];
    
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.sectionInset = UIEdgeInsetsZero;
    layout.minimumInteritemSpacing = 0.f;
    layout.minimumLineSpacing = 0.f;
    layout.headerReferenceSize = CGSizeZero;
    layout.footerReferenceSize = CGSizeZero;
    self.titleCollectionView.collectionViewLayout = layout;
    
    //self.calendarMonthlyView.monthlyViewDelegate = self;
    
    [self generateData];
    [self commonInit];
    //NSLog(@"Title: %@", ((DPCalendarEvent*)_events[0]).title);
    
    //[self.calendarMonthlyView setEvents: myAppDelegate.events complete:nil];
    //[self.calendarMonthlyView setIconEvents:self.iconEvents complete:nil];
    
	//[self updateLabelWithMonth:self.calendarMonthlyView.seletedMonth];
    [self updateLabelWithMonth:self.monthlyView.seletedMonth];

}

- (void) updateLabelWithMonth:(NSDate *)month {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MMM YYYY"];
    NSString *stringFromDate = [formatter stringFromDate:month];
    [self.gtitle setText:stringFromDate];
    [self.monthLabel setText:stringFromDate];
}

- (void) generateData {
    _events = @[].mutableCopy;
    self.iconEvents = @[].mutableCopy;
    
    
    NSDate *date = [[NSDate date] dateByAddingYears:0 months:0 days:0];
    //UIImage *icon = [UIImage imageNamed:@"IconPubHol"];
    //UIImage *greyIcon = [UIImage imageNamed:@"IconDateGrey"];
    
    //NSArray *titles = @[@"Medicine", @"Special Event", @"Exercise", @"Sleeping"];
    
    for (int i = 0; i < 60; i++) {
        /*if (arc4random() % 2 > 0) {
            int index = arc4random() % 2;
            DPCalendarEvent *event = [[DPCalendarEvent alloc] initWithTitle:[titles objectAtIndex:index] startTime:date endTime:[date dateByAddingYears:0 months:0 days:arc4random() % 3] colorIndex:index];
            [_events addObject:event];
        }*/
        
        /*if (arc4random() % 2 > 0) {
            DPCalendarIconEvent *iconEvent = [[DPCalendarIconEvent alloc] initWithStartTime:date endTime:[date dateByAddingYears:0 months:0 days:0] icon:icon];
            [self.iconEvents addObject:iconEvent];
            
            
            iconEvent = [[DPCalendarIconEvent alloc] initWithTitle:[NSString stringWithFormat:@"%d", i] startTime:date endTime:[date dateByAddingYears:0 months:0 days:0] icon:greyIcon bkgColorIndex:1];
            [self.iconEvents addObject:iconEvent];
        }*/
        
        date = [date dateByAddingYears:0 months:0 days:1];
    }
    
}


/*- (void)showCalendarViewControllerFromStoryboard:(id)sender {
    DPCalendarTestViewController *testViewController = [DPCalendarTestViewController new];
    [self presentViewController:testViewController animated:YES completion:nil];
}*/

-(NSDictionary *) iphoneMonthlyViewAttributes {
    return @{
             DPCalendarMonthlyViewAttributeEventDrawingStyle: [NSNumber numberWithInt:DPCalendarMonthlyViewEventDrawingStyleUnderline],
             DPCalendarMonthlyViewAttributeCellNotInSameMonthSelectable: @YES,
             DPCalendarMonthlyViewAttributeMonthRows:@3,
             DPCalendarMonthlyViewAttributeWeekdayHeight: @0.f
             };
}

-(NSDictionary *) ipadMonthlyViewAttributes {
    return @{
             DPCalendarMonthlyViewAttributeCellRowHeight: @23,
             DPCalendarMonthlyViewAttributeStartDayOfWeek: @0,
             DPCalendarMonthlyViewAttributeEventDrawingStyle: [NSNumber numberWithInt:DPCalendarMonthlyViewEventDrawingStyleUnderline],
             DPCalendarMonthlyViewAttributeWeekdayFont: [UIFont systemFontOfSize:20],
             DPCalendarMonthlyViewAttributeDayFont: [UIFont systemFontOfSize:20],
             DPCalendarMonthlyViewAttributeEventFont: [UIFont systemFontOfSize:16],
             DPCalendarMonthlyViewAttributeMonthRows:@5,
             DPCalendarMonthlyViewAttributeIconEventBkgColors: @[[UIColor clearColor], [UIColor colorWithRed:239/255.f green:239/255.f blue:244/255.f alpha:1]],
             DPCalendarMonthlyViewAttributeWeekdayHeight: @0.f
             };

}

#pragma mark - Rotation

-(void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
    //[self.calendarMonthlyView resetViews];
    [self.titleCollectionView reloadData];
    [self commonInit];
}

-(BOOL)shouldAutomaticallyForwardAppearanceMethods{
    //[self.calendarMonthlyView resetViews];
    return YES;
}

- (void)orientationChanged:(NSNotification *)notification
{
    //[self.calendarMonthlyView resetViews];
}

#pragma mark - UICollectionViewDataSource
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 7;
}

#define CalendarTitleCellIdentifier @"CalendarTitleCellIdentifier"

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CalendarTitleCellIdentifier forIndexPath:indexPath];
    UILabel *label = (UILabel *)[cell viewWithTag:1];
    CGSize size = [self collectionView:collectionView layout:collectionView.collectionViewLayout sizeForItemAtIndexPath:indexPath];
    label.frame = CGRectMake(0, 0, size.width, size.height);
    label.text = [self.weektitles objectAtIndex:indexPath.row];
    return cell;
}

#pragma mark - UICollectionViewDelegate
- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout*)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat itemWidth  = floorf(self.titleCollectionView.bounds.size.width / self.weektitles.count);
    CGFloat itemHeight = roundf(self.titleCollectionView.bounds.size.height);
    
    return CGSizeMake(itemWidth, itemHeight);
}

@end
