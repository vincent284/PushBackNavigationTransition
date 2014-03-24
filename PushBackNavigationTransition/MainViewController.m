//
//  MainViewController.m
//  PushBackNavigationTransition
//
//  Created by Vincent Nguyen on 23/3/14.
//  Copyright (c) 2014 nvson28. All rights reserved.
//

#import "MainViewController.h"
#import "SecondViewController.h"
#import "PushBackAnimator.h"

@interface MainViewController ()

@end

@implementation MainViewController

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
    
    self.title = @"Main";
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

- (IBAction)tapMe:(id)sender {
    SecondViewController *secondVC = [[SecondViewController alloc] initWithNibName:NSStringFromClass([SecondViewController class]) bundle:nil];
    [self.navigationController pushViewController:secondVC animated:YES];
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

@end
