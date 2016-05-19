//
//  WeekCollectionView.h
//  dealTest
//
//  Created by haishi on 16/1/11.
//  Copyright © 2016年 haishi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PWSHelper.h"
@class WeekCollectionView;
@protocol ZCYWeekCalendarDelegate <NSObject>

@optional
- (void) ZCYWeekCalendar:(WeekCollectionView*)_calendar didSelecteDate:(NSDate *)weekDate;

@end
@interface WeekCollectionView : UIView<UICollectionViewDataSource,UICollectionViewDelegate,ZCYWeekCalendarDelegate>
{
    UICollectionView* _collectionView ;
    int                w_current_page;
    
}
@property (nonatomic, assign) id<ZCYWeekCalendarDelegate> delegate;
@property (nonatomic, strong) NSArray *weekArray;
@property (nonatomic, assign) NSInteger selectIndex;
@property (nonatomic, strong) NSDate  *week_date;
@property (nonatomic, strong) NSDate  *fist_date;
@end
