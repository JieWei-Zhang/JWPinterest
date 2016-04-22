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
@interface SecondViewController : UIViewController<UICollectionViewDelegate,UICollectionViewDataSource,CHTCollectionViewDelegateWaterfallLayout>
@property (strong, nonatomic) UICollectionView *collectionView;

@property (strong, nonatomic) NSMutableDictionary *dataArr;

@end
