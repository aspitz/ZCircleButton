//
//  UIImage+TintUtilities.h
//  ParkingMeter
//
//  Created by Ayal Spitz on 3/28/14.
//  Copyright (c) 2014 Localytics. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (TintUtilities)

+ (UIImage *)imageNamed:(NSString *)imageName withTintColor:(UIColor *)tintColor;
- (UIImage *)tintWithColor:(UIColor *)tintColor;

@end
