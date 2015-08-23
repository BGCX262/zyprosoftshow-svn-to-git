//
//  ZYViewAnimation.m
//  
//
//  Created by ZYVincent on 11-10-10.
//  Copyright 2011年 __ZYProSoft__. All rights reserved.
//  http://www.ruyijian.com
//    团队QQ群号：219357847
//    团队主题：奋斗路上携手相伴！

#import "ZYViewAnimation.h"
#import <QuartzCore/QuartzCore.h>

static ZYViewAnimation *zyanimation = nil;
@implementation ZYViewAnimation

//share self
+ (id)shareZYViewAnimation
{
    @synchronized(self){
        if (zyanimation == nil) {
            zyanimation = [[self alloc]init];
        } 
    }
    return zyanimation;
}
//help function
//- (CGPoint)scalePoint:(CGPoint)point multiple:(NSInteger)count
//{
//    
//}

//show or hidden
+ (void)animationAddView:(UIView *)subView inSuperView:(UIView *)superView duration:(NSTimeInterval)duration fromAlpha:(CGFloat)fromAlpha toAlpha:(CGFloat)toAlpha
{
    subView.alpha = fromAlpha;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:duration];
    [subView setAlpha:toAlpha];
    [UIView commitAnimations];
    [superView addSubview:subView];
    [subView release];
}
//hidden and remove
+ (void)animationHideAndRemoveView:(UIView *)subView duration:(NSTimeInterval)duration
{
    subView.alpha = 1;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:duration];
    [subView setAlpha:0];
    [UIView commitAnimations];
    [subView removeFromSuperview];
}
+ (void)animatedShowView:(UIView *)view duration:(NSTimeInterval)duration alpha:(CGFloat)alpha{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:duration];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    view.alpha = alpha;
    [UIView commitAnimations];
}

+ (void)animatedShowView:(UIView *)view duration:(NSTimeInterval)duration{
    [self animatedShowView:view duration:duration alpha:1];
}



+ (void)animatedShowAndHideView:(UIView *)view duration:(NSTimeInterval)duration waitDuration:(NSTimeInterval)waitDuration{
    [self animatedShowView:view duration:duration];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:duration];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDelay:waitDuration];
    view.alpha = 0;
    [UIView commitAnimations];
}

+ (void)animatedHideView:(UIView *)view duration:(NSTimeInterval)duration{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:duration];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    view.alpha = 0;
    [UIView commitAnimations];
}

+ (void)animatedHideAndShowView:(UIView *)view duration:(NSTimeInterval)duration waitDuration:(NSTimeInterval)waitDuration{
    [self animatedHideView:view duration:duration];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:duration];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDelay:waitDuration];
    view.alpha = 1;
    [UIView commitAnimations];
}

+ (void)animatedWinkView:(UIView *)view duration:(NSTimeInterval)duration{
    view.alpha = 0;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:duration];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationRepeatCount:1000];
    [UIView setAnimationRepeatAutoreverses:YES];
    view.alpha = 1;
    [UIView commitAnimations];
}

+ (void)animatedMoveView:(UIView *)view duration:(NSTimeInterval)duration newFrame:(CGRect)newFrame{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:duration];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    view.frame = newFrame;
    [UIView commitAnimations];
}

