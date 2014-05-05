//
//  ZCircleButton.h
//  ParkingMeter
//
//  Created by Ayal Spitz on 3/20/14.
//  Copyright (c) 2014 Localytics. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^ZCircleButtonActionBlock)(id sender);

@interface ZCircleButton : UIView

@property (nonatomic, strong) UIColor *buttonTintColor;

@property (nonatomic, assign) BOOL disabled;
@property (nonatomic, readonly) UIImageView *imageView;
@property (nonatomic, readonly) UILabel *label;

@property (nonatomic, copy) ZCircleButtonActionBlock onTap;
@property (nonatomic, copy) ZCircleButtonActionBlock onLongPress;

- (instancetype)initWithLabel:(NSString *)label andImageNamed:(NSString *)imageName;
+ (instancetype)buttonWithLabel:(NSString *)label andImageNamed:(NSString *)imageName;

- (instancetype)copyWithZone:(NSZone *)zone;

- (void)setup;

@end
