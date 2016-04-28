//
//  SecondViewController.h
//  JWPinterestDemo
//
//  Created by Vinhome on 16/4/22.
//  Copyright © 2016年 JW. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CHTCollectionViewWaterfallLayout.h"
#import "Masonry.h"
#import "JWCollectionCell.h"
#import "DropDownTransition.h"
#import "ViewController.h"
@interface SecondViewController : UIViewController<UICollectionViewDelegate,UICollectionViewDataSource,CHTCollectionViewDelegateWaterfallLayout>
@property (strong, nonatomic) UICollectionView *collectionView;

@property (strong, nonatomic) NSMutableArray *dataArr;
@property (assign, nonatomic) CGRect itemStartFrame;

@property (strong, nonatomic) UICollectionView *sourceCollectionView;

@property(nonatomic,strong)UICollectionViewCell *selectedCell;
@property(nonatomic,strong)NSIndexPath *pageindex;

@end
