//
//  MoveTransition.m
//  JWPinterestDemo
//
//  Created by Vinhome on 16/4/25.
//  Copyright © 2016年 JW. All rights reserved.
//

#import "MoveTransition.h"

@implementation MoveTransition
- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext{
    return 0.3f;
}
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext{
    ViewController *fromVC = (ViewController *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    SecondViewController *toVC   = (SecondViewController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *containerView = [transitionContext containerView];
    
    
    UICollectionViewCell *cell =(UICollectionViewCell *)[fromVC.collectionView cellForItemAtIndexPath:[[fromVC.collectionView indexPathsForSelectedItems] firstObject]];
    
     UIView * snapShotView = [cell snapshotViewAfterScreenUpdates:NO];
    
    toVC.selectedCell=cell;
   
    fromVC.indexPath = [[fromVC.collectionView indexPathsForSelectedItems]firstObject];
    snapShotView.frame = fromVC.finalCellRect = [containerView convertRect:cell.frame fromView:cell.superview];
    
    
    toVC.view.frame = [transitionContext finalFrameForViewController:toVC];
    toVC.view.alpha = 0;
     [toVC.collectionView scrollToItemAtIndexPath:[[fromVC.collectionView indexPathsForSelectedItems]firstObject] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
    

    
    [containerView addSubview:toVC.view];
    [containerView addSubview:snapShotView];
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0.0f usingSpringWithDamping:1.f initialSpringVelocity:0.0f options:UIViewAnimationOptionCurveEaseOut animations:^{
        toVC.view.alpha = 1.0;
        snapShotView.frame = [containerView convertRect:CGRectMake(20, 20, toVC.view.frame.size.width-(20*2), cell.frame.size.height) fromView:toVC.view];
        
    } completion:^(BOOL finished) {
        
        [snapShotView removeFromSuperview];
        [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
    }];
    
}
@end
