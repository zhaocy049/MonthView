//
//  RYTDateAndTimeView.m
//  ControlAdditions
//
//  Created by liulei on 13-6-25.
//
//

#import "RYTDateAndTimeView.h"

@implementation RYTDateAndTimeView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setBackgroundColor:[UIColor grayColor]];
       
        year = [[NSMutableArray alloc] init];
        int y = 2000;
        for (int i = 0; i <= 50; i ++) {
            NSString *yStr = [NSString stringWithFormat:@"%d",y];
            [year addObject:yStr];
            y ++;
        }
        
        month = [[NSArray alloc]initWithObjects:@"01",@"02",@"03",@"04",@"05",@"06",@"07",@"08",@"09",@"10",@"11",@"12", nil];
        
        day = [[NSMutableArray alloc] init];
        int d = 01;
        for (int i = 0; i < 31; i ++) {
            NSString *dayStr = [NSString stringWithFormat:@"%d",d];
            if (i < 9) {
                dayStr = [NSString stringWithFormat:@"0%d",d];
            }
            [day addObject:dayStr];
            d ++;
        }
        
        hour = [[NSArray alloc]initWithObjects:@"00",@"01",@"02",@"03",@"04",@"05",@"06",@"07",@"08",@"09",@"10",@"11",@"12",@"13",@"14",@"15",@"16",@"17",@"18",@"19",@"20",@"21",@"22",@"23", nil];
        
        minute = [[NSArray alloc]initWithObjects:@"00",@"01",@"02",@"03",@"04",@"05",@"06",@"07",@"08",@"09",@"10",@"11",@"12",@"13",@"14",@"15",@"16",@"17",@"18",@"19",@"20",@"21",@"22",@"23",@"24",@"25",@"26",@"27",@"28",@"29",@"30",@"31",@"32",@"33",@"34",@"35",@"36",@"37",@"38",@"39",@"40",@"41",@"42",@"43",@"44",@"45",@"46",@"47",@"48", @"49",@"50",@"51",@"52",@"53",@"54",@"55",@"56",@"57",@"58",@"59",nil];
        
