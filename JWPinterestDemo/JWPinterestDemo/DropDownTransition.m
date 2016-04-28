//
//  DropDownTransition.m
//  JWPinterestDemo
//
//  Created by Vinhome on 16/4/27.
//  Copyright © 2016年 JW. All rights reserved.
//

#import "DropDownTransition.h"

@implementation DropDownTransition
- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext{
    return 0.6f;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
    ViewController*toVC = (ViewController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    SecondViewController *fromVC = (SecondViewController *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIView *containerView = [transitionContext containerView];
    
   
    
    
    JWCollectionCell *cell =
    (JWCollectionCell *)[fromVC.collectionView cellForItemAtIndexPath:fromVC.pageindex];
    UIView  *snapShotView = [cell.imgView snapshotViewAfterScreenUpdates:NO];
    
    snapShotView.frame = [containerView convertRect:cell.imgView.frame fromView:cell.imgView.superview];
    
    
    
    
    toVC.view.frame = [transitionContext finalFrameForViewController:toVC];
    [containerView addSubview:toVC.view];
    [containerView addSubview:snapShotView];
    
    [toVC.collectionView scrollToItemAtIndexPath:fromVC.pageindex atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
    
    
    UICollectionViewCell *tocell =(UICollectionViewCell *)[toVC.collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:fromVC.pageindex];
    
    NSLog(@"_________%ld",(long)fromVC.pageindex.row);

    CGRect frame= [containerView convertRect:tocell.frame fromView:toVC.collectionView];
   NSLog(@"___%f____%F_____%F____%f",frame.origin.x,frame.origin.y,frame.size.width,frame.size.height);
    [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0.0f usingSpringWithDamping:1.0f initialSpringVelocity:1.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        fromVC.view.alpha = 0.0f;
        snapShotView.frame = [containerView convertRect:tocell.frame fromView:toVC.collectionView];
        
        
    } completion:^(BOOL finished) {
        [snapShotView removeFromSuperview];
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
}
@end