//CABasicAnimation  1:
//抖动效果
+ (void)animationBasicWinkView:(UIView *)view duration:(NSTimeInterval)duration
{
    CALayer *viewLayer = [view layer];
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform"];
    animation.duration = duration;
    animation.repeatCount = 1000;
    animation.autoreverses = YES;
    animation.fromValue = [NSValue valueWithCATransform3D:CATransform3DRotate(viewLayer.transform, -0.03, 0.0, 0.0, 0.03)];
    animation.toValue = [NSValue valueWithCATransform3D:CATransform3DRotate(viewLayer.transform, 0.03, 0.0, 0.0, 0.03)];
    [viewLayer addAnimation:animation forKey:@"wink"];
}
//左右摆动
+ (void)animationBasicSwingView:(UIView *)view duration:(NSTimeInterval)duration fromPosition:(float)from toPosition:(float)to
{
    CALayer *viewLayer = [view layer];
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.translation.x"];
    animation.duration = duration;
    animation.repeatCount = 1000;
    animation.autoreverses = YES;
    animation.fromValue = [NSNumber numberWithFloat:from];
    animation.toValue = [NSNumber numberWithFloat:to];
    [viewLayer addAnimation:animation forKey:@"Swing"];
}
//上下摆动
+ (void)animationBasicBobbingView:(UIView *)view duration:(NSTimeInterval)duration fromPosition:(float)from toPosition:(float)to
{
    CALayer *viewLayer = [view layer];
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.translation.y"];
    animation.duration = duration;
    animation.repeatCount = 1000;
    animation.autoreverses = YES;
    animation.fromValue = [NSNumber numberWithFloat:from];
    animation.toValue = [NSNumber numberWithFloat:to];
    [viewLayer addAnimation:animation forKey:@"Bobbing"];
}
//斜向摆动
+ (void)animationBasicDiagonalView:(UIView *)view duration:(NSTimeInterval)duration startPoint:(CGPoint)start endPoint:(CGPoint)end
{
    CGFloat xfrom = start.x;
    CGFloat xto = end.x;
    CGFloat yfrom = start.y;
    CGFloat yto = end.y;
    
    [self animationBasicBobbingView:view duration:duration fromPosition:yfrom toPosition:yto];
    [self animationBasicSwingView:view duration:duration fromPosition:xfrom toPosition:xto];
}
//移动
+ (void)animationBasicMoveView:(UIView *)view duration:(NSTimeInterval)duration startPosition:(CGSize)start endPosition:(CGSize)end repeatCount:(NSInteger)count
{
    CALayer *viewLayer = [view layer];
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.translation"];
    animation.duration = duration;
    animation.repeatCount = count;
    animation.autoreverses = YES;
    animation.fromValue = [NSValue valueWithCGSize:start];
    animation.toValue = [NSValue valueWithCGSize:CGSizeMake(0, 0)];
    animation.fillMode = kCAFillModeForwards;
    [viewLayer setFrame:CGRectMake(end.width, end.height, viewLayer.frame.size.width, viewLayer.frame.size.height)];
    [viewLayer addAnimation:animation forKey:@"Move"];
}
//缩放
+ (void)animationBasicZoomView:(UIView *)view duration:(NSTimeInterval)duration multiple:(CGFloat)count
{
    CALayer *viewLayer = [view layer];
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    animation.toValue = [NSNumber numberWithFloat:count];
    [viewLayer setFrame:CGRectMake((view.center.x - viewLayer.frame.size.width*count/2),(view.center.y - viewLayer.frame.size.height*count/2), viewLayer.frame.size.width*count, viewLayer.frame.size.height*count)];
    [viewLayer addAnimation:animation forKey:@"zoom"];
}
//左右拉伸
+ (void)animationBasicLRStretchView:(UIView *)view duration:(NSTimeInterval)duration multiple:(CGFloat)count
{
    CALayer *viewLayer = [view layer];
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale.x"];
    animation.toValue = [NSNumber numberWithFloat:count];
    [viewLayer setFrame:CGRectMake((view.center.x - viewLayer.frame.size.width*count/2),view.frame.origin.y, viewLayer.frame.size.width*count, viewLayer.frame.size.height)];
    [viewLayer addAnimation:animation forKey:@"LRStretch"];
}
//上下拉伸
+ (void)animationBasicUDStretchView:(UIView *)view duration:(NSTimeInterval)duration multiple:(CGFloat)count
{
    CALayer *viewLayer = [view layer];
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale.y"];
    animation.toValue = [NSNumber numberWithFloat:count];
    [viewLayer setFrame:CGRectMake(view.frame.origin.x,(view.center.y - viewLayer.frame.size.height*count/2), viewLayer.frame.size.width, viewLayer.frame.size.height*count)];
    [viewLayer addAnimation:animation forKey:@"UDStretch"];
}
//倾斜视图
+ (void)animationBasicRotateView:(UIView *)view duration:(NSTimeInterval)duration rotateAngle:(float)angle
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:duration];
    [UIView setAnimationRepeatAutoreverses:NO];
    CGAffineTransform transform = CGAffineTransformMakeRotation(angle);
    view.transform = transform;
    [UIView commitAnimations];
}
//向左推动
+ (void)animationBasicLeftForwordView:(UIView *)view duration:(NSTimeInterval)duration destination:(CGFloat)distance
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:duration];
    [UIView setAnimationRepeatAutoreverses:NO];
    view.center = CGPointMake(view.center.x - distance, view.center.y);
    [UIView commitAnimations];
}
//向右推动
+ (void)animationBasicRightForwordView:(UIView *)view duration:(NSTimeInterval)duration destination:(CGFloat)distance
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:duration];
    [UIView setAnimationRepeatAutoreverses:NO];
    view.center = CGPointMake(view.center.x + distance, view.center.y);
    [UIView commitAnimations];
}
//向上推动
+ (void)animationBasicTopForwordView:(UIView *)view duration:(NSTimeInterval)duration destination:(CGFloat)distance
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:duration];
    [UIView setAnimationRepeatAutoreverses:NO];
    view.center = CGPointMake(view.center.x, view.center.y- distance);
    [UIView commitAnimations];
}
//向下推动
+ (void)animationBasicBottomForwordView:(UIView *)view duration:(NSTimeInterval)duration destination:(CGFloat)distance
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:duration];
    [UIView setAnimationRepeatAutoreverses:NO];
    view.center = CGPointMake(view.center.x, view.center.y + distance);
    [UIView commitAnimations];
}
//base function
+ (void)commonAnimationHelp:(NSString *)type forView:(UIView *)view duration:(NSTimeInterval)duration
{
    CALayer *viewLayer = [view layer];
    CATransition *animation = [CATransition animation];
    animation.delegate = self;
    animation.duration = duration;
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
	animation.fillMode = kCAFillModeBoth;
	animation.removedOnCompletion = NO;
    animation.type = type;
    [viewLayer addAnimation:animation forKey:@"animation"];
}
//立体翻转
+ (void)animationBasicCubeView:(UIView *)view duration:(NSTimeInterval)duration
{
    NSString *type = @"cube";
    [self commonAnimationHelp:type forView:view duration:duration];
}
//抽纸效果
+ (void)animationBasicSuckEffectView:(UIView *)view duration:(NSTimeInterval)duration
{
    NSString *type = @"suckEffect";
    [self commonAnimationHelp:type forView:view duration:duration];
}
//前后翻转特效
+ (void)animationBasicOglFlipView:(UIView *)view duration:(NSTimeInterval)duration
{
    NSString *type = @"oglFlip";
    [self commonAnimationHelp:type forView:view duration:duration];
}
//水波效果
+ (void)animationBasicRippleEffectView:(UIView *)view duration:(NSTimeInterval)duration
{
    NSString *type = @"rippleEffect";
    [self commonAnimationHelp:type forView:view duration:duration];
}
//向上翻页
+ (void)animationBasicPageCurlView:(UIView *)view duration:(NSTimeInterval)duration
{
    NSString *type = @"pageCurl";
    [self commonAnimationHelp:type forView:view duration:duration];
}
//向下翻页
+ (void)animationBasicPageUnCurlView:(UIView *)view duration:(NSTimeInterval)duration
{
    NSString *type = @"pageUnCurl";
    [self commonAnimationHelp:type forView:view duration:duration];
}
//相机打开效果
+ (void)animationBasicCameraIrisHollowOpenView:(UIView *)view duration:(NSTimeInterval)duration
{
    NSString *type = @"cameraIrisHollowOpen";
    [self commonAnimationHelp:type forView:view duration:duration];
}
//相机关闭效果
+ (void)animationBasicCameraIrisHollowCloseView:(UIView *)view duration:(NSTimeInterval)duration
{
    NSString *type = @"cameraIrisHollowClose";
    [self commonAnimationHelp:type forView:view duration:duration];
}

