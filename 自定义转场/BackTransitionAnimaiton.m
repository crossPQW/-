//
//  BackTransitionAnimaiton.m
//  自定义转场
//
//  Created by 黄少华 on 15/7/23.
//  Copyright (c) 2015年 黄少华. All rights reserved.
//

#import "BackTransitionAnimaiton.h"
#import <UIKit/UIKit.h>
#import "firstCollectionController.h"
#import "secondViewController.h"
#import "collectionViewCell.h"
@implementation BackTransitionAnimaiton
- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 0.5f;
}


//方法是定义两个 ViewController 之间过渡效果的地方。这个方法会传递给我们一个参数transitionContext，该参数可以让我们访问一些实现过渡所必须的对象。

//transitionContext:参数是一个实现了 UIViewControllerContextTransitioning可以让我们访问一些实现过渡所必须的对象。
- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    
    //获取初始控制器以及目标控制器
    firstCollectionController *toVc = (firstCollectionController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    secondViewController *fromVc = (secondViewController *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    //获取动画发生的容器
    UIView *containerView = [transitionContext containerView];
    
    
    //在前一个VC上截图
    UIView *shotView = [fromVc.imageview snapshotViewAfterScreenUpdates:NO];
    shotView.frame = [containerView convertRect:fromVc.imageview.frame fromView:fromVc.view];
    fromVc.imageview.hidden = YES;
    
    //初始化后一个vc的位置
    toVc.view.frame = [transitionContext finalFrameForViewController:toVc];
    
    //获取toVC中图片位置
    collectionViewCell *cell = (collectionViewCell *)[toVc.collectionView cellForItemAtIndexPath:toVc.indexPath];
    cell.bgImage.hidden = YES;
    
    //添加进容器
    [containerView insertSubview:toVc.view belowSubview:fromVc.view];
    [containerView addSubview:shotView];
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0.f usingSpringWithDamping:0.6 initialSpringVelocity:1.f options:UIViewAnimationOptionAllowUserInteraction animations:^{
        fromVc.view.alpha = 0.f;
        shotView.frame = toVc.finalCellRect;
    } completion:^(BOOL finished) {
        [shotView removeFromSuperview];
        fromVc.imageview.hidden = NO;
        cell.bgImage.hidden = NO;
        [transitionContext completeTransition: ![transitionContext transitionWasCancelled]];
    }];
}
@end
