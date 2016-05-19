//
//  LunarSolarConverter.h
//  test
//
//  Created by haishi on 16/1/29.
//  Copyright © 2016年 haishi. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Lunar : NSObject
/**
 *是否闰月
 */
@property(assign) NSInteger isleap;
/**
 *农历 日
 */
@property(assign) NSInteger lunarDay;
/**
 *农历 月
 */
@property(assign) NSInteger lunarMonth;
/**
 *农历 年
 */
@property(assign) NSInteger lunarYear;

@end

@interface Solar : NSObject
/**
 * 分
 */
@property(assign) NSInteger solarMinute;
/**
 * 时
 */
@property(assign) NSInteger solarHour;
/**
 *公历 日
 */
@property(assign) NSInteger solarDay;
/**
 *公历 月
 */
@property(assign) NSInteger solarMonth;
/**
 *公历 年
 */
@property(assign) NSInteger solarYear;

@end

@interface LunarSolarConverter : NSObject

/**
 *农历转公历
 */
+ (Solar *)lunarToSolar:(Lunar *)lunar;

/**
 *公历转农历
 */
+ (Lunar *)solarToLunar:(Solar *)solar;
@end