//help function
+ (void)commonHelpAnimation:(UIView *)view duration:(NSTimeInterval)duration type:(NSInteger)type
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:duration];
    [UIView setAnimationRepeatAutoreverses:NO];
    switch (type) {
        case FLIPLEFT:
            [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:view cache:NO];
            break;
        case FLIPRIGHT:
            [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:view cache:NO];
            break;
        default:
            break;
    }
    [UIView commitAnimations];
}
//左翻转特效
+ (void)animationBasicFlipLeftView:(UIView *)view duration:(NSTimeInterval)duration
{
    [self commonHelpAnimation:view duration:duration type:FLIPLEFT];
}
//右翻转特效
+ (void)animationBasicFlipRightView:(UIView *)view duration:(NSTimeInterval)duration
{
    [self commonHelpAnimation:view duration:duration type:FLIPRIGHT]; 
}

//help function
+ (void)commonBasicHelp:(UIView *)view duration:(NSTimeInterval)duration type:(NSInteger)type withDirection:(NSInteger)direction
{
    
    CALayer *viewLayer = [view layer];
    CATransition *animation = [CATransition animation];
    animation.delegate = self;
    animation.duration = duration;
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
	animation.fillMode = kCAFillModeForwards;
	animation.removedOnCompletion = NO;
    switch (type) {
		case PUSHUP:
			animation.type = kCATransitionPush;
		case MOVEUP:
			animation.type = kCATransitionMoveIn;
			break;
		case REVEAL:
			animation.type = kCATransitionReveal;
			break;
		case FADE:
			animation.type = kCATransitionFade;
			break;
		default:
			break;
	}
    switch (direction) {
        case LEFTDIRECTION:
            animation.subtype = kCATransitionFromLeft;
            break;
        case RIGHTDIRECTION:
            animation.subtype = kCATransitionFromRight;
            break;
        case TOPDIRECTION:
            animation.subtype = kCATransitionFromTop;
            break;
        case BOTTOMDIRECION:
            animation.subtype = kCATransitionFromBottom;
            break;
        default:
            break;
    }
    [viewLayer addAnimation:animation forKey:@"animation"];
}

