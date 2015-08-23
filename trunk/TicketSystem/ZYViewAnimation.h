//
//  ZYViewAnimation.h
//  
//
//  Created by ZYVincent on 11-10-10.
//---------------------------------
//    文件作用：动画集成组件得头文件，可以查看现有得动作，可以补充强大
//            
//            
//    作者：胡涛
//    支持:http://www.ruyijian.com
//    团队QQ群号：219357847
//    团队主题：奋斗路上携手相伴！
//---------------------------------
//  Copyright 2011年 __ZYProSof__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZYAnimationConfig.h"

@interface ZYViewAnimation : NSObject
{
    NSArray *_transitionArray;
}

//share self
+ (id)shareZYViewAnimation;

+ (void)animationAddView:(UIView *)subView inSuperView:(UIView *)superView duration:(NSTimeInterval)duration fromAlpha:(CGFloat)fromAlpha toAlpha:(CGFloat)toAlpha;
+ (void)animationHideAndRemoveView:(UIView *)subView duration:(NSTimeInterval)duration;

+ (void)animatedShowView:(UIView *)view duration:(NSTimeInterval)duration alpha:(CGFloat)alpha;
+ (void)animatedShowView:(UIView *)view duration:(NSTimeInterval)duration;
+ (void)animatedShowAndHideView:(UIView *)view duration:(NSTimeInterval)duration waitDuration:(NSTimeInterval)waitDuration;
+ (void)animatedHideView:(UIView *)view duration:(NSTimeInterval)duration;
+ (void)animatedHideAndShowView:(UIView *)view duration:(NSTimeInterval)duration waitDuration:(NSTimeInterval)waitDuration;
+ (void)animatedWinkView:(UIView *)view duration:(NSTimeInterval)duration;
+ (void)animatedMoveView:(UIView *)view duration:(NSTimeInterval)duration newFrame:(CGRect)newFrame;

//CABasicAnimation

//winkAnimation
+ (void)animationBasicWinkView:(UIView *)view duration:(NSTimeInterval)duration;//抖动效果
+ (void)animationBasicSwingView:(UIView *)view duration:(NSTimeInterval)duration fromPosition:(float)from toPosition:(float)to;//左右摆动
+ (void)animationBasicBobbingView:(UIView *)view duration:(NSTimeInterval)duration fromPosition:(float)from toPosition:(float)to;//上下摆动
+ (void)animationBasicDiagonalView:(UIView *)view duration:(NSTimeInterval)duration startPoint:(CGPoint)start endPoint:(CGPoint)end;//斜向摆动
+ (void)animationBasicMoveView:(UIView *)view duration:(NSTimeInterval)duration startPosition:(CGSize)start endPosition:(CGSize)end repeatCount:(NSInteger)count;//移动
+ (void)animationBasicZoomView:(UIView *)view duration:(NSTimeInterval)duration multiple:(CGFloat)count;//缩放
+ (void)animationBasicLRStretchView:(UIView *)view duration:(NSTimeInterval)duration multiple:(CGFloat)count;//左右拉伸
+ (void)animationBasicUDStretchView:(UIView *)view duration:(NSTimeInterval)duration multiple:(CGFloat)count;//上下拉伸

+ (void)animationBasicRotateView:(UIView *)view duration:(NSTimeInterval)duration rotateAngle:(float)angle;//倾斜视图

//上下左右推动
+ (void)animationBasicLeftForwordView:(UIView *)view duration:(NSTimeInterval)duration destination:(CGFloat)distance;
+ (void)animationBasicRightForwordView:(UIView *)view duration:(NSTimeInterval)duration destination:(CGFloat)distance;
+ (void)animationBasicTopForwordView:(UIView *)view duration:(NSTimeInterval)duration destination:(CGFloat)distance;
+ (void)animationBasicBottomForwordView:(UIView *)view duration:(NSTimeInterval)duration destination:(CGFloat)distance;

//立体翻转
+ (void)animationBasicCubeView:(UIView *)view duration:(NSTimeInterval)duration;
//抽纸效果
+ (void)animationBasicSuckEffectView:(UIView *)view duration:(NSTimeInterval)duration;
//翻转特效
+ (void)animationBasicOglFlipView:(UIView *)view duration:(NSTimeInterval)duration;
//水波效果
+ (void)animationBasicRippleEffectView:(UIView *)view duration:(NSTimeInterval)duration;
//向上翻页
+ (void)animationBasicPageCurlView:(UIView *)view duration:(NSTimeInterval)duration;
//向下翻页
+ (void)animationBasicPageUnCurlView:(UIView *)view duration:(NSTimeInterval)duration;
//相机打开效果
+ (void)animationBasicCameraIrisHollowOpenView:(UIView *)view duration:(NSTimeInterval)duration;
//相机关闭效果
+ (void)animationBasicCameraIrisHollowCloseView:(UIView *)view duration:(NSTimeInterval)duration;
//左翻转特效
+ (void)animationBasicFlipLeftView:(UIView *)view duration:(NSTimeInterval)duration;
//右翻转特效
+ (void)animationBasicFlipRightView:(UIView *)view duration:(NSTimeInterval)duration;
//推动翻页
+ (void)animationBasicPushUpView:(UIView *)view duration:(NSTimeInterval)duration withDirection:(NSInteger)direction;
//覆盖效果
+ (void)animationBasicMoveUpView:(UIView *)view duration:(NSTimeInterval)duration withDirection:(NSInteger)direction;
//飞走效果
+ (void)animationBasicRevealView:(UIView *)view duration:(NSTimeInterval)duration withDirection:(NSInteger)direction;
//溶解显示
+ (void)animationBasicFadeView:(UIView *)view duration:(NSTimeInterval)duration;
//********************
//HMGLTransitions
//3D切换效果
- (void)transition3DLeftFromView:(UIView *)view1 toView:(UIView *)view2;
- (void)transition3DRightFromView:(UIView *)view1 toView:(UIView *)view2;
//Cloth效果
- (void)transitionClothFromView:(UIView *)view1 toView:(UIView *)view2;
//半折向左
- (void)transitionFlipLeftFromView:(UIView *)view1 toView:(UIView *)view2;
//半折向右
- (void)transitionFlipRightFromView:(UIView *)view1 toView:(UIView *)view2;
//开门特效
- (void)transitionDoorFromView:(UIView *)view1 toView:(UIView *)view2;



//保持,和解除当前view得位置得锁定
- (void)holdCurrentPositionForView:(UIView *)view inView:(UIView *)view2;
- (void)unHoldCurrentPositionForView:(UIView *)view inView:(UIView *)view2;


+ (void)animationBasicTestView:(UIView *)view duration:(NSTimeInterval)duration;

@end
