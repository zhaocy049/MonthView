//
//  DealCollectionview.m
//  dealTest
//
//  Created by haishi on 15/9/22.
//  Copyright (c) 2015年 haishi. All rights reserved.
//

#import "DealCollectionview.h"

#import "UICollectionViewLeftAlignedLayout.h"

#import "CollectionViewCell.h"

static NSString * const kCellIdentifier  = @"CellIdentifier";


static float const kCollectionViewCellsHorizonMargin          = 12;
static float const kCollectionViewCellsHeightMargin           = 30;

static float const kCollectionViewToLeftMargin                = 16;
static float const kCollectionViewToTopMargin                 = 12;
static float const kCollectionViewToRightMargin               = 16;
static float const kCollectionViewToBottomtMargin             = 12;

static float const kCellBtnCenterToBorderMargin               = 20;
@implementation DealCollectionview

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpCollectionView];
    }
    return self;
}

- (id)initWithCoder: (NSCoder *)aDecoder {
    self = [super initWithCoder: aDecoder];
    if (self) {
       [self setUpCollectionView];
    }
    return self;
}

- (void)setUpCollectionView {
   
    UICollectionViewLeftAlignedLayout *layout = [[UICollectionViewLeftAlignedLayout alloc] init];
   UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 375, 200) collectionViewLayout:layout];
    collectionView.dataSource = self;
    collectionView.delegate = self;
    collectionView.backgroundColor = [UIColor clearColor];
    [collectionView registerClass:[CollectionViewCell class]
            forCellWithReuseIdentifier:kCellIdentifier];
    collectionView.allowsMultipleSelection = YES;
    collectionView.showsHorizontalScrollIndicator = NO;
    collectionView.showsVerticalScrollIndicator = NO;
    collectionView.scrollsToTop = NO;
    collectionView.scrollEnabled = NO;
    [self addSubview:collectionView];
    self.collectionView = collectionView;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section
{
    
    return 3;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CollectionViewCell *cell =
    (CollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:kCellIdentifier
                                                                    forIndexPath:indexPath];
    
    if (indexPath.row == 0) {
         cell.textLabel.text = @"集团qqqqqqqqqq1111133333dadaasfewfawdaqdq";
    }else if (indexPath.row ==1){
        cell.textLabel.text = @"重复qqqqqq";
    }else if (indexPath.row ==2){
        cell.textLabel.text = @"重要";
    }
   
    return cell;
}


- (float)collectionCellWidthText:(NSString *)text content:(NSDictionary *)content{
    float cellWidth;
    CGSize size = [text sizeWithAttributes:
                   @{NSFontAttributeName:
                         [UIFont systemFontOfSize:13]}];

    cellWidth = ceilf(size.width) + kCellBtnCenterToBorderMargin * 2;
    
    float limitWidth = (CGRectGetWidth(self.collectionView.frame) - kCollectionViewToLeftMargin - kCollectionViewToRightMargin);
    
    if (cellWidth >= limitWidth) {
        cellWidth = limitWidth;
    }
    
    return cellWidth;
}

#pragma mark - 🔌 UICollectionViewDelegateLeftAlignedLayout Method

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * text;
    if (indexPath.item == 0) {
       text = @"集团qqqqqqqqqq1111133333dsfrewqwedqw";
    }else if (indexPath.item ==1){
        text = @"重复qqqqqq";
    }else if (indexPath.item ==2){
        text = @"重要";
    }
    float cellWidth = [self collectionCellWidthText:text content:nil];
    if (indexPath.item==0 || indexPath.item==1) {
        
    }
    return CGSizeMake(cellWidth, kCollectionViewCellsHeightMargin);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView
                   layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return kCollectionViewCellsHorizonMargin;
}


- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView
                        layout:(UICollectionViewLayout *)collectionViewLayout
        insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(kCollectionViewToTopMargin, kCollectionViewToLeftMargin, kCollectionViewToBottomtMargin, kCollectionViewToRightMargin);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
