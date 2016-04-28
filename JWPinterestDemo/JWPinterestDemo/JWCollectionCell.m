//
//  JWCollectionViewCell.m
//  JWPinterestDemo
//
//  Created by Vinhome on 16/4/25.
//  Copyright © 2016年 JW. All rights reserved.
//

#import "JWCollectionCell.h"
#import "masonry.h"
@implementation JWCollectionCell
@synthesize imgView=_imgView;
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor=[UIColor  blackColor];
        [self  setupSubViews];
    }
    return self;
}
-(void)setupSubViews
{
    [self.contentView addSubview:self.bgView];
    [self.bgView  addSubview:self.imgView];
    [self.bgView  addSubview:self.tableView];
    
    [self.bgView mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        make.top.and.bottom.equalTo(self.contentView);
        make.left.equalTo(self.contentView.mas_left).with.offset(10);
        make.right.equalTo(self.contentView.mas_right).with.offset(-10);
    }];
    
    [self.imgView mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        make.top.and.left.equalTo(self.bgView).with.offset(20);
        
        make.right.equalTo(self.bgView.mas_right).with.offset(-20);
         make.height.equalTo(@200);
    }];
    
    [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imgView.mas_bottom);
        make.bottom.and.left.and.right.equalTo(self.bgView);
    }];
    
}

-(void)setImgViewHeight:(CGRect)imgViewHeight
{
    [self.imgView mas_remakeConstraints:^(MASConstraintMaker *make) {
         make.top.and.left.equalTo(self.bgView).with.offset(20);
        
        make.right.equalTo(self.bgView.mas_right).with.offset(-20);
        make.height.equalTo(@0).with.offset(CGRectGetHeight(imgViewHeight));
    }];
    
    NSLog(@"_______%f",CGRectGetHeight(imgViewHeight));
}
-(UIView *)bgView
{
    if (!_bgView) {
        _bgView=[[UIView  alloc]init];
        _bgView.backgroundColor=[UIColor colorWithHue:( arc4random() % 256 / 256.0 )
                                            saturation:( arc4random() % 128 / 256.0 ) + 0.5
                                            brightness:( arc4random() % 128 / 256.0 ) + 0.5
                                                 alpha:1];

        _bgView.layer.cornerRadius=10;
        _bgView.clipsToBounds=YES;
    }
    return _bgView;
}

-(UIView *)imgView
{
    if (!_imgView) {
        _imgView=[[UIImageView  alloc]initWithFrame:self.bounds];
        _imgView.backgroundColor=[UIColor  redColor];
    }
    return _imgView;
}
-(UITableView *)tableView
{
    if (!_tableView) {
        _tableView =[[UITableView  alloc]initWithFrame:self.bounds style:UITableViewStylePlain];

        _tableView.delegate=self;
        _tableView.dataSource=self;
    }
    return _tableView;
}
-(void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
    if (-scrollView.contentOffset.y > 64) {
        if (self.pullDownAction) {
            self.pullDownAction(scrollView.contentOffset);
        }
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIndef =@"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndef];
    if (!cell)
    {
        
        cell=[[UITableViewCell  alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndef];
    }
    
    
    return cell;
}
@end