//推动翻页
+ (void)animationBasicPushUpView:(UIView *)view duration:(NSTimeInterval)duration withDirection:(NSInteger)direction
{
    [self commonBasicHelp:view duration:duration type:PUSHUP withDirection:direction];
}
//覆盖效果
+ (void)animationBasicMoveUpView:(UIView *)view duration:(NSTimeInterval)duration withDirection:(NSInteger)direction
{
    [self commonBasicHelp:view duration:duration type:MOVEUP withDirection:direction];
}
//飞走效果
+ (void)animationBasicRevealView:(UIView *)view duration:(NSTimeInterval)duration withDirection:(NSInteger)direction
{
    [self commonBasicHelp:view duration:duration type:REVEAL withDirection:direction];
}
//溶解显示
+ (void)animationBasicFadeView:(UIView *)view duration:(NSTimeInterval)duration
{
    [self commonBasicHelp:view duration:duration type:FADE withDirection:TOPDIRECTION];
}
////help Function
//- (void)commonTransitionHelp:(UIView *)view1 toView:(UIView *)view2 transitionType:(NSInteger)type
//{
//    UIView *containerView = view1.superview;
//    switch (type) {
//        case TRANSITION_3DLEFT:
//            [[HMGLTransitionManager sharedTransitionManager] setTransition:[_transitionArray objectAtIndex:0]];
//            break;
//        case TRANSITION_3DRIGHT:
//            [[HMGLTransitionManager sharedTransitionManager] setTransition:[_transitionArray objectAtIndex:1]];
//            break;
//        case TRANSITION_CLOTH:
//            [[HMGLTransitionManager sharedTransitionManager] setTransition:[_transitionArray objectAtIndex:2]];
//            break;
//        case TRANSITION_FLIPLEFT:
//            [[HMGLTransitionManager sharedTransitionManager] setTransition:[_transitionArray objectAtIndex:3]];
//            break;
//        case TRANSITION_FLIPRIGHT:
//            [[HMGLTransitionManager sharedTransitionManager] setTransition:[_transitionArray objectAtIndex:4]];
//            break;
//        case TRANSITION_DOOR:
//            [[HMGLTransitionManager sharedTransitionManager] setTransition:[_transitionArray objectAtIndex:5]];
//            break;
//            
//        default:
//            break;
//    }
//	[[HMGLTransitionManager sharedTransitionManager] beginTransition:containerView];
//    	// Here you can do whatever you want except changing position, size or transformation of container view, or removing it from view hierarchy.
//	view2.frame = view1.frame;
//	[view1 removeFromSuperview];
//    NSLog(@"here is right or not");
//	[containerView addSubview:view2];
//	[[HMGLTransitionManager sharedTransitionManager] commitTransition];
//}
//3D切换效果
- (void)transition3DLeftFromView:(UIView *)view1 toView:(UIView *)view2 baseView:(UIView *)baseView
{
    [self commonTransitionHelp:view1 toView:view2 transitionType:TRANSITION_3DLEFT];
}
- (void)transition3DRightFromView:(UIView *)view1 toView:(UIView *)view2
{
    [self commonTransitionHelp:view1 toView:view2 transitionType:TRANSITION_3DRIGHT];

}
//Cloth效果
- (void)transitionClothFromView:(UIView *)view1 toView:(UIView *)view2
{
    [self commonTransitionHelp:view1 toView:view2 transitionType:TRANSITION_CLOTH];

}
//半折向左
- (void)transitionFlipLeftFromView:(UIView *)view1 toView:(UIView *)view2
{
    [self commonTransitionHelp:view1 toView:view2 transitionType:TRANSITION_FLIPLEFT];

}
//半折向右
- (void)transitionFlipRightFromView:(UIView *)view1 toView:(UIView *)view2
{
    [self commonTransitionHelp:view1 toView:view2 transitionType:TRANSITION_FLIPRIGHT];

}
//开门特效
- (void)transitionDoorFromView:(UIView *)view1 toView:(UIView *)view2
{
    [self commonTransitionHelp:view1 toView:view2 transitionType:TRANSITION_DOOR];

}
+ (void)animationBasicTestView:(UIView *)view duration:(NSTimeInterval)duration
{
    CALayer *viewLayer = [view layer];
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    animation.duration = duration;
//    animation.repeatCount = 1000;
//    animation.autoreverses = YES;
//    animation.fromValue = [NSValue valueWithCATransform3D:CATransform3DRotate(viewLayer.transform, 0, 0.0, 0.3, 0.3)];
//    animation.toValue = [NSValue valueWithCATransform3D:CATransform3DRotate(viewLayer.transform, 120, 0.0, 1.0, 1.0)];
    animation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(120, 0.0, 0.0, 0.0)];
    CALayer *nlayer = [CALayer layer];
    [nlayer setBackgroundColor:[UIColor redColor].CGColor];
    [viewLayer addSublayer:nlayer];
    [nlayer addAnimation:animation forKey:@"key"];
    animation.removedOnCompletion = YES;
