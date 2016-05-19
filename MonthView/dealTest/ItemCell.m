//
//  ItemCell.m
//  dealTest
//
//  Created by haishi on 16/1/11.
//  Copyright © 2016年 haishi. All rights reserved.
//

#import "ItemCell.h"
#import "PWSHelper.h"
#import "NSDate+Utilities.h"
#import "LunarCalendar.h"
@implementation ItemCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height/2)];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = [UIFont systemFontOfSize:15.0];
        [self.contentView addSubview:self.titleLabel];
        
        self.subTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, frame.size.height/2, frame.size.width, frame.size.height/2)];
        self.subTitleLabel.backgroundColor = [UIColor clearColor];
        self.subTitleLabel.textAlignment = NSTextAlignmentCenter;
        self.subTitleLabel.textColor = [UIColor grayColor];
        self.subTitleLabel.font = [UIFont systemFontOfSize:10.0];
        [self.contentView addSubview:self.subTitleLabel];
    } 
    return self;
}
- (void) setSelected:(BOOL)selected
{
    [super setSelected:selected];
    if (selected)
    {
        self.subTitleLabel.textColor = [UIColor whiteColor];
        self.titleLabel.textColor    = [UIColor whiteColor];
        self.layer.cornerRadius = self.frame.size.width/2;
        self.layer.masksToBounds = YES;
        [self setBackgroundColor:[UIColor orangeColor]];
     
    } else
    {
        self.subTitleLabel.textColor = [UIColor grayColor];
        self.titleLabel.textColor    = [UIColor blackColor];
        [self setBackgroundColor:[UIColor clearColor]];
    }
}

- (void) SetDate:(NSDate*)_date withSelect:(NSDate *)selectDate
{
    
    if ([PWSHelper CheckSameDay:_date AnotherDate:selectDate])
    {
        self.layer.cornerRadius = self.frame.size.width/2;
        self.layer.masksToBounds = YES;
        [self setBackgroundColor:[UIColor orangeColor]];
        self.subTitleLabel.textColor = [UIColor whiteColor];
        self.titleLabel.textColor    = [UIColor whiteColor];
    }
    
    [_titleLabel setText:[NSString stringWithFormat:@"%ld",(long)_date.day]];
    [_subTitleLabel setText:_date.ChineseDay];
}
@end
