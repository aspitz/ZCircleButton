//
//  ZSelectableCircleButton.m
//
//  Created by Ayal Spitz on 3/24/14.
//  Copyright (c) 2014 Localytics. All rights reserved.
//

#import "ZSelectableCircleButton.h"
#import "UIImage+TintUtilities.h"

@implementation ZSelectableCircleButton

- (instancetype)copyWithZone:(NSZone *)zone{
    ZSelectableCircleButton *selectableCircleButton = [[[self class]alloc]init];
    
    selectableCircleButton.buttonTintColor = [self.buttonTintColor copyWithZone:zone];
    selectableCircleButton.disabled = self.disabled;
    selectableCircleButton.imageView.image = [self.imageView.image copy];
    selectableCircleButton.label.text = [self.label.text copyWithZone:zone];
    selectableCircleButton.onTap = self.onTap;
    selectableCircleButton.onLongPress = self.onLongPress;

    selectableCircleButton.imageView.hidden = self.imageView.hidden;

    selectableCircleButton.selectedImageView.image = [self.selectedImageView.image copy];
    selectableCircleButton.selectedImageView.hidden = self.selectedImageView.hidden;
    
    selectableCircleButton.selected = self.isSelected;
    selectableCircleButton.toggleSelected = self.toggleSelected;
    
    return selectableCircleButton;
}

#pragma mark - Setup methods

- (void)setup{
    [super setup];
    
    self.toggleSelected = YES;
    
    _selectedImageView = [[UIImageView alloc]init];
    self.selectedImageView.contentMode = UIViewContentModeCenter;
    self.selectedImageView.hidden = YES;
    self.selectedImageView.userInteractionEnabled = NO;
    [self addSubview:self.selectedImageView];
}

#pragma mark - 

- (void)layoutSubviews{
    [super layoutSubviews];
    self.selectedImageView.frame = self.imageView.frame;
}

- (void)setSelected:(BOOL)selected{
    _selected = selected;
    self.imageView.hidden = selected;
    self.selectedImageView.hidden = !selected;
    [self setNeedsDisplay];
}

- (void)setSelectedImageName:(NSString *)imageName{
    self.selectedImageView.image = [UIImage imageNamed:imageName withTintColor:[UIColor whiteColor]];
}

- (IBAction)tapped:(UITapGestureRecognizer *)gestureRecognizer{
    if (self.toggleSelected){
        self.selected = !self.isSelected;
    }
    
    if (self.onTap){
        self.onTap(self);
    }
}

@end
