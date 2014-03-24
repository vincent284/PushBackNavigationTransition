//
//  SecondViewController.m
//  PushBackNavigationTransition
//
//  Created by Vincent Nguyen on 23/3/14.
//  Copyright (c) 2014 nvson28. All rights reserved.
//

#import "SecondViewController.h"
#import "PushBackAnimator.h"

@interface SecondViewController () <UINavigationControllerDelegate>

@property (nonatomic, strong) UIPercentDrivenInteractiveTransition *interactiveAnimator;

@end

@implementation SecondViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"Second";
    
    UIScreenEdgePanGestureRecognizer *edgePanRecognizer = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(handleEdgePanRecognizer:)];
    edgePanRecognizer.edges = UIRectEdgeLeft;
    [self.view addGestureRecognizer:edgePanRecognizer];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    self.navigationController.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)handleEdgePanRecognizer:(UIScreenEdgePanGestureRecognizer *) recognizer
{
    CGFloat progress = [recognizer translationInView:self.view].x / (self.view.bounds.size.width * 1.0);
    progress = MIN(1.0, MAX(0.0, progress));
    
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        // Create a interactive transition and pop the view controller
        self.interactiveAnimator = [[UIPercentDrivenInteractiveTransition alloc] init];
        [self.navigationController popViewControllerAnimated:YES];
    }
    else if (recognizer.state == UIGestureRecognizerStateChanged) {
        // Update the interactive transition's progress
        [self.interactiveAnimator updateInteractiveTransition:progress];
    }
    else if (recognizer.state == UIGestureRecognizerStateEnded || recognizer.state == UIGestureRecognizerStateCancelled) {
        // Finish or cancel the interactive transition
        if (progress > 0.5) {
            [self.interactiveAnimator finishInteractiveTransition];
        }
        else {
            [self.interactiveAnimator cancelInteractiveTransition];
        }
        
        self.interactiveAnimator = nil;
    }
}

#pragma mark - UINavigationControllerDelegate
- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                  animationControllerForOperation:(UINavigationControllerOperation)operation
                                               fromViewController:(UIViewController *)fromVC
                                                 toViewController:(UIViewController *)toVC
{
    PushBackAnimator *animator = [PushBackAnimator new];
    if (operation == UINavigationControllerOperationPush) {
        animator.presenting = YES;
    }
    else {
        animator.presenting = NO;
    }
    
    return animator;
}

- (id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController
{
    return self.interactiveAnimator;
}
@end
