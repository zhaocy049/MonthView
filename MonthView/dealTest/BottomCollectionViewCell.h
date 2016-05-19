//
//  BottomCollectionViewCell.h
//  dealTest
//
//  Created by haishi on 16/1/11.
//  Copyright © 2016年 haishi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MonthCollectionView.h"
#import "WeekCollectionView.h"
#import "PWSHelper.h"
#import "LunarSolarConverter.h"

//typedef void(^bottomBlock) (NSArray *array, NSInteger num);
@interface BottomCollectionViewCell : UICollectionViewCell<UICollectionViewDataSource,UICollectionViewDelegate>

{
    NSCalendar *  m_calendar;
    NSDate     *  m_first_date;
    UICollectionView* _collectionView ;
    
    NSDate     *_selectDate;
    
    
    UICollectionViewFlowLayout *_layout;
    
    Lunar * _lunarCalendar;
    Solar * _solarCalendar;
}
//@property (nonatomic, strong) bottomBlock bottomBlock;
@property (nonatomic, assign) id<ZCYWeekCalendarDelegate> week_delegate;

@property (nonatomic, assign) id<ZCYCalendarDelegate> month_delegate;

@property (nonatomic, assign) enCalendarViewType type;
- (void) SetWithDate:(NSDate*)pDate ShowType:(enCalendarViewType)pCalendarType;
@end
