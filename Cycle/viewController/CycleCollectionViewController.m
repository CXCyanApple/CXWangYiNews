//
//  CycleCollectionViewController.m
//  01-网易新闻架构搭建
//
//  Created by apple on 16/7/21.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "CycleCollectionViewController.h"
#import "CycleModel.h"
#import "CycleCollectionViewCell.h"


@interface CycleCollectionViewController ()
//数据接收
@property (nonatomic, strong) NSArray *dataArr;
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *FlowLayout;

@end

@implementation CycleCollectionViewController

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    //设置cell的大小
    self.FlowLayout.itemSize = self.collectionView.bounds.size;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
   
    
    [self loadCycleModelData];
}
//下载数据
- (void)loadCycleModelData{
    
    [CycleModel loadCycleDataWithUrlstr:@"ad/headline/0-4.html" successBlock:^(NSArray *listArr) {
        
        self.dataArr = listArr;
        //刷新ui
        [self.collectionView reloadData];
        
    } failBlock:^(NSError *error) {
        NSLog(@"error %@",error);
    }];
}
#pragma mark <UICollectionViewDataSource>




- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CycleCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CycleCell" forIndexPath:indexPath];
    
//    cell.backgroundColor = [UIColor redColor];
    
    //获取model
    CycleModel *model = self.dataArr[indexPath.item];
    cell.model = model;
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
