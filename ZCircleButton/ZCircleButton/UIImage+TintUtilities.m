//
//  UIImage+TintUtilities.m
//
//  Created by Ayal Spitz on 3/28/14.
//  Copyright (c) 2014 Localytics. All rights reserved.
//

#import "UIImage+TintUtilities.h"

@implementation UIImage (TintUtilities)

+ (UIImage *)imageNamed:(NSString *)imageName withTintColor:(UIColor *)tintColor{
    UIImage *image = [UIImage imageNamed:imageName];
    return [image tintWithColor:tintColor];
}

- (UIImage *)tintWithColor:(UIColor *)tintColor {
    UIGraphicsBeginImageContextWithOptions(self.size, NO, [[UIScreen mainScreen] scale]);
    CGRect drawRect = CGRectMake(0, 0, self.size.width, self.size.height);
    [self drawInRect:drawRect];
    [tintColor set];
    UIRectFillUsingBlendMode(drawRect, kCGBlendModeSourceAtop);
    UIImage *tintedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return tintedImage;
}

@end
