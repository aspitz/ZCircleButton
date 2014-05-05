//
//  ZCircleButtonMenu.h
//
//  Created by Ayal Spitz on 4/3/14.
//  Copyright (c) 2014 Localytics. All rights reserved.
//

#import "ZSelectableCircleButton.h"

typedef BOOL (^ZCircleButtonBooleanActionBlock)(id sender);

@interface ZCircleButtonMenu : ZSelectableCircleButton

@property (nonatomic, copy) BOOL (^shouldShowMenu)(id sender);

+ (instancetype)buttonMenuWithLabel:(NSString *)label andImageNamed:(NSString *)imageName;

- (ZCircleButton *)addbuttonWithLabel:(NSString *)label andImageNamed:(NSString *)imageName;

@end
