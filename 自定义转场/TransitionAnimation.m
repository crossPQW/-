//
//  TransitionAnimation.m
//  自定义转场
//
//  Created by 黄少华 on 15/7/23.
//  Copyright (c) 2015年 黄少华. All rights reserved.
//

#import "TransitionAnimation.h"
#import "firstCollectionController.h"
#import "secondViewController.h"
#import "collectionViewCell.h"
@implementation TransitionAnimation

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 0.5f;
}


//方法是定义两个 ViewController 之间过渡效果的地方。这个方法会传递给我们一个参数transitionContext，该参数可以让我们访问一些实现过渡所必须的对象。

//transitionContext:参数是一个实现了 UIViewControllerContextTransitioning可以让我们访问一些实现过渡所必须的对象。 
- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    
    //获取初始控制器以及目标控制器
    firstCollectionController *fromVc = (firstCollectionController *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    secondViewController *toVc = (secondViewController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    //获取动画发生的容器
    UIView *containerView = [transitionContext containerView];
    
    
    //对cell上面的图片进行截图,然后隐藏这个imageview
    collectionViewCell *cell = (collectionViewCell *)[fromVc.collectionView cellForItemAtIndexPath:[[fromVc.collectionView indexPathsForSelectedItems] firstObject]];
    fromVc.indexPath = [[fromVc.collectionView indexPathsForSelectedItems] firstObject];
    
    UIView *shotView = [cell.bgImage snapshotViewAfterScreenUpdates:NO];
    shotView.frame = fromVc.finalCellRect = [containerView convertRect:cell.bgImage.frame fromView:cell.bgImage.superview];
    cell.bgImage.hidden = YES;
    
    
    //设置第二个控制器的位置,透明度
    toVc.view.frame = [transitionContext finalFrameForViewController:toVc];
    toVc.view.alpha = 0;
    toVc.imageview.hidden = YES;
    
    //把动画前后的两个Vc添加到容器中,注意顺序,shotView在上方
    [containerView addSubview:toVc.view];
    [containerView addSubview:shotView];
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0.f usingSpringWithDamping:0.4f initialSpringVelocity:0.6f options:UIViewAnimationOptionCurveEaseIn animations:^{
        
        toVc.view.alpha = 1.f;
        shotView.frame = [containerView convertRect:toVc.imageview.frame fromView:toVc.view];
        
        NSLog(@"%@",NSStringFromCGRect(shotView.frame));
        
    } completion:^(BOOL finished) {
        toVc.imageview.hidden = NO;
        cell.bgImage.hidden = NO;
        [shotView removeFromSuperview];
        //结束动画
        
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
}
@end
