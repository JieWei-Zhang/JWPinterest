//
//  SecondViewController.m
//  JWPinterestDemo
//
//  Created by Vinhome on 16/4/22.
//  Copyright © 2016年 JW. All rights reserved.
//

#import "SecondViewController.h"
#import "CHTCollectionViewWaterfallLayout.h"

NSString * const cellIdentifier = @"cell";
@interface SecondViewController ()<UINavigationControllerDelegate,UIGestureRecognizerDelegate>
@property (nonatomic, strong) UIPercentDrivenInteractiveTransition *percentDrivenTransition;
@end

@implementation SecondViewController




-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    self.navigationController.navigationBarHidden = YES;
    self.navigationController.delegate            = self;
}

#pragma mark - UINavigationController Delegate
-(void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if ([navigationController   respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
    navigationController.interactivePopGestureRecognizer.enabled       = YES;
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.delegate                                 = self;
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
    self.automaticallyAdjustsScrollViewInsets                          = NO;
    [self.view  addSubview:self.collectionView];
    self.view.clipsToBounds=YES;
    
    
    UIScreenEdgePanGestureRecognizer *screenEdgePanGestureRecognizer = nil;
    if (self.navigationController.view.gestureRecognizers.count > 0)
    {
        for (UIGestureRecognizer *recognizer in self.navigationController.view.gestureRecognizers)
        {
            if ([recognizer isKindOfClass:[UIScreenEdgePanGestureRecognizer class]])
            {
                screenEdgePanGestureRecognizer = (UIScreenEdgePanGestureRecognizer *)recognizer;
                break;
            }
        }
    }
    
    [self.collectionView.panGestureRecognizer requireGestureRecognizerToFail:screenEdgePanGestureRecognizer];
    
    
    
    
    UIScreenEdgePanGestureRecognizer *popGesture = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self
                                                                                                     action:@selector(popGesture:)];
    popGesture.edges = UIRectEdgeLeft;
    [self.view addGestureRecognizer:popGesture];
//    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.and.right.and.bottom.and.top.equalTo(self.view);
//    }];

}
- (void)popGesture:(UIScreenEdgePanGestureRecognizer *)recognizer {
    
    // pop when distance longer than half of view width
    CGFloat progress = [recognizer translationInView:self.view].x / (self.view.bounds.size.width * 1.0);
    
    // 0 <= progress <= 1.0
    progress = MAX(0.0, progress);
    
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        _percentDrivenTransition = [[UIPercentDrivenInteractiveTransition alloc] init];
        [self.navigationController popViewControllerAnimated:YES];
        
    } else if (recognizer.state == UIGestureRecognizerStateChanged) {
        [_percentDrivenTransition updateInteractiveTransition:progress];
        
    } else if (recognizer.state == UIGestureRecognizerStateCancelled || recognizer.state == UIGestureRecognizerStateEnded) {
        
        if (progress > 0.3) {
            [_percentDrivenTransition finishInteractiveTransition];
            
        }else{
            [_percentDrivenTransition cancelInteractiveTransition];
        }
        
        _percentDrivenTransition = nil;
    }
}
#pragma mark - UINavigationControllerDelegate

-(id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                 animationControllerForOperation:(UINavigationControllerOperation)operation
                                              fromViewController:(UIViewController *)fromVC
                                                toViewController:(UIViewController *)toVC {
    if ([toVC isKindOfClass:[ViewController class]]) {
        DropDownTransition *animator = [[DropDownTransition alloc] init];
        return animator;
    }
    return nil;
}
-(id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController
                        interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController {
    if ([animationController isKindOfClass:[DropDownTransition class]]) {
        return _percentDrivenTransition;
        
    }else{
        return nil;
        
    }
    
}
#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return self.dataArr.count;
}
-(void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}
-(void)collectionView:(UICollectionView *)collectionView willDisplaySupplementaryView:(UICollectionReusableView *)view forElementKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath
{
    
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {


    self.pageindex=indexPath;
    JWCollectionCell *cell =
    (JWCollectionCell *)[collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier
                                                                      forIndexPath:indexPath];
    __weak typeof(self) weakSelf = self;
    

    
    CHTCollectionViewWaterfallLayout *layout =(CHTCollectionViewWaterfallLayout *)  self.sourceCollectionView.collectionViewLayout;
    CGFloat itemHeight =[layout  itemheightAtIndex:indexPath];
    
     cell.imgViewHeight= CGRectMake(0, 0, 0,itemHeight);
    
    
 
    
    cell.pullDownAction = ^(CGPoint offset) {
       // weakSelf.pullOffset = offset;
        [weakSelf.navigationController popViewControllerAnimated:YES];
    };

    return cell;
}
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
     NSInteger index=(scrollView.contentOffset.x / self.view.frame.size.width) + .5f;
    if (index>=self.dataArr.count) {
        return;
    }
    NSIndexPath *indexPath=[NSIndexPath  indexPathForRow:index inSection:0];
    
    
    self.pageindex=indexPath;
       
    
    
    
    
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(self.view.bounds.size.width+20, self.view.bounds.size.height);
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{

}

-(void)setDataArr:(NSMutableArray *)dataArr
{
    _dataArr=dataArr;
}
- (UICollectionView *)collectionView {
    if (!_collectionView) {

        UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc] init];
        [layout setItemSize:self.view.frame.size];
    layout.scrollDirection                         = UICollectionViewScrollDirectionHorizontal;
    layout.minimumInteritemSpacing                 = 0;
    layout.minimumLineSpacing                      = 0;
    layout.itemSize                                = CGSizeMake(self.view.bounds.size.width, self.view.bounds.size.height);
    
    


    _collectionView                                = [[UICollectionView alloc] initWithFrame:CGRectMake(-10, 0, self.view.frame.size.width+20, self.view.frame.size.height) collectionViewLayout:layout];
    _collectionView.autoresizingMask               = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    _collectionView.showsHorizontalScrollIndicator = NO;
    _collectionView.showsVerticalScrollIndicator   = NO;
       // _collectionView.alwaysBounceVertical=YES;
    _collectionView.dataSource                     = self;
    _collectionView.delegate                       = self;
    _collectionView.backgroundColor =[UIColor whiteColor];
    _collectionView.pagingEnabled=YES;
      
        
        //_collectionView.contentInset=UIEdgeInsetsMake(64, 0, 49, 0);

       //[_collectionView registerNib:[UINib nibWithNibName:@"JWCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"cell"];

      [_collectionView  registerClass:[JWCollectionCell class] forCellWithReuseIdentifier:cellIdentifier];
    }

    return _collectionView;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
