//
//  PWSCalendarView.h
//  PWSCalendar
//
//  Created by Sylar on 3/14/14.
//  Copyright (c) 2014 PWS. All rights reserved.
//
/////////////////////////////////////////////////////////////////////////////////////////////
#import <UIKit/UIKit.h>

@class PWSCalendarView;
/////////////////////////////////////////////////////////////////////////////////////////////
@protocol PWSCalendarDelegate <NSObject>

@optional
- (void) PWSCalendar:(PWSCalendarView*)_calendar didSelecteDate:(NSDate*)_date;

- (void) PWSCalendar:(PWSCalendarView*)_calendar didChangeViewHeight:(CGFloat)_height;

@end

/////////////////////////////////////////////////////////////////////////////////////////////
@interface PWSCalendarView : UIView

@property (nonatomic, strong) id<PWSCalendarDelegate> delegate;

@property (nonatomic, strong) UIView*                 customTimeView;
@property (nonatomic, strong) UIView*                 customDataView;
@property (nonatomic, strong) UICollectionView*  m_view_calendar;

- (float) GetCalendarViewHeight __deprecated;

@end
