//
//  ZCircleButtonMenu.m
//  ParkingMeter
//
//  Created by Ayal Spitz on 4/3/14.
//  Copyright (c) 2014 Localytics. All rights reserved.
//

#import "ZCircleButtonMenu.h"

@interface ZCircleButtonMenu ()
@property (nonatomic, strong) NSMutableArray *menuItems;
@property (nonatomic, strong) UIView *backgroundView;
@end

@implementation ZCircleButtonMenu

#pragma mark - Object init methods

+ (instancetype)buttonMenuWithLabel:(NSString *)label andImageNamed:(NSString *)imageName{
    return [[[self class] alloc]initWithLabel:label andImageNamed:imageName];
}

#pragma mark - Menu item methods

- (NSMutableArray *)menuItems{
    if (!_menuItems){
        _menuItems = [NSMutableArray array];
    }
    
    return _menuItems;
}

- (ZCircleButton *)addbuttonWithLabel:(NSString *)label andImageNamed:(NSString *)imageName{
    ZCircleButton *button = [ZCircleButton buttonWithLabel:label andImageNamed:imageName];
    [self.menuItems addObject:button];
    return button;
}

#pragma mark - Gesture Recognizer methods

- (IBAction)longPress:(UITapGestureRecognizer *)gestureRecognizer{
    BOOL shouldShowMenu = YES;
    if (self.shouldShowMenu){
        shouldShowMenu = self.shouldShowMenu(nil);
    }
    if ((gestureRecognizer.state == UIGestureRecognizerStateBegan) && (self.menuItems.count != 0) && shouldShowMenu){
        id<UIApplicationDelegate> appDelegate = (id<UIApplicationDelegate>)[[UIApplication sharedApplication] delegate];
        CGRect bounds = [UIScreen mainScreen].bounds;
        self.backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, bounds.size.width, bounds.size.height)];
        self.backgroundView.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.5];
        [[appDelegate window] addSubview:self.backgroundView];
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideMenu:)];
        [self.backgroundView addGestureRecognizer:tapGesture];
        
        [self.menuItems enumerateObjectsUsingBlock:^(ZCircleButton *button, NSUInteger idx, BOOL *stop) {
            button.center = [[self superview]convertPoint:self.center toView:self.backgroundView];
            button.alpha = 0.0;
            button.label.textColor = [UIColor whiteColor];
            [self.backgroundView addSubview:button];
            [self.backgroundView sendSubviewToBack:button];
            
            ActionBlock originalTapAction = button.onTap;
            button.onTap = ^(id sender){
                [self hideMenuAndAct:originalTapAction];
            };
        }];
        
        [UIView animateWithDuration:0.5 animations:^{
            [self.menuItems enumerateObjectsUsingBlock:^(ZCircleButton *button, NSUInteger idx, BOOL *stop) {
                button.center = CGPointMake(button.center.x, button.center.y - (80 * (idx + 1)));
                button.alpha = 1.0;
            }];
        }];
        
        ZCircleButton *buttonCopy = [self copy];
        buttonCopy.center = [[self superview]convertPoint:self.center toView:self.backgroundView];
        buttonCopy.label.textColor = [UIColor whiteColor];
        buttonCopy.onLongPress = nil;
        
        [self.backgroundView addSubview:buttonCopy];
        ActionBlock originalTapAction = buttonCopy.onTap;
        buttonCopy.onTap = ^(id sender){
            [self hideMenuAndAct:originalTapAction];
        };
    }
}

- (IBAction)hideMenu:(id)sender{
    [self hideMenuAndAct:nil];
}

- (void)hideMenuAndAct:(ActionBlock)actionBlock{
    [UIView animateWithDuration:0.5 animations:^{
        [self.menuItems enumerateObjectsUsingBlock:^(ZCircleButton *button, NSUInteger idx, BOOL *stop) {
            button.center = CGPointMake(button.center.x, button.center.y + (80 * (idx + 1)));
            button.alpha = 1.0;
        }];
    } completion:^(BOOL finished) {
        [self.backgroundView removeFromSuperview];
        self.backgroundView = nil;
        
        if (actionBlock){
            actionBlock(self);
        }
    }];
}

@end
