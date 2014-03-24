//
//  PushBackAnimation.m
//  PushBackNavigationTransition
//
//  Created by Vincent Nguyen on 23/3/14.
//  Copyright (c) 2014 nvson28. All rights reserved.
//

#import "PushBackAnimator.h"

@implementation PushBackAnimator 
-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    //Get references to the view hierarchy
    UIView *containerView = [transitionContext containerView];
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    //Insert 'to' view into the hierarchy
    [containerView insertSubview:toViewController.view belowSubview:fromViewController.view];
    
    if (self.presenting) {
        CATransform3D t1 = CATransform3DMakeRotation(10.0f*M_PI/180.0f, 0.0f, -1.0f, 0.0f);
        [self setAnchorPoint:CGPointMake(1.0, 0.5) forView:fromViewController.view];
        CATransform3D sublayerTransform = CATransform3DIdentity;
        sublayerTransform.m34 = 1.0f / -300.0f;
        fromViewController.view.superview.layer.sublayerTransform = sublayerTransform;
        
        CATransform3D t2 = CATransform3DMakeTranslation(320.0f, 0.0f, 0.0f);
        toViewController.view.layer.transform = t2;
        
        [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
            fromViewController.view.layer.transform = t1;
            toViewController.view.layer.transform = CATransform3DIdentity;
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
        }];
    }
    else {
        [self setAnchorPoint:CGPointMake(1.0, 0.5) forView:toViewController.view];
        CATransform3D t1 = CATransform3DMakeRotation(10.0f*M_PI/180.0f, 0.0f, -1.0f, 0.0f);
        toViewController.view.layer.transform = t1;
        
        CATransform3D t2 = CATransform3DMakeTranslation(320.0f, 0.0f, 0.0f);
        
        [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
            fromViewController.view.layer.transform = t2;
            toViewController.view.layer.transform = CATransform3DIdentity;
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
        }];
    }
}

-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.3;
}

#pragma mark - Utilities
- (void)setAnchorPoint:(CGPoint)anchorPoint forView:(UIView *)view {
    CGPoint oldOrigin = view.frame.origin;
    view.layer.anchorPoint = anchorPoint;
    CGPoint newOrigin = view.frame.origin;
    
    CGPoint transition;
    transition.x = newOrigin.x - oldOrigin.x;
    transition.y = oldOrigin.y - oldOrigin.y;
    
    view.center = CGPointMake (view.center.x - transition.x, view.center.y - transition.y);
}
@end