//        miao = [[NSArray alloc]initWithObjects:@"00",@"01",@"02",@"03",@"04",@"05",@"06",@"07",@"08",@"09",@"10",@"11",@"12",@"13",@"14",@"15",@"16",@"17",@"18",@"19",@"20",@"21",@"22",@"23",@"24",@"25",@"26",@"27",@"28",@"29",@"30",@"31",@"32",@"33",@"34",@"35",@"36",@"37",@"38",@"39",@"40",@"41",@"42",@"43",@"44",@"45",@"46",@"47",@"48", @"49",@"50",@"51",@"52",@"53",@"54",@"55",@"56",@"57",@"58",@"59",nil];
        
        picker = [[UIPickerView alloc]initWithFrame:CGRectMake(0, self.frame.size.height-216, 0, 0)];
        picker.dataSource = self;
        picker.delegate = self;
        picker.showsSelectionIndicator = YES;
        [self addSubview:picker];
        
        
        CFGregorianDate today=CFAbsoluteTimeGetGregorianDate(CFAbsoluteTimeGetCurrent(), CFTimeZoneCopyDefault());
        [picker selectRow:today.year - 2000 inComponent:0 animated:NO];
        [picker selectRow:today.month-1 inComponent:1 animated:NO];
        [picker selectRow:today.day-1 inComponent:2 animated:NO];
        [picker selectRow:today.hour inComponent:3 animated:NO];
        [picker selectRow:today.minute inComponent:4 animated:NO];
        [picker selectRow:today.second inComponent:5 animated:NO];
        
        UIImageView *bar = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, [UIScreen mainScreen].bounds.size.width, 45)];
        
        UIButton *trueBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        trueBtn.contentMode = UIViewContentModeScaleAspectFit;
        trueBtn.frame = CGRectMake(self.frame.size.width - 50, 0.0, 50, 45);
        [trueBtn addTarget:self action:@selector(sureBtnTouchedDate:) forControlEvents:UIControlEventTouchUpInside];
        
        UIButton *falseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        falseBtn.contentMode = UIViewContentModeScaleAspectFit;
        falseBtn.frame = CGRectMake(0.0, 0.0, 50, 45);
        [falseBtn addTarget:self action:@selector(cancelBtnClick) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:bar];
        [self addSubview:falseBtn];
        [self addSubview:trueBtn];
    }
    return self;
}
-(void)cancelBtnClick
{

}
-(void)sureBtnTouchedDate:(id)sender {
    
        NSString *y = [year objectAtIndex:[picker selectedRowInComponent:0]];
        NSString *mon = [month objectAtIndex:[picker selectedRowInComponent:1]];
        NSString *d = [day objectAtIndex:[picker selectedRowInComponent:2]];
        NSString *h = [hour objectAtIndex:[picker selectedRowInComponent:3]];
        NSString *min = [minute objectAtIndex:[picker selectedRowInComponent:4]];
//        NSString *sec = [miao objectAtIndex:[picker selectedRowInComponent:5]];
    
        NSString *showStr = nil;
        NSString *valueStr = nil;
        
        if ([showFormat rangeOfString:@"-"].length > 0 || !showFormat) {
            showStr = [NSString stringWithFormat:@"%@-%@-%@ %@:%@",y,mon,d,h,min];
        }
        else if (showFormat != nil && [showFormat rangeOfString:@"-"].length <= 0) {
            showStr = [NSString stringWithFormat:@"%@%@%@ %@:%@",y,mon,d,h,min];
        }
        
        if ([valueFormat rangeOfString:@"-"].length > 0 || !valueFormat) {
            valueStr = [NSString stringWithFormat:@"%@-%@-%@ %@:%@",y,mon,d,h,min];
        } else if (valueFormat != nil && [valueFormat rangeOfString:@"-"].length <= 0) {
            valueStr = [NSString stringWithFormat:@"%@%@%@ %@:%@",y,mon,d,h,min];
        }
        
        NSLog(@"valueStr = %@  showStr = %@",valueStr,showStr);
 
}

- (void)openWithObject:(id)object{
    if (object == nil) {
        return;
    }
    
    self.dateInputObject = object;
}

#pragma mark -----
#pragma mark ----- 计算特殊月份

- (int)getDayCountOfaMonthWithYear:(int)yyear AndMonth:(int)mon{
	switch (mon) {
		case 1:
		case 3:
		case 5:
		case 7:
		case 8:
		case 10:
		case 12:
			return 31;
			
		case 2:
			if((yyear %4 == 0 && yyear%100 != 0) || (yyear%100 == 0 && yyear%400 ==0))
				return 29;
			else
				return 28;
            
		case 4:
		case 6:
		case 9:
		case 11:
			return 30;
		default:
			return 31;
	}
}

#pragma mark -----
#pragma mark ----- UIPickerViewDelegate

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 6;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {

    if (component == 0) {
        return [year count];
    } else if (component == 1) {
        return 12;
    } else if (component == 2) {
        int y = [[year objectAtIndex:[pickerView selectedRowInComponent:0]]intValue];
        int m = [[month objectAtIndex:[pickerView selectedRowInComponent:1]]intValue];
        return [self getDayCountOfaMonthWithYear:y AndMonth:m];
    } else if (component == 3) {
        return 24;
    }
    return 60;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (component == 0) {
        return [year objectAtIndex:row];
    } else if (component == 1) {
        return [month objectAtIndex:row];
    } else if (component == 2) {
        return [day objectAtIndex:row];
    } else if (component == 3) {
        return [hour objectAtIndex:row];
    } else if (component == 4) {
        return [minute objectAtIndex:row];
    }
    return nil;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    if (component == 0) {
        return 80;
    }
    return 45;
}

- (void)pickerView:(UIPickerView *)pickerView
      didSelectRow:(NSInteger)row
       inComponent:(NSInteger)component {
    if (component == 1 || component == 0) {
        
        [pickerView reloadComponent:2];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
