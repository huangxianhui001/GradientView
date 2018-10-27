//
//  MJAGradientView.m
//  nvwang
//
//  Created by Alan on 2018/8/8.
//  Copyright © 2018年 mengjitv. All rights reserved.
//

#import "MJAGradientView.h"

#define HEXCOLOR(hexValue)                         [UIColor colorWithRed: ((CGFloat)((hexValue & 0xFF0000) >> 16)) / 255.0 green: ((CGFloat)((hexValue & 0xFF00) >> 8)) / 255.0 blue: ((CGFloat)(hexValue & 0xFF)) / 255.0 alpha: 1.0]

@interface MJAGradientView()
@property (nonatomic, strong) NSArray<UIColor *> *colors;
@property (nonatomic, strong) CAShapeLayer *shapeMaskLayer;
@property (nonatomic, strong) UILabel *titleLab;
@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation MJAGradientView

+ (Class)layerClass
{
    return [CAGradientLayer class];
    
}

- (CAGradientLayer *)gradientLayer
{
    return (CAGradientLayer *)self.layer;
}

#pragma mark - public method
+ (instancetype)gradientViewWithType:(MJAGradientType)type
{
    return [MJAGradientView gradientViewWithType:type direction:MJAGradientDirectLeftToRight];
}

+ (instancetype)gradientViewWithType:(MJAGradientType)type direction:(MJAGradientDirect)direction
{
    NSArray *colors = nil;
    switch (type) {
        case MJAGradientTypePurple:{
                colors = @[HEXCOLOR(0xb741fc),HEXCOLOR(0xfd75b8)];
            }
            break;
        case MJAGradientTypeYellow:{
            colors = @[HEXCOLOR(0xff9600),HEXCOLOR(0xff6040)];
        }break;
    }
    return [MJAGradientView gradientViewWithColors:colors direction:direction];
}

+ (instancetype)gradientViewWithColors:(NSArray<UIColor *> *)colors
{
    return [MJAGradientView gradientViewWithColors:colors direction:MJAGradientDirectLeftToRight];
}

+ (instancetype)gradientViewWithColors:(NSArray<UIColor *> *)colors direction:(MJAGradientDirect)direction
{
    MJAGradientView *view = [MJAGradientView new];
    view.colors = colors;
    view.direction = direction;
    return view;
}

-(void)addTitle:(NSString *)title font:(UIFont *)font color:(UIColor *)color
{
    if (!self.titleLab.superview) {
        [self addSubview:self.titleLab];
    }
    _imageView.hidden = YES;
    self.titleLab.text = title;
    self.titleLab.font = font;
    self.titleLab.textColor = color;
    [self.titleLab sizeToFit];
    [self setNeedsLayout];
}

- (void)addImage:(UIImage *)image
{
    [self addImage:image size:image.size];
}

- (void)addImage:(UIImage *)image size:(CGSize)size
{
    if (!self.imageView.superview) {
        [self addSubview:self.imageView];
    }
    _titleLab.hidden = YES;
    self.imageView.image = image;
    CGRect frame = self.imageView.frame;
    frame.size = size;
    self.imageView.frame = frame;
    [self setNeedsLayout];
}

- (void)layoutSubviews
{
    [super layoutSubviews];

    CGFloat width = CGRectGetWidth(self.frame);
    CGFloat height = CGRectGetHeight(self.frame);
    _titleLab.center = CGPointMake( width* 0.5, height * 0.5);
    _imageView.center = CGPointMake(width * 0.5, height * 0.5);
    if (self.cornerRadius > 0) {
        UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:self.cornerRadius];
        self.shapeMaskLayer.path = path.CGPath;
        self.layer.mask = self.shapeMaskLayer;
    }else{
        self.layer.mask = nil;
    }
    
    NSMutableArray *cgColor = [NSMutableArray array];
    switch (self.direction) {
        case MJAGradientDirectLeftToRight:
        case MJAGradientDirectTopToBottom:
        {
            for (UIColor *color in self.colors) {
                [cgColor addObject:(__bridge id)color.CGColor];
            }
        }break;
        case MJAGradientDirectRightToLeft:
        case MJAGradientDirectBottomToTop:{
            NSArray *reverseArray = self.colors.reverseObjectEnumerator.allObjects;
            for (UIColor *color in reverseArray) {
                [cgColor addObject:(__bridge id)color.CGColor];
            }
            
        } break;
    }
    
    self.gradientLayer.colors = cgColor;
    NSUInteger count = cgColor.count;
    NSMutableArray *locations = [NSMutableArray array];
    if (count > 1) {
        if (self.direction == MJAGradientDirectLeftToRight || self.direction == MJAGradientDirectTopToBottom) {
            CGFloat min = self.colorOffset;
            CGFloat by = (1.0 - self.colorOffset) / (count - 1);
            
            for (int i = 0; i < count; i++) {
                [locations addObject:@(i * by + min)];
            }
            
        }else{
            CGFloat min = 0.0;
            CGFloat by = (1.0 - self.colorOffset) / (count - 1);
            
            for (int i = 0; i < count; i++) {
                [locations addObject:@(i * by + min)];
            }
        }
    }
    else{
        [locations addObject:@(0.5)];
    }
    
    self.gradientLayer.locations = locations;
}

#pragma mark - set
-(void)setDirection:(MJAGradientDirect)direction
{
    _direction = direction;
    switch (_direction) {
        case MJAGradientDirectLeftToRight:
        case MJAGradientDirectRightToLeft:{
            self.gradientLayer.startPoint = CGPointZero;
            self.gradientLayer.endPoint = CGPointMake(1, 0);
        }break;
        default:
        {
            self.gradientLayer.startPoint = CGPointZero;
            self.gradientLayer.endPoint = CGPointMake(0, 1);
        }break;
    }
    [self setNeedsLayout];
}

- (void)setCornerRadius:(CGFloat)cornerRadius
{
    _cornerRadius = cornerRadius;
    [self setNeedsLayout];
}

- (void)setColorOffset:(CGFloat)colorOffset
{
    _colorOffset = MAX(0.0, MIN(colorOffset, 1.0));
    self.direction = self.direction;
}

#pragma mark - lazy

-(CAShapeLayer *)shapeMaskLayer
{
    if (!_shapeMaskLayer) {
        _shapeMaskLayer = [CAShapeLayer layer];
    }return _shapeMaskLayer;
}

- (UILabel *)titleLab
{
    if (!_titleLab) {
        _titleLab = [UILabel new];
    }return _titleLab;
}

- (UIImageView *)imageView
{
    if (!_imageView) {
        _imageView = [UIImageView new];
    }return _imageView;
}

@end
