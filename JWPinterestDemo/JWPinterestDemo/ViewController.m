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
@interface ViewController ()
@property (nonatomic, strong) JDFPeekabooCoordinator *scrollCoordinator;
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
    
   // cell.cellData=self.stylearr[indexPath.row];
    cell.backgroundColor = [UIColor colorWithHue:( arc4random() % 256 / 256.0 )
                                                                    saturation:( arc4random() % 128 / 256.0 ) + 0.5
                                                                     brightness:( arc4random() % 128 / 256.0 ) + 0.5
                                                                       alpha:1];
    
    return cell;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(100, arc4random()%100+50);
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    SecondViewController*vc =[[SecondViewController  alloc]init];
    
    [self.navigationController pushViewController:vc animated:YES];
    //[self  presentViewController:vc animated:YES completion:nil];

    
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
        CHTCollectionViewWaterfallLayout *layout = [[CHTCollectionViewWaterfallLayout alloc] init];
        
        layout.sectionInset = UIEdgeInsetsMake(1, 10, 1, 10);
        layout.headerHeight = 0;
                layout.minimumColumnSpacing = 10;
                layout.minimumInteritemSpacing = 10;
        
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
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
   
    
     CGRect topBarFrame =  self.navigationController.navigationBar.frame;
    
    CGFloat topBarHeight = topBarFrame.size.height;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
