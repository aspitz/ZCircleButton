//
//  ZSelectableCircleButton.h
//  ParkingMeter
//
//  Created by Ayal Spitz on 3/24/14.
//  Copyright (c) 2014 Localytics. All rights reserved.
//

#import "ZCircleButton.h"

@interface ZSelectableCircleButton : ZCircleButton

@property (nonatomic, readonly) UIImageView *selectedImageView;
@property (nonatomic, assign, getter = isSelected) BOOL selected;
@property (nonatomic, assign) BOOL toggleSelected;

- (instancetype)copyWithZone:(NSZone *)zone;

- (void)setSelectedImageName:(NSString *)imageName;

@end
