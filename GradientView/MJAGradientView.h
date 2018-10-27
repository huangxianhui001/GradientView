//
//  MJAGradientView.h
//  nvwang
//
//  Created by Alan on 2018/8/8.
//  Copyright © 2018年 mengjitv. All rights reserved.
//

#import <UIKit/UIKit.h>


/**
 默认渐变颜色类型

 - MJAGradientTypePurple: 紫色到粉红色过渡
 - MJAGradientTypeYellow: 浅橘色到橘色过渡
 */
typedef NS_ENUM(NSUInteger, MJAGradientType) {
    MJAGradientTypePurple,
    MJAGradientTypeYellow,
};

/**
 渐变方向
 
 - MJAGradientDirectLeftToRight: 从左到右
 - MJAGradientDirectRightToLeft: 从右到左
 - MJAGradientDirectTopToBottom: 从上到下
 - MJAGradientDirectBottomToTop: 从下到上
 */
typedef NS_ENUM(NSUInteger, MJAGradientDirect) {
    MJAGradientDirectLeftToRight,
    MJAGradientDirectRightToLeft,
    MJAGradientDirectTopToBottom,
    MJAGradientDirectBottomToTop,
};


/**
 针对 CAGradientLayer的简易封装的 view, 目前只支持水平和垂直方向的渐变,
 */
@interface MJAGradientView : UIView

/**
 渐变颜色方向,默认 MJAGradientDirectLeftToRight
 */
@property (nonatomic, assign) MJAGradientDirect direction;

/**
 圆角,默认 0
 */
@property (nonatomic, assign) CGFloat cornerRadius;

/**
 颜色偏移,0~1之间,在渐变方向上,从0到 coloroffset 个单位宽度的地方将会填充颜色数组中第一个的颜色,默认 0
 */
@property (nonatomic, assign) CGFloat colorOffset;

/**
 根据内置类型返回渐变 view 对象

 @param type 内置类型
 @return 渐变 view 对象
 */
+ (instancetype) gradientViewWithType:(MJAGradientType)type;

/**
 根据内置类型和渐变方向,返回渐变 view 对象

 @param type 内置类型
 @param direction 渐变方向
 @return 渐变 view 对象
 */
+ (instancetype) gradientViewWithType:(MJAGradientType)type direction:(MJAGradientDirect)direction;

/**
 根据提供的颜色数组生成渐变 view, 默认方向是MJAGradientDirectLeftToRight

 @param colors 颜色数组
 @return 渐变 view 对象
 */
+ (instancetype) gradientViewWithColors:(NSArray<UIColor *>*)colors;

/**
 根据提供的颜色数组生成渐变 view, 并设置渐变方向

 @param colors 颜色数组
 @param direction 渐变方向
 @return 渐变 view 对象
 */
+ (instancetype) gradientViewWithColors:(NSArray<UIColor *>*)colors direction:(MJAGradientDirect)direction;

/**
 根据给定字符串,字体,字体颜色添加标题,只能居中显示

 @param title 标题
 @param font 标题字体
 @param color 字体颜色
 */
- (void) addTitle:(NSString *)title font:(UIFont *)font color:(UIColor *)color;

/**
 添加图片,注意:图片不能与标题共存

 @param image 需要添加的图片,显示大小为图片尺寸
 */
- (void) addImage:(UIImage *)image;

/**
 添加图片,注意:图片不能与标题共存

 @param image 需要添加的图片
 @param size 图片显示的大小
 */
- (void) addImage:(UIImage *)image size:(CGSize)size;

@end
