//
//  Basic_ViewController.m
//  SJNWaterRippleAndRotate
//
//  Created by tiaoxin on 2019/7/12.
//  Copyright © 2019 tiaoxin. All rights reserved.
//

#import "Basic_ViewController.h"
#import "WaterRippleAndView.h"
#import <Masonry.h>
#define Cor_Color(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
@interface Basic_ViewController ()
@property (strong, nonatomic) IBOutlet UIView *contView;
@property (nonatomic, strong) UIView *icon_View;

@property (nonatomic, strong) WaterRippleAndView *BackView;
@end

@implementation Basic_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.contView addSubview:self.BackView];
    //第一步，通过UIBezierPath设置圆形的矢量路径
    UIBezierPath *circle = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(self.contView.center.x - 75.0f, self.contView.center.y-350, 150, 150)];
    
    //第二步，用CAShapeLayer沿着第一步的路径画一个完整的环（颜色灰色，起始点0，终结点1）
    CAShapeLayer *bgLayer = [CAShapeLayer layer];
    bgLayer.frame = CGRectMake(0, 0, 150, 150);//设置Frame
    //    bgLayer.position = self.contView.center;//居中显示
    bgLayer.fillColor = [UIColor whiteColor].CGColor;//填充颜色=透明色
    bgLayer.lineWidth = 10.f;//线条大小
    bgLayer.strokeColor = Cor_Color(9,209,90).CGColor;//线条颜色
    bgLayer.strokeStart = 0.f;//路径开始位置
    bgLayer.strokeEnd = 1.f;//路径结束位置
    bgLayer.path = circle.CGPath;//设置bgLayer的绘制路径为circle的路径
    [self.contView.layer addSublayer:bgLayer];//添加到屏幕上
    [self.contView addSubview:self.icon_View];
    [self.icon_View mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_offset(CGSizeMake(20.0f, 20.0f));
    }];
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    //设置动画属性，因为是沿着贝塞尔曲线动，所以要设置为position
    animation.keyPath = @"position";
    //设置动画时间
    animation.duration = 3;
    // 告诉在动画结束的时候不要移除
    animation.removedOnCompletion = NO;
    // 始终保持最新的效果
    animation.fillMode = kCAFillModeForwards;
    animation.calculationMode = kCAAnimationPaced;
    animation.repeatCount = HUGE;
    animation.rotationMode = kCAAnimationRotateAutoReverse;
    // 设置贝塞尔曲线路径
    animation.path = circle.CGPath;
    //    animation.
    // 将动画对象添加到视图的layer上
    [self.icon_View.layer addAnimation:animation forKey:nil];
    [self.BackView mas_makeConstraints:^(MASConstraintMaker *make) {
        //        make.centerX.mas_offset(self.contView.centerX - 75.0f);
        //        make.centerY.mas_offset(self.contView.centerY-350);
        make.left.offset(self.contView.center.x - 75.0f);
        make.top.offset(self.contView.center.y-350);
        make.size.mas_offset(CGSizeMake(150.0f, 150.0f));
    }];
}

- (UIView *)icon_View {
    if (!_icon_View) {
        _icon_View = [[UIView alloc] init];
        _icon_View.backgroundColor = [UIColor whiteColor];
        _icon_View.layer.borderWidth = 1.0f;
        _icon_View.layer.borderColor = Cor_Color(9,209,90).CGColor;
        _icon_View.layer.cornerRadius = 10.0f;
    }
    return _icon_View;
}

- (WaterRippleAndView *)BackView {
    if (!_BackView) {
        _BackView = [[WaterRippleAndView alloc] init];
        //        _BackView.backgroundColor = [UIColor orangeColor];
    }
    return _BackView;
}


@end
