//
//  ItemCell.h
//  dealTest
//
//  Created by haishi on 16/1/11.
//  Copyright © 2016年 haishi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PWSHelper.h"
#import "LunarSolarConverter.h"
@interface ItemCell : UICollectionViewCell
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *subTitleLabel;

- (void) SetDate:(NSDate*)_date withSelect:(NSDate *)selectDate;
@end
