//
//  WeekCollectionView.m
//  dealTest
//
//  Created by haishi on 16/1/11.
//  Copyright © 2016年 haishi. All rights reserved.
//

#import "WeekCollectionView.h"

#import "BottomCollectionViewCell.h"
const int   ZCYCalendarViewNumber = 1000;
@implementation WeekCollectionView
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initView];
        
    }
    return self;
}
- (void)initView
{
    float width = self.frame.size.width;
    
    UICollectionViewFlowLayout *layout  = [UICollectionViewFlowLayout new];
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 0;
    layout.itemSize = CGSizeMake(width, width/7 + 11);
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    
    
    _collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layout];
    [_collectionView registerClass:[BottomCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.pagingEnabled = YES;
    _collectionView.clipsToBounds = NO;
    _collectionView.showsHorizontalScrollIndicator = YES;
    [self addSubview:_collectionView];
   
    w_current_page = ZCYCalendarViewNumber/2;
    NSIndexPath* mid_index = [NSIndexPath indexPathForRow:w_current_page inSection:0];
    [_collectionView scrollToItemAtIndexPath:mid_index atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
    
    _week_date = [NSDate date];
}
- (void)setWeek_date:(NSDate *)week_date
{
    _week_date = week_date;
    
    [_collectionView reloadData];
}

- (void) ZCYWeekCalendar:(WeekCollectionView*)_calendar didSelecteDate:(NSDate *)weekDate
{
    if ([self.delegate respondsToSelector:@selector(ZCYWeekCalendar:didSelecteDate:)])
    {
        [self.delegate ZCYWeekCalendar:self didSelecteDate:weekDate];
    }

}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return ZCYCalendarViewNumber;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    BottomCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    NSDate *cell_date = _week_date;
    
    NSDate * firsDay = [PWSHelper getFirstDayOfWeekByDate:_week_date];
    _fist_date = firsDay;
    
    if (indexPath.row != w_current_page)
    {
        
        if (indexPath.row > w_current_page)
        {
            cell_date = [PWSHelper getNextWeekWithDate:firsDay days:7];
        }
        else
        {
            cell_date = [PWSHelper getNextWeekWithDate:firsDay days:-7];
        }
        
    }
    
    [cell setWeek_delegate:self];
  
    [cell SetWithDate:cell_date ShowType:en_calendar_type_week];
    return cell;
}

-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    float cell_width = collectionView.frame.size.width;
    int pos_x = collectionView.contentOffset.x;
    int index = (pos_x+20)/cell_width;
    
    if (w_current_page != index)
    {
        
        if (w_current_page < index)
        {
            _fist_date = [PWSHelper getNextWeekWithDate:_fist_date days:7];
        }
        else if (w_current_page > index)
        {
            _fist_date = [PWSHelper getNextWeekWithDate:_fist_date days:-7];
        }
        w_current_page = index;
         _week_date = _fist_date;
        
        if ([self.delegate respondsToSelector:@selector(ZCYWeekCalendar:didSelecteDate:)])
        {
            [self.delegate ZCYWeekCalendar:self didSelecteDate:_week_date];
        }


    }

}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
