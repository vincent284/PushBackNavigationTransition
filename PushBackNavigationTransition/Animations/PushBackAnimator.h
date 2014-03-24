//
//  PushBackAnimation.h
//  PushBackNavigationTransition
//
//  Created by Vincent Nguyen on 23/3/14.
//  Copyright (c) 2014 nvson28. All rights reserved.
//

/**
 @discussion PushBackAnimator this class implements the UIViewControllerAnimatedTransitioning procotol, providing the push back animation for pushing/pop a UIViewController to a navigation stack
 */

#import <Foundation/Foundation.h>


@interface PushBackAnimator : NSObject<UIViewControllerAnimatedTransitioning>

/**
 @discussion presenting A flag set to YES if the animation is to PUSH a UIViewController, NO if the animation is to POP a UIViewController
 */
@property (assign, nonatomic) BOOL presenting;

@end
