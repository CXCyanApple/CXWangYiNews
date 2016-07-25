//
//  NewsTableViewController.m
//  cx 第九天 网易新闻01
//
//  Created by 程星的mac on 16/7/20.
//  Copyright © 2016年 chengxing. All rights reserved.
//

#import "NewsTableViewController.h"
#import "NewsModel.h"
#import "NewsTableViewCell.h"
@interface NewsTableViewController ()

@property(strong, nonatomic)NSArray* dataArr;


@end

@implementation NewsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

-(void)setUrlstr:(NSString *)urlstr{

//    NSLog(@"%@",urlstr);
    [NewsModel downloadWithUrlstr:urlstr successBlock:^(NSArray *arr) {
        
        [self.tableView reloadData];
        
//        NSLog(@"arr %@",arr);
        
        //给dataA赋值
        self.dataArr = arr;
        //刷新表格
        [self.tableView reloadData];
        
    } failureBlock:^(NSError *error) {
        
        
//        NSLog(@"error %@",error);
    
    }];

}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NewsModel* model = self.dataArr[indexPath.row];
    
    if (model.imgType) {
        return 180;
    }else if (model.imgextra.count == 2){
    
        return 150;
        
    }else{
    
        return 80;
    
    }
    
    
  
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NewsModel* model = self.dataArr[indexPath.row];
    
    NSString* identifier ;
    
    if (model.imgType) {
        identifier = @"BigCell";
    }else if(model.imgextra.count == 2){
        
    identifier = @"ImagesCell";
    
    }else{
    
    identifier = @"BaseCell";
        
    }

    
    
    
    
    
    

    NewsTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    
    
    
//    cell.textLabel.text = model.title;
    
    cell.model = model;
    
    return cell;
}















@end
