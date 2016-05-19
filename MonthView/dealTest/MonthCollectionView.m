//
//  MonthCollectionView.m
//  dealTest
//
//  Created by haishi on 16/1/11.
//  Copyright © 2016年 haishi. All rights reserved.
//

#import "MonthCollectionView.h"
#import "BottomCollectionViewCell.h"
#import "PWSHelper.h"

const int   PWSCalendarViewNumber = 1000;

@implementation MonthCollectionView
- (id) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
    
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
    layout.itemSize = CGSizeMake(width, 6*width/7);

    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    
    
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, width, 6*width/7) collectionViewLayout:layout];
    [_collectionView registerClass:[BottomCollectionViewCell class] forCellWithReuseIdentifier:@"bottomCell"];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.pagingEnabled = YES;
    _collectionView.clipsToBounds = NO;
    _collectionView.showsHorizontalScrollIndicator = YES;
    [self addSubview:_collectionView];
    
    
    m_current_page = PWSCalendarViewNumber/2;
    NSIndexPath* mid_index = [NSIndexPath indexPathForRow:m_current_page inSection:0];
    [_collectionView scrollToItemAtIndexPath:mid_index atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
    
    m_current_date = [NSDate date];

}

- (void)setMonth_date:(NSDate *)month_date
{
    m_current_date = month_date;
    [_collectionView reloadData];
}

- (void) ZCYCalendar:(MonthCollectionView*)_calendar didSelecteDate:(NSArray *)array
{

    if ([self.delegate respondsToSelector:@selector(ZCYCalendar:didSelecteDate:)])
    {
        [self.delegate ZCYCalendar:self didSelecteDate:array];
    }
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    return PWSCalendarViewNumber;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    BottomCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"bottomCell" forIndexPath:indexPath];
    NSDate *cell_date = m_current_date;
    
    if (indexPath.row != m_current_page)
    {
       
        if (indexPath.row > m_current_page)
        {
            cell_date = [PWSHelper GetNextMonth:m_current_date];
        }
        else
        {
            cell_date = [PWSHelper GetPreviousMonth:m_current_date];
        }
       
    }

    [cell setMonth_delegate:self];
    [cell SetWithDate:cell_date ShowType:en_calendar_type_month];
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
    
    if (m_current_page != index)
    {
       
            if (m_current_page > index)
            {
                m_current_date = [PWSHelper GetPreviousMonth:m_current_date];
            }
            else if (m_current_page < index)
            {
                m_current_date = [PWSHelper GetNextMonth:m_current_date];
            }
            m_current_page = index;
     
    }
    /*
    *刷新日期label
     */
     
    if ([self.delegate respondsToSelector:@selector(ZCYCalendar:didSelecteDate:)])
    {
        NSArray * array = [NSArray arrayWithObjects:m_current_date,[NSString stringWithFormat:@"%ld",indexPath.item], nil];
        
        [self.delegate performSelector:@selector(ZCYCalendar:didSelecteDate:) withObject:nil withObject:array];
    }
    
}


@end
