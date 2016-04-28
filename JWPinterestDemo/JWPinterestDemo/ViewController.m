//
//  ViewController.m
//  JWPinterestDemo
//
//  Created by Vinhome on 16/4/22.
//  Copyright © 2016年 JW. All rights reserved.
//

#import "ViewController.h"
#import "Masonry.h"
#import "SecondViewController.h"
#import "JDFPeekabooCoordinator.h"
@interface ViewController ()<UINavigationControllerDelegate>
@property (nonatomic, strong) JDFPeekabooCoordinator *scrollCoordinator;
@property (nonatomic, strong) SecondViewController *secondVC;

@end

@implementation ViewController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden=NO;
    
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self.scrollCoordinator disable];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self.scrollCoordinator enable];
    
     self.navigationController.delegate = self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    
    
    [self.view  addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
      make.left.and.right.and.bottom.equalTo(self.view);
        make.top.equalTo(self.view.mas_left).with.offset(0);
    }];
    
    UIColor *blueColour = [UIColor colorWithRed:44.0f/255.0f green:62.0f/255.0f blue:80.0f/255.0f alpha:1.0f];
    
    
    self.navigationController.toolbarHidden = NO;
   // self.navigationController.navigationBar.barTintColor = blueColour;
    self.navigationController.toolbar.barTintColor = blueColour;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    self.scrollCoordinator = [[JDFPeekabooCoordinator alloc] init];
    self.scrollCoordinator.scrollView = self.collectionView;
    self.scrollCoordinator.topView = self.navigationController.navigationBar;
    self.scrollCoordinator.topViewMinimisedHeight = 20.0f;
    self.scrollCoordinator.bottomView = self.navigationController.toolbar;
    
    self.scrollCoordinator.bottomView.hidden=YES;

    
}
#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
        return 20;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
    UICollectionViewCell *cell =
    (UICollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"cell"
                                                                         forIndexPath:indexPath];
        cell.backgroundColor = [UIColor colorWithHue:( arc4random() % 256 / 256.0 )
                                                                    saturation:( arc4random() % 128 / 256.0 ) + 0.5
                                                                     brightness:( arc4random() % 128 / 256.0 ) + 0.5
                                                                       alpha:1];
    
    return cell;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return [self.dataArr[indexPath.item % 4] CGSizeValue];
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (!_secondVC) {
        _secondVC =[[SecondViewController  alloc]init];
    }
    
   
    _secondVC.itemStartFrame=[self.view  convertRect:[collectionView  cellForItemAtIndexPath:indexPath].frame fromView:collectionView];//[self.dataArr[indexPath.row]CGSizeValue];
//
    
    [_secondVC addObserver:self forKeyPath:NSStringFromSelector(@selector(pageindex)) options:NSKeyValueObservingOptionNew context:NULL];
    NSLog(@"________%F",[self.dataArr[indexPath.row]CGSizeValue].height);

    _secondVC.sourceCollectionView=collectionView;
    _secondVC.dataArr=self.dataArr;
    
   // NSLog(@"_______%f",vc.itemStartFrame.size.height);
    [self.navigationController pushViewController:_secondVC animated:YES];
    //[self  presentViewController:vc animated:YES completion:nil];

    
}
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    NSIndexPath *pageindex = change[NSKeyValueChangeNewKey];
    
    [self.collectionView scrollToItemAtIndexPath:pageindex atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
    
    [self.collectionView reloadData];
    NSMutableArray * arr =[[NSMutableArray  alloc]init];
    for (int i = 0 ; i<self.dataArr.count; i++) {
        
        CGRect frame =[self.view  convertRect:[self.collectionView  cellForItemAtIndexPath:[NSIndexPath  indexPathForItem:i inSection:0]].frame fromView:self.collectionView];
        //NSStringFromCGRect(frame);
        [arr addObject:NSStringFromCGRect(frame)];
    }
    _secondVC.dataArr=self.dataArr;
   _secondVC.sourceCollectionView=self.collectionView;
    
    
}

-(NSMutableArray *)dataArr
{
    if (!_dataArr) {
        _dataArr=[[NSMutableArray  alloc]init];
        for (int i =0; i<20; i++) {
            [_dataArr addObject:[NSValue valueWithCGSize:CGSizeMake(100, arc4random()%150+50)]];
        }
        
    }
    return _dataArr;
}
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        CHTCollectionViewWaterfallLayout *layout       = [[CHTCollectionViewWaterfallLayout alloc] init];

        layout.sectionInset                            = UIEdgeInsetsMake(1, 10, 1, 10);
        layout.headerHeight                            = 0;

        layout.minimumColumnSpacing                    = 10;

        layout.minimumInteritemSpacing                 = 10;

        _collectionView                                = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
        _collectionView.autoresizingMask               = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.showsVerticalScrollIndicator   = NO;
        _collectionView.alwaysBounceVertical           = YES;
        _collectionView.dataSource                     = self;
        _collectionView.delegate                       = self;
        _collectionView.backgroundColor =[UIColor whiteColor];
        //_collectionView.contentInset=UIEdgeInsetsMake(64, 0, 49, 0);

        //[_collectionView registerNib:[UINib nibWithNibName:@"StyleCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"StyleCollectionViewCell"];

        [_collectionView  registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    }
    
    return _collectionView;
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
}
#pragma mark <UINavigationControllerDelegate>
- (id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                   animationControllerForOperation:(UINavigationControllerOperation)operation
                                                fromViewController:(UIViewController *)fromVC
                                                  toViewController:(UIViewController *)toVC{
    
    if ([toVC isKindOfClass:[SecondViewController class]]) {
        MoveTransition *transition = [[MoveTransition alloc]init];
        return transition;
    }else{
        return nil;
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
