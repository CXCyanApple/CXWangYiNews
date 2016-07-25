//
//  HomeViewController.m
//  cx 第九天 网易新闻01
//
//  Created by 程星的mac on 16/7/20.
//  Copyright © 2016年 chengxing. All rights reserved.
//

#import "HomeViewController.h"
#import "ChannelModel.h"
#import "channelLab.h"
#import "HomeCollectionViewCell.h"
@interface HomeViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *ChannelScrollView;

@property (weak, nonatomic) IBOutlet UICollectionView *NewsCollectionView;
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *FlowLayout;
//上一个点击的lab
@property (weak, nonatomic) UILabel* nextLab;

@property (nonatomic, strong) NSMutableArray *labM;

@property(copy, nonatomic)NSArray* dataArr;

@end

@implementation HomeViewController




-(NSArray *)dataArr
{
    if (_dataArr == nil) {
        _dataArr = [ChannelModel channels];
    }
    return _dataArr;
}




-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    //设置item的大小
    self.FlowLayout.itemSize = self.NewsCollectionView.bounds.size;
    
    
}





- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    // Do any additional setup after loading the view.
    self.labM = [NSMutableArray array];
    //    NSLog(@"%@",[ChannelModel channels]);
    //sv跟nav同时使用的话,sv会往下偏移一定的距离,如果不想偏移的话,设置automaticallyAdjustsScrollViewInsets为no 也可以通过sb设置
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self creatChannelLab];
}

-(void)creatChannelLab{
    
    int LabW = 80;
    int LabH = self.ChannelScrollView.bounds.size.height;
    for (int i = 0;i < self.dataArr.count ; i ++) {
        channelLab *lab = [[channelLab alloc]init];
        //给lab设置frame
        lab.frame = CGRectMake(LabW * i, 0, LabW, LabH);
        
        if (i == 0) {
            
            lab.textColor = [UIColor redColor];
            [lab setFont:[UIFont systemFontOfSize:20.0]];
            self.nextLab = lab;
            
        }
        
        
        
        
        
        
        //获取model
        ChannelModel *model = self.dataArr[i];
        //给lab赋值
        lab.text = model.tname;
        //        //设置的lab的背景颜色
        //                lab.backgroundColor = [UIColor colorWithRed:((float)arc4random_uniform(256) / 255.0) green:((float)arc4random_uniform(256) / 255.0) blue:((float)arc4random_uniform(256) / 255.0) alpha:1.0];
        
        //给lab设置tag
        lab.tag = i;
        
        //        lab.textAlignment = NSTextAlignmentCenter;
        
        [self.ChannelScrollView addSubview:lab];
        //设置ChannelScrollView滚动fanw
        self.ChannelScrollView.contentSize = CGSizeMake(LabW *self.dataArr.count, 0);
        [self.labM addObject:lab];
        
        //给lable添加点击事件
        UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick:)];
        
        
        [lab addGestureRecognizer:tap];
        //设置lable可以点击
        lab.userInteractionEnabled = YES;
    }
    
}

//实现点击lab的方法
-(void)tapClick:(UITapGestureRecognizer*)tap{
    NSLog(@"点击新闻频道");
    
    //获取选中的lab
    
    self.nextLab.textColor = [UIColor blackColor];
    [self.nextLab setFont:[UIFont systemFontOfSize:17.0]];
    
    channelLab* lab = (channelLab *)tap.view;
    
    //计算选中的lab居中时   要滚动的偏移量
    CGFloat labOffSet = lab.center.x - self.view.bounds.size.width/2;
    
    CGFloat x = lab.bounds.size.width * self.dataArr.count - self.view.bounds.size.width;
    
    
    
    if (labOffSet < 0) {
        labOffSet = 0;
    }else if (labOffSet > x){
        
        labOffSet = x;
    }
    
    [UIView animateWithDuration:0.5 animations:^{
        self.ChannelScrollView.contentOffset = CGPointMake(labOffSet, 0);
    }];
    
    
    
    [UIView animateWithDuration:2 animations:^{
        
        lab.textColor = [UIColor redColor];
        
        [lab setFont:[UIFont systemFontOfSize:20.0]];
        
    }];
    
    self.nextLab = lab;
    
    NSInteger i = lab.tag;
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
    [self.NewsCollectionView scrollToItemAtIndexPath:indexPath atScrollPosition:0 animated:YES];
    
}
//scrollView结束滑动的时候调用的方法
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSLog(@"滑动了底部scrollView");
    NSInteger index = scrollView.contentOffset.x / scrollView.bounds.size.width;
    
    self.nextLab.textColor = [UIColor blackColor];
    
    NSLog(@"%ld",(long)index);
    
    //根据标签去找lab
    channelLab* lab = self.labM[index];
    
    //计算选中的lab居中时   要滚动的偏移量

    CGFloat labOffSet = lab.bounds.size.width * index;
    CGFloat x = lab.bounds.size.width * self.dataArr.count - self.view.bounds.size.width;
    
    
    if (labOffSet < 0) {
        labOffSet = 0;
    }else if (labOffSet > x){
        
        labOffSet = x;
    }
    
    [UIView animateWithDuration:0.5 animations:^{
        self.ChannelScrollView.contentOffset = CGPointMake(labOffSet, 0);
    }];
    
    
    
    [UIView animateWithDuration:2 animations:^{
        
        lab.textColor = [UIColor redColor];
        
        [lab setFont:[UIFont systemFontOfSize:20]];
        
    }];
    
    self.nextLab = lab;
//
//    NSInteger i = lab.tag;
//    
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:index inSection:0];
    [self.NewsCollectionView scrollToItemAtIndexPath:indexPath atScrollPosition:0 animated:YES];



    
    
  
    
    
    
    

}


#pragma mark CollectionView数据源方法

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    
    return self.dataArr.count;
    
}


//HomeViewController -> HomeCollectionViewCell - >NewsTableViewController ->NewsModel
-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    HomeCollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HomeCollectionCell" forIndexPath:indexPath];
    //    cell.backgroundColor = [UIColor colorWithRed:((float)arc4random_uniform(256) / 255.0) green:((float)arc4random_uniform(256) / 255.0) blue:((float)arc4random_uniform(256) / 255.0) alpha:1.0];
    
    //    NSLog(@"%ld",(long)indexPath.row);
    ChannelModel* model = self.dataArr[indexPath.item];
    //    NSLog(@"%@",model.tid);
    
    NSString* urlstr = [NSString stringWithFormat:@"article/list/%@/0-20.html",model.tid];
    cell.urlstr = urlstr;
    return cell;
    
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
