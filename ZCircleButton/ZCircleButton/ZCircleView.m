//
//  ZCircleView.m
//
//  Created by Ayal Spitz on 4/2/14.
//  Copyright (c) 2014 Localytics. All rights reserved.
//

#import "ZCircleView.h"

@implementation ZCircleView

#pragma mark - Object init methods

- (instancetype)init{
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setup];
    }
    return self;
}

#pragma mark - Setup methods

- (void)setup{
    self.backgroundColor = [UIColor clearColor];
    
    self.color = [UIColor darkGrayColor];
    self.buttonBackgroundColor = [UIColor clearColor];
}

#pragma mark - 

- (void)drawRect:(CGRect)rect{
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGRect ellipseRect = CGRectInset(rect, 1.0, 1.0);

    [self.buttonBackgroundColor setFill];
    CGContextFillEllipseInRect(ctx, ellipseRect);

    [self.color setStroke];
    CGContextAddEllipseInRect(ctx, ellipseRect);
    CGContextStrokePath(ctx);
}

@end
