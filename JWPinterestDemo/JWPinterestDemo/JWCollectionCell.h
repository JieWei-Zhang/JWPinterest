//
//  JWCollectionViewCell.h
//  JWPinterestDemo
//
//  Created by Vinhome on 16/4/25.
//  Copyright © 2016年 JW. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^JWPullDownAction)(CGPoint offset);
@interface JWCollectionCell : UICollectionViewCell<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, copy) JWPullDownAction pullDownAction;
@property (strong, nonatomic)  UIView *bgView;
@property (strong, nonatomic)  UITableView *tableView;
@property (strong, nonatomic)  UIImageView *imgView;

@property (assign, nonatomic) CGRect imgViewHeight;
@end
