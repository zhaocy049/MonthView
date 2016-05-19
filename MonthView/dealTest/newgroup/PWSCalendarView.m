//
//  PWSCalendarView.m
//  PWSCalendar
//
//  Created by Sylar on 3/14/14.
//  Copyright (c) 2014 PWS. All rights reserved.
//
//////////////////////////////////////////////////////////////////////////////
#import "PWSCalendarView.h"

#import "PWSCalendarViewCell.h"
//////////////////////////////////////////////////////////////////////////////
//const float PWSCalendarHeadTimeLabelHeight = 67;
//const float PWSCalendarHeadSegmentHeight = 25;
//const float PWSCalendarHeadSeperateLineHeight = 5;
//const float PWSCalendarHeadWeekdaysHeight = 25;


const float PWSCalendarTimeHeadViewHeight = 60;
//const float PWSCalendarDataHeadViewHeight = 60;
const float PWSCalendarSegmentHeight = 25;
const float PWSCalendarSeperateLineHeight= 5;
const float PWSCalendarWeekDaysHeight = 25;

extern NSString* PWSCalendarViewCellId;
const int   PWSCalendarViewNumber = 1000;
//////////////////////////////////////////////////////////////////////////////
@interface PWSCalendarView()
<PWSCalendarDelegate,
UICollectionViewDataSource,
UICollectionViewDelegate>
{
    // data
    NSDate*            m_current_date;
    int                m_current_page;
    
    // head view
    UIView*            m_view_head;
    UILabel*           m_label_time;       // the label
    UIView*            m_time_head_view;   // the time view
    UIView*            m_data_head_view;   // the data view
  
    UIView*            m_view_weekdays;
    
   
}
@end
//////////////////////////////////////////////////////////////////////////////
@implementation PWSCalendarView


- (id) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        m_current_date = [NSDate date];
        [self SetInitialValue];
    }
    return self;
}





- (void) AutoLayoutCustomHeadView
{
    float origin_y = 0;

    CGRect frame = m_time_head_view.frame;
    frame.origin.y = origin_y;
    [m_time_head_view setFrame:frame];
    origin_y += frame.size.height;
    
    frame = m_data_head_view.frame;
    frame.origin.y = origin_y;
    [m_data_head_view setFrame:frame];
    origin_y += frame.size.height;
    
    frame = _m_view_calendar.frame;
    [_m_view_calendar setFrame:CGRectMake(0, origin_y, self.frame.size.width, self.frame.size.height-origin_y)];
}

- (void) SetInitialValue
{

    [self SetCollectionView];
}

- (void) SetDataHeadView
{
    if (m_data_head_view)
    {
        return;
    }
    float width = self.frame.size.width;
    float origin_x = 0;
    

    
    // weekdays
    origin_x += PWSCalendarSeperateLineHeight;
    NSArray* weekdays = [NSArray arrayWithObjects:@"SUN", @"MON", @"TUE", @"WED", @"THU", @"FRI", @"SAT", nil];
    float day_width = width/7;
    for (int i=0; i<7; i++)
    {
        UILabel* each_day = [[UILabel alloc] init];
        [each_day setText:[weekdays objectAtIndex:i]];
        [each_day setTextAlignment:NSTextAlignmentCenter];
        CGRect each_day_frame = CGRectMake(i*day_width, origin_x, day_width, PWSCalendarWeekDaysHeight);
        [each_day setFrame:each_day_frame];
        [m_data_head_view addSubview:each_day];
    }
}

- (void) SetLabelDate:(NSDate*)_date
{
    NSDateFormatter* ff = [[NSDateFormatter alloc] init];
    [ff setDateFormat:@"yyyy-MM-dd"];
    NSString* date = [ff stringFromDate:_date];
    if (m_label_time)
    {
        [m_label_time setText:date];
    }
}


- (void) SetCollectionView
{
    self.backgroundColor = [UIColor purpleColor];
    float width = self.frame.size.width;
    float height = self.frame.size.height;
    UICollectionViewFlowLayout* layout = [[UICollectionViewFlowLayout alloc] init];
    [layout setMinimumLineSpacing:0];
    [layout setMinimumInteritemSpacing:0];
    [layout setItemSize:CGSizeMake(width, 500)];
    [layout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    
  UICollectionView*  m_view_calendar = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 100, width, 300) collectionViewLayout:layout];
    //height-[self GetHeaderViewHeight]
    [m_view_calendar setShowsHorizontalScrollIndicator:YES];
    [m_view_calendar setDelegate:self];
    [m_view_calendar setDataSource:self];
    [m_view_calendar setBackgroundColor:[UIColor orangeColor]];
    [self addSubview:m_view_calendar];
    m_view_calendar.pagingEnabled = YES;
    
    [m_view_calendar registerClass:[PWSCalendarViewCell class] forCellWithReuseIdentifier:PWSCalendarViewCellId.copy];
    
  
}

// collection view delegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return PWSCalendarViewNumber;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PWSCalendarViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:PWSCalendarViewCellId.copy forIndexPath:indexPath];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    float cell_width = collectionView.frame.size.width;
    int pos_x = collectionView.contentOffset.x;
    int index = (pos_x+20)/cell_width;
    
    
    [self SetLabelDate:m_current_date];
    [self PWSCalendar:nil didChangeViewHeight:0];
}

- (void) ScrollToToday
{
   
}


// calendar delegate
- (void) PWSCalendar:(PWSCalendarView *)_calendar didSelecteDate:(NSDate *)_date
{
    m_current_date = _date;
    [self SetLabelDate:_date];
    if ([self.delegate respondsToSelector:@selector(PWSCalendar:didSelecteDate:)])
    {
        [self.delegate PWSCalendar:self didSelecteDate:_date];
    }
}
@end
