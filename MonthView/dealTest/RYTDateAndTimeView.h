//
//  RYTDateAndTimeView.h
//  ControlAdditions
//
//  Created by liulei on 13-6-25.
//
//

#import <UIKit/UIKit.h>

@interface RYTDateAndTimeView : UIView <UIPickerViewDelegate, UIPickerViewDataSource>
{
    UIPickerView            *picker;
    
    NSMutableArray          *year;
    NSArray                 *month;
    NSMutableArray          *day;
    
    NSArray                 *hour;
    NSArray                 *minute;
    NSArray                 *miao;
    
    NSString                *showFormat;
    NSString                *valueFormat;
}

@property (nonatomic, retain) id    dateInputObject;

- (void)openWithObject:(id)object;

@end
