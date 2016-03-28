//
//  MenuViewController.m
//  AboutMenu
//
//  Created by r_zhou on 16/3/25.
//  Copyright © 2016年 r_zhou. All rights reserved.
//

#import "MenuViewController.h"
#import "MenuCenterViewController.h"
#import "MenuLeftViewController.h"
#import "MenuRightViewController.h"

//缩放比例
static CGFloat scaleF = 0;
//手势滑动的速度系数
static CGFloat speedF = 0.5;

@interface MenuViewController ()
@property (strong, nonatomic) MenuCenterViewController *centerView;
@property (strong, nonatomic) MenuLeftViewController *leftView;
@property (strong, nonatomic) MenuRightViewController *rightView;

@end

@implementation MenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    //绑定具体的菜单
    self.leftView = [self.storyboard instantiateViewControllerWithIdentifier:@"MenuLeftViewController"];
    [self.view addSubview:self.leftView.view];
    
    self.rightView = [self.storyboard instantiateViewControllerWithIdentifier:@"MenuRightViewController"];
    [self.view addSubview:self.rightView.view];
    
    self.centerView = [self.storyboard instantiateViewControllerWithIdentifier:@"MenuCenterViewController"];
    [self.view addSubview:self.centerView.view];
    
    
    //Pan 拖动手势
    UIPanGestureRecognizer *tp=[[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(dragGestureEvents:)];
    [self.centerView.view addGestureRecognizer:tp];

    
    //设置隐藏和显示
    self.leftView.view.hidden = YES;
    self.centerView.view.hidden = NO;
    self.rightView.view.hidden = YES;
}

- (void)dragGestureEvents:(UIPanGestureRecognizer *)pan
{
    //1.判断方向
    CGPoint point = [pan translationInView:self.view];
    
    scaleF = point.x + speedF + scaleF;
    
    if (pan.view.frame.origin.x >= 0) {
        //显示左面菜单
        //计算当前菜单的显示中心点位置
        CGFloat x = pan.view.center.x + point.x + speedF;
        pan.view.center = CGPointMake(x, pan.view.center.y);
        
        //计算缩放比例
        //得到一个滑动偏移量的百分比
        CGFloat sx = 1 - scaleF / 1000;
        CGFloat sy = 1 - scaleF / 1000;
        //CGAffineTransformScale 收缩
        //CGAffineTransformTranslate  平移
        pan.view.transform = CGAffineTransformTranslate(CGAffineTransformIdentity, sx, sy);
        
        //还原手势
        [pan setTranslation:CGPointZero inView:self.view];
        
        //显示对应的菜单
        self.leftView.view.hidden = NO;
        self.rightView.view.hidden = YES;
        
    } else {
        //显示右面菜单
        //计算当前菜单的显示中心点位置
        CGFloat x = pan.view.center.x + point.x + speedF;
        pan.view.center = CGPointMake(x, pan.view.center.y);
        
        //计算缩放比例
        //得到一个滑动偏移量的百分比
        CGFloat sx = 1 + scaleF / 1000;
        CGFloat sy = 1 + scaleF / 1000;
        pan.view.transform = CGAffineTransformTranslate(CGAffineTransformIdentity, sx, sy);
        
        //还原手势
        [pan setTranslation:CGPointZero inView:self.view];
        
        //显示对应的菜单
        self.leftView.view.hidden = YES;
        self.rightView.view.hidden = NO;
    }
    
    
    if (pan.state == UIGestureRecognizerStateEnded) {
        //手势结束
        //滑动偏移量
        //定义偏移量范围: 160
        CGFloat offsetX = speedF + 160;
        if (scaleF > offsetX) {
            //显示左边菜单
            [self showMenuLeftVC];
        } else  if (scaleF < -offsetX) {
            //显示右边菜单
            [self showMenuRightVC];
        } else {
            //显示主菜单
            [self showMenuCenterVC];
            //当我们手指离开屏幕的时候还原偏移量
            scaleF = 0;
        }
    }
}

//左面菜单显示
- (void)showMenuLeftVC
{
    //自定义组件中常用到
    [UIView beginAnimations:nil context:nil];
    
    self.centerView.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1, 1);//1 缩放比例
    
    self.centerView.view.center = CGPointMake(360, self.view.bounds.size.height/2);
    
    //执行动画
    [UIView commitAnimations];
}

//中间菜单显示
- (void)showMenuCenterVC
{
    //自定义组件中常用到
    [UIView beginAnimations:nil context:nil];
    
    self.centerView.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1, 1);
    
    self.centerView.view.center = CGPointMake(self.view.bounds.size.width/2, self.view.bounds.size.height/2);
    
    //执行动画
    [UIView commitAnimations];
}

//右面菜单显示
- (void)showMenuRightVC
{
    //自定义组件中常用到
    [UIView beginAnimations:nil context:nil];
    
    self.centerView.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1, 1);
    
    self.centerView.view.center = CGPointMake(0, self.view.bounds.size.height/2);
    
    //执行动画
    [UIView commitAnimations];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
