//
//  ViewController.m
//  GradientViewDemo
//
//  Created by Alan on 2018/10/26.
//  Copyright © 2018 Alan. All rights reserved.
//

#import "ViewController.h"
#import "MJAGradientView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    MJAGradientView *view = [MJAGradientView gradientViewWithType:MJAGradientTypePurple];
    view.frame = CGRectMake(100, 100, 200, 60);
    view.cornerRadius = 30;
    [self.view addSubview:view];
    
    MJAGradientView *view1 = [MJAGradientView gradientViewWithType:MJAGradientTypePurple];
    view1.direction = MJAGradientDirectRightToLeft;
    view1.frame = CGRectMake(100, CGRectGetMaxY(view.frame) + 20, 200, 60);
    [self.view addSubview:view1];
    
    MJAGradientView *view2 = [MJAGradientView gradientViewWithType:MJAGradientTypeYellow];
    view2.frame = CGRectMake(100, CGRectGetMaxY(view1.frame) + 20, 80, 80);
    [self.view addSubview:view2];
    
    MJAGradientView *view3 = [MJAGradientView gradientViewWithType:MJAGradientTypeYellow direction:MJAGradientDirectTopToBottom];
    view3.frame = CGRectMake(CGRectGetMaxX(view2.frame) + 35, CGRectGetMinY(view2.frame), 80, 80);
    [self.view addSubview:view3];
    
    MJAGradientView *view4 = [MJAGradientView gradientViewWithColors:@[[UIColor greenColor],
                                                                       [UIColor orangeColor],
                                                                       [UIColor magentaColor]]];
    view4.frame = CGRectMake(100, CGRectGetMaxY(view3.frame) + 20, 200, 60);
    view4.cornerRadius = 30;
    [view4 addTitle:@"这里是文字" font:[UIFont systemFontOfSize:20] color:[UIColor whiteColor]];
    [self.view addSubview:view4];
    
    MJAGradientView *view5 = [MJAGradientView gradientViewWithColors:@[[UIColor greenColor],
                                                                       [UIColor orangeColor],
                                                                       [UIColor magentaColor]]];
    view5.colorOffset = 0.5;
    view5.frame = CGRectMake(100, CGRectGetMaxY(view4.frame) + 20, 200, 60);
    view5.cornerRadius = 30;
    [view5 addImage:[UIImage imageNamed:@"icon_msg_zan"]];
    [self.view addSubview:view5];
}


@end
