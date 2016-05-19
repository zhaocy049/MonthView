//
//  DealCollectionview.h
//  dealTest
//
//  Created by haishi on 15/9/22.
//  Copyright (c) 2015年 haishi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DealCollectionview : UIView<UICollectionViewDataSource, UICollectionViewDelegate>
@property (nonatomic, strong) UICollectionView *collectionView;

@end
