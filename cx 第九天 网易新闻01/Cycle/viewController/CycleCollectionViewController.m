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
//创建pageControl
@property(strong, nonatomic)UIPageControl* pageControl;

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
    //下载图片数据
   [self loadCycleModelData];
    
    //创建一个pageControl
    [self createPageControl];
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    
    
}

-(void)createPageControl{
    
    self.pageControl = [[UIPageControl alloc]init];
    
    
    
    
    
    
    [self.view addSubview:self.pageControl];
    
    //设置选中的颜色
    self.pageControl.currentPageIndicatorTintColor = [UIColor redColor];
    
    
    //设置未被选中的颜色
    self.pageControl.pageIndicatorTintColor  = [UIColor blueColor];
    
    



}

//下载数据
- (void)loadCycleModelData{
    
    [CycleModel loadCycleDataWithUrlstr:@"ad/headline/0-4.html" successBlock:^(NSArray *listArr) {
        
        self.dataArr = listArr;
        //刷新ui
        [self.collectionView reloadData];
        
        
        //设置pageControl
        //设置个数
        self.pageControl.numberOfPages = self.dataArr.count;
        
        //设置位置和大小
        CGSize pageControlSize = [self.pageControl sizeForNumberOfPages:self.dataArr.count];
        
        CGFloat pageControlX = self.view.bounds.size.width - pageControlSize.width - 10;
        
        CGFloat pageControlH = self.view.bounds.size.height - pageControlSize.height;
        
        self.pageControl.frame = CGRectMake(pageControlX, pageControlH, pageControlSize.width, pageControlSize.height);
        
        NSIndexPath* indexPath = [NSIndexPath indexPathForItem:self.dataArr.count inSection:0];
        [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:0 animated:NO];
        
        
        
    } failBlock:^(NSError *error) {
        NSLog(@"error %@",error);
    }];
}
//scrollView结束滑动的时候调用的方法
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
//    NSLog(@"%f",scrollView.contentOffset.x);

    NSInteger index = scrollView.contentOffset.x / self.view.bounds.size.width;
    
    self.pageControl.currentPage = index % self.dataArr.count;

    if (index == 7) {
        [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:3 inSection:0] atScrollPosition:0 animated:NO];
        
        
    }else if( index == 0){
        
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:4 inSection:0] atScrollPosition:0 animated:NO];
    
    }



}



#pragma mark <UICollectionViewDataSource>




- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArr.count * 2;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CycleCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CycleCell" forIndexPath:indexPath];
    
//    cell.backgroundColor = [UIColor redColor];
    
    //获取model
    CycleModel *model = self.dataArr[indexPath.item % self.dataArr.count];
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
