//
//  BottomCollectionViewCell.m
//  dealTest
//
//  Created by haishi on 16/1/11.
//  Copyright © 2016年 haishi. All rights reserved.
//

#import "BottomCollectionViewCell.h"
#import "ItemCell.h"
#import "PWSHelper.h"
#import "NSDate+Utilities.h"
@implementation BottomCollectionViewCell
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        
        m_calendar = [NSCalendar currentCalendar];

        _selectDate = [NSDate date];
        
        [self initView];
    }
    return self;
}


- (void) SetWithDate:(NSDate*)pDate ShowType:(enCalendarViewType)pCalendarType
{
    if (pCalendarType == en_calendar_type_month)
    {
        m_first_date = [self GetFirstDayOfMonth:pDate];
        
        _selectDate = pDate;
        
          NSRange rangeOfWeeks = [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitWeekOfMonth inUnit:NSCalendarUnitMonth forDate:_selectDate];
        if (rangeOfWeeks.length==4) {
          _layout.minimumLineSpacing = 30;
        }else if (rangeOfWeeks.length==5){
          _layout.minimumLineSpacing = 11;
        }else if (rangeOfWeeks.length==6){
          _layout.minimumLineSpacing = 0;
        }
    }
    else if (pCalendarType == en_calendar_type_week)
    {
        m_first_date = pDate;
    }
    
    self.type = pCalendarType;
}

- (void) setType:(enCalendarViewType)type
{
    _type = type;
    [_collectionView reloadData];
}

// reference
- (NSDate *)dateForCellAtIndexPath:(NSIndexPath *)indexPath
{
    NSDate *firstOfMonth = [self firstOfMonthForSection:indexPath.section];
    NSInteger ordinalityOfFirstDay = [m_calendar ordinalityOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitWeekOfMonth forDate:firstOfMonth];
    NSDateComponents *dateComponents = [NSDateComponents new];
    dateComponents.day = (1 - ordinalityOfFirstDay) + indexPath.item;
    
    return [m_calendar dateByAddingComponents:dateComponents toDate:firstOfMonth options:0];
}

- (NSDate *)firstOfMonthForSection:(NSInteger)section
{
    NSDateComponents *offset = [NSDateComponents new];
    offset.month = section;
    
    NSDate* rt = [m_calendar dateByAddingComponents:offset toDate:m_first_date options:0];
    return rt;
}

- (NSDate*) GetFirstDayOfMonth:(NSDate*)pDate
{
    NSDateComponents *components = [m_calendar components:NSCalendarUnitMonth|NSCalendarUnitYear fromDate:pDate];
    NSDate* rt = [m_calendar dateFromComponents:components];
    return rt;
}

- (void)initView
{
    _layout  = [UICollectionViewFlowLayout new];
    _layout.minimumInteritemSpacing = 0;
    _layout.minimumLineSpacing = 0;
    _layout.itemSize = CGSizeMake(self.frame.size.width/7, self.frame.size.width/7);
    _layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);

  
    _collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:_layout];
        
   
    [_collectionView registerClass:[ItemCell class] forCellWithReuseIdentifier:@"ItemCell"];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [_collectionView setScrollEnabled:NO];
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.userInteractionEnabled = YES;
    [self.contentView addSubview:_collectionView];
    
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
     NSInteger rt = 0;
    
    if (self.type == en_calendar_type_month)
    {
        NSRange rangeOfWeeks = [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitWeekOfMonth inUnit:NSCalendarUnitMonth forDate:m_first_date];
        
        rt = (rangeOfWeeks.length * 7);
    }
    else if (self.type == en_calendar_type_week)
    {
  
        rt = 7;
    }
    
    return rt;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{


    if (self.type == en_calendar_type_month) {
        if ([self.month_delegate respondsToSelector:@selector(ZCYCalendar:didSelecteDate:)])
        {
            NSDate* date = [self dateForCellAtIndexPath:indexPath];
            NSString * indexItem = [NSString stringWithFormat:@"%ld",(long)indexPath.item];
            NSArray * array = [NSArray arrayWithObjects:date,indexItem, nil];
            
            [self.month_delegate performSelector:@selector(ZCYCalendar:didSelecteDate:) withObject:nil withObject:array];
        }

    }else if (self.type == en_calendar_type_week){
    
        if ([self.week_delegate respondsToSelector:@selector(ZCYWeekCalendar:didSelecteDate:)])
        {
            NSDate* date = [self dateForCellAtIndexPath:indexPath];
            
            [self.week_delegate performSelector:@selector(ZCYWeekCalendar:didSelecteDate:) withObject:nil withObject:date];
        }
    }
 }
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
     NSDate* cell_date = [self dateForCellAtIndexPath:indexPath];
    

    NSDateComponents *cellDateComponents = [m_calendar components:NSCalendarUnitDay|NSCalendarUnitMonth fromDate:cell_date];
    NSDateComponents *firstOfMonthsComponents = [m_calendar components:NSCalendarUnitMonth fromDate:m_first_date];
    
    ItemCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ItemCell" forIndexPath:indexPath];

    
    if (self.type == en_calendar_type_month)
    {
        
        [cell SetDate:cell_date withSelect:_selectDate];
        
        if (cellDateComponents.month != firstOfMonthsComponents.month)
        {
            [cell setBackgroundColor:[UIColor clearColor]];
            cell.titleLabel.text = @"";
            cell.subTitleLabel.text = @"";
            cell.userInteractionEnabled = NO;
        }else{
            cell.userInteractionEnabled = YES;
        }

    }
    else if (self.type == en_calendar_type_week)
    {
       
        [cell SetDate:cell_date withSelect:m_first_date];
     
    }
  
    return cell;
}

@end
