//
//  ZCircleButton.h
//  ParkingMeter
//
//  Created by Ayal Spitz on 3/20/14.
//  Copyright (c) 2014 Localytics. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppConstants.h"

@interface ZCircleButton : UIView

@property (nonatomic, strong) UIColor *buttonTintColor;

@property (nonatomic, assign) BOOL disabled;
@property (nonatomic, readonly) UIImageView *imageView;
@property (nonatomic, readonly) UILabel *label;

@property (nonatomic, copy) ActionBlock onTap;
@property (nonatomic, copy) ActionBlock onLongPress;

- (instancetype)initWithLabel:(NSString *)label andImageNamed:(NSString *)imageName;
+ (instancetype)buttonWithLabel:(NSString *)label andImageNamed:(NSString *)imageName;

- (instancetype)copyWithZone:(NSZone *)zone;

- (void)setup;

@end
