//
//  UIColor+HexString.h
//  dealTest
//
//  Created by haishi on 16/2/5.
//  Copyright © 2016年 haishi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (HexString)
+ (UIColor *) colorWithHexString: (NSString *) hexString;
+ (UIColor *) colorWithHexString: (NSString *) hexString andAlpha:(float)alpha;
@end
