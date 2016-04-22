//
//  SecondViewController.m
//  JWPinterestDemo
//
//  Created by Vinhome on 16/4/22.
//  Copyright © 2016年 JW. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()<UINavigationControllerDelegate,UIGestureRecognizerDelegate>

@end

@implementation SecondViewController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    self.navigationController.navigationBarHidden=YES;
    
}

#pragma mark - UINavigationController Delegate
-(void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if ([navigationController   respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        navigationController.interactivePopGestureRecognizer.enabled = YES;
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.delegate = self;
        self.navigationController.interactivePopGestureRecognizer.delegate = self;
    self.automaticallyAdjustsScrollViewInsets=YES;
    [self.view  addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.and.bottom.and.top.equalTo(self.view);
    }];
    
    self.collectionView.backgroundColor=[UIColor blackColor];
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
    
    // cell.cellData=self.stylearr[indexPath.row];
    cell.backgroundColor = [UIColor colorWithHue:( arc4random() % 256 / 256.0 )
                                      saturation:( arc4random() % 128 / 256.0 ) + 0.5
                                      brightness:( arc4random() % 128 / 256.0 ) + 0.5
                                           alpha:1];
    
    return cell;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(self.view.bounds.size.width, self.view.bounds.size.height);
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
      
}


-(NSMutableDictionary *)dataArr
{
    if (!_dataArr) {
        _dataArr =[[NSMutableDictionary  alloc]init];
    }
    return _dataArr;
}
- (UICollectionView *)collectionView {
    if (!_collectionView) {
      
        UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc] init];
        [layout setItemSize:self.view.frame.size];
        layout.scrollDirection=UICollectionViewScrollDirectionHorizontal;
        layout.minimumInteritemSpacing=0;
        layout.minimumLineSpacing=10;
        layout.itemSize =CGSizeMake(self.view.bounds.size.width, self.view.bounds.size.height);
        
        layout.sectionInset = UIEdgeInsetsMake(0,0, 0,0);
        
        _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
        _collectionView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        _collectionView.showsHorizontalScrollIndicator=NO;
        _collectionView.showsVerticalScrollIndicator=NO;
        _collectionView.alwaysBounceVertical=YES;
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.backgroundColor =[UIColor whiteColor];
        //_collectionView.contentInset=UIEdgeInsetsMake(64, 0, 49, 0);
        
        //[_collectionView registerNib:[UINib nibWithNibName:@"StyleCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"StyleCollectionViewCell"];
        
        [_collectionView  registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
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
