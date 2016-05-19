//
//  ViewController.h
//  dealTest
//
//  Created by haishi on 15/9/22.
//  Copyright (c) 2015年 haishi. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, CalendarViewType)
{
    calendar_type_week = 1,
    calendar_type_month = 2,
};

@interface ViewController : UIViewController
{
    NSInteger  rowIndex;
    
    NSInteger intervalSpace;
}
@property (nonatomic, assign) CalendarViewType type;
@property (nonatomic, strong) NSArray *Array;

@end

