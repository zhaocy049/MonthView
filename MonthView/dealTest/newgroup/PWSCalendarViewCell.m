//
//  PWSCalendarViewCell.m
//  PWSCalendar
//
//  Created by Sylar on 3/14/14.
//  Copyright (c) 2014 PWS. All rights reserved.
//
///////////////////////////////////////////////////////////////////////////
#import "PWSCalendarViewCell.h"

#import "PWSCalendarDayCell.h"
#import "PWSCalendarView.h"
///////////////////////////////////////////////////////////////////////////
extern NSString* PWSCalendarDayCellId;
const NSString* PWSCalendarViewCellId = @"PWSCalendarViewCellId";
///////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////
@implementation PWSCalendarViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor clearColor]];
        [self SetInitialValue];
    }
    return self;
}

- (void) SetInitialValue
{
    UICollectionViewFlowLayout *layout  = [UICollectionViewFlowLayout new];
    layout.minimumInteritemSpacing = 1;
    layout.minimumLineSpacing = 1;
    NSInteger with = [UIScreen mainScreen].bounds.size.width;
    layout.itemSize = CGSizeMake(with/7, 50);
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;

    
    UICollectionView* m_collection_view = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layout];
    [self.contentView addSubview:m_collection_view];
    
    [m_collection_view setBackgroundColor:[UIColor clearColor]];
    [m_collection_view setDelegate:self];
    [m_collection_view setDataSource:self];
    [m_collection_view setScrollEnabled:NO];
    
    [m_collection_view registerClass:[PWSCalendarDayCell class] forCellWithReuseIdentifier:PWSCalendarDayCellId.copy];
}

// delegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
  
    return 5;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PWSCalendarDayCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:PWSCalendarDayCellId.copy forIndexPath:indexPath];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
   }

- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
  
    return YES;
}


#pragma mark - UICollectionViewFlowLayoutDelegate
//
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    CGFloat itemWidth = floorf(CGRectGetWidth(m_collection_view.bounds) / 7);
//    
//    return CGSizeMake(itemWidth, itemWidth/2);
//}


@end