//    animation.fromValue = [NSValue valueWithCATransform3D:CATransform3DScale(viewLayer.transform, 0.0, 0.0, 0.0)];
//    animation.toValue = [NSValue valueWithCATransform3D:CATransform3DScale(viewLayer.transform, 3.3, 3.3, 3.3)];
//    animation.fromValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.0, 0.0, 0.0)];
//    animation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(3.3, 3.3, 2.0)];
//    animation.fromValue = [NSValue valueWithCATransform3D:CATransform3DScale(viewLayer.transform, 0.0, 0.0, 0.0)];
//    animation.toValue = [NSValue valueWithCATransform3D:CATransform3DScale(viewLayer.transform, 0.3, 0.3, 0.3)];
//    [viewLayer setFrame:CGRectMake((view.center.x - viewLayer.frame.size.width*1.5/2),(view.center.y - viewLayer.frame.size.height*1.5/2), viewLayer.frame.size.width*1.5, viewLayer.frame.size.height*1.5)];
//    [viewLayer setFrame:CGRectMake((view.center.x - viewLayer.frame.size.width*2/2),view.frame.origin.y, viewLayer.frame.size.width*2, viewLayer.frame.size.height)];
    [viewLayer addAnimation:animation forKey:@"Test"];
}
//- (id)init
//{
//    self = [super init];
//    if (self) {
//        // Initialization code here.
//        Switch3DTransition *t1 = [[[Switch3DTransition alloc] init] autorelease];
//		t1.transitionType = Switch3DTransitionLeft;
//		
//		FlipTransition *t2 = [[[FlipTransition alloc] init] autorelease];
//		t2.transitionType = FlipTransitionRight;		
//		
//		NSArray *tempArray = [[NSArray alloc] initWithObjects:
//							[[[Switch3DTransition alloc] init] autorelease],
//							t1,
//							[[[ClothTransition alloc] init] autorelease],							
//							[[[FlipTransition alloc] init] autorelease],
//							t2,
//                            [[[DoorsTransition alloc] init] autorelease],
//							nil];
//        _transitionArray = tempArray;
//        [tempArray release];
//    }
//    
//    return self;
//}

//保持当前位置
- (void)holdCurrentPositionForView:(UIView *)view inView:(UIView *)view2
{
    
}
- (void)dealloc{
    
    [_transitionArray release];
    [super dealloc];
}

@end
