//
//  MonthCollectionView.h
//  dealTest
//
//  Created by haishi on 16/1/11.
//  Copyright © 2016年 haishi. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MonthCollectionView;
@protocol ZCYCalendarDelegate <NSObject>

@optional
- (void) ZCYCalendar:(MonthCollectionView*)_calendar didSelecteDate:(NSArray *)array;

//- (void) ZCYCalendar:(MonthCollectionView*)_calendar didChangeViewHeight:(CGFloat)_height;

@end

@interface MonthCollectionView : UIView<UICollectionViewDataSource, UICollectionViewDelegate,ZCYCalendarDelegate>
{
     int                m_current_page;
     NSDate*            m_current_date;

}
@property (nonatomic, assign) id<ZCYCalendarDelegate> delegate;
@property (nonatomic, strong) NSDate  *month_date;
@property (nonatomic, strong) UICollectionView  *collectionView;;
@end
