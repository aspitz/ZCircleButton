//
//  ZCircleButton.m
//
//  Created by Ayal Spitz on 3/20/14.
//  Copyright (c) 2014 Localytics. All rights reserved.
//

#import "ZCircleButton.h"
#import "ZCircleView.h"
#import "UIImage+TintUtilities.h"

#import <libextobjc/extobjc.h>

@interface ZCircleButton ()
@property (nonatomic, strong) ZCircleView *circleView;
@end

@implementation ZCircleButton

#pragma mark - Object init methods

- (instancetype)init{
    self = [super initWithFrame:CGRectMake(0.0, 0.0, 60.0, 60.0)];
    if (self) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithLabel:(NSString *)label andImageNamed:(NSString *)imageName{
    self = [super initWithFrame:CGRectMake(0.0, 0.0, 60.0, 80.0)];
    if (self) {
        [self setup];
        self.label.text = label;
        self.imageView.image = [UIImage imageNamed:imageName withTintColor:self.buttonTintColor];
    }
    return self;
}

- (instancetype)copyWithZone:(NSZone *)zone{
    ZCircleButton *circleButton = [[[self class] alloc]init];
    
    circleButton.buttonTintColor = [self.buttonTintColor copyWithZone:zone];
    circleButton.disabled = self.disabled;
    circleButton.imageView.image = [self.imageView.image copy];
    circleButton.label.text = [self.label.text copyWithZone:zone];
    circleButton.onTap = self.onTap;
    circleButton.onLongPress = self.onLongPress;
    
    return circleButton;
}

+ (instancetype)buttonWithLabel:(NSString *)label andImageNamed:(NSString *)imageName{
    return [[[self class] alloc]initWithLabel:label andImageNamed:imageName];
}

- (void)dealloc{
    [self removeObserver:self forKeyPath:@keypath(self.label.text)];
}

#pragma mark - Setup methods

- (void)setup{
    self.buttonTintColor = [UIColor whiteColor];
    
    self.circleView = [[ZCircleView alloc]init];
    self.circleView.color = self.buttonTintColor;
    self.circleView.buttonBackgroundColor = [UIColor whiteColor];
    [self addSubview:self.circleView];

    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapped:)];
    tapGesture.numberOfTapsRequired = 1;
    tapGesture.numberOfTouchesRequired = 1;
    [self.circleView addGestureRecognizer:tapGesture];

    UILongPressGestureRecognizer *longPressGesture = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPress:)];
    [self.circleView addGestureRecognizer:longPressGesture];
    
    _label = [[UILabel alloc]init];
    self.label.textAlignment = NSTextAlignmentCenter;
    self.label.font = [UIFont systemFontOfSize:10];
    self.label.textColor = self.buttonTintColor;
    [self addSubview:self.label];
    
    [self addObserver:self forKeyPath:@keypath(self.label.text) options:NSKeyValueObservingOptionNew context:NULL];

    _imageView = [[UIImageView alloc]init];
    self.imageView.contentMode = UIViewContentModeCenter;
    self.imageView.userInteractionEnabled = NO;
    [self addSubview:self.imageView];
    
    //[self bringSubviewToFront:self.circleView];
}

#pragma mark - 
- (void)layoutSubviews{
    self.circleView.frame = CGRectMake(0.0, 0.0, 60.0, 60.0);
    if (self.label.text.length != 0){
        self.label.frame = CGRectMake(0.0, 60.0, 60.0, 20.0);
    }
    self.imageView.frame = CGRectMake(0.0, 0.0, 60.0, 60.0);
}

#pragma mark - Tint color methods

- (void)setButtonTintColor:(UIColor *)buttonTintColor{
    _buttonTintColor = buttonTintColor;
    
    self.label.textColor = buttonTintColor;
    if (self.imageView.image){
        self.imageView.image = [self.imageView.image tintWithColor:buttonTintColor];
    }
    self.circleView.color = buttonTintColor;

    [self setNeedsDisplay];
}

#pragma mark - Gesture Recognizer methods

- (IBAction)tapped:(UITapGestureRecognizer *)gestureRecognizer{
    if (self.onTap){
        self.onTap(self);
    }
}

- (IBAction)longPress:(UITapGestureRecognizer *)gestureRecognizer{
    if (gestureRecognizer.state == UIGestureRecognizerStateBegan){
        if (self.onLongPress){
            self.onLongPress(self);
        }
    }
}

#pragma mark -

- (void)setDisabled:(BOOL)disabled{
    _disabled = disabled;
    self.userInteractionEnabled = !disabled;
    if (disabled){
        self.alpha = 0.5;
    } else {
        self.alpha = 1.0;
    }
}

#pragma mark - KVO methods
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    
    if ((self.label.text.length != 0) && (self.frame.size.height == 60.0)){
        CGRect frame = self.frame;
        frame.size.height = 80.0;
        self.frame = frame;
    }
}

@end
