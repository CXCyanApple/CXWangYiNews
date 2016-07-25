//
//  HomeCollectionViewCell.m
//  cx 第九天 网易新闻01
//
//  Created by 程星的mac on 16/7/20.
//  Copyright © 2016年 chengxing. All rights reserved.
//

#import "HomeCollectionViewCell.h"
#import "NewsTableViewController.h"
@interface HomeCollectionViewCell()

@property(strong, nonatomic) NewsTableViewController *newsVC;

@end


@implementation HomeCollectionViewCell

-(void)awakeFromNib{

//    NSLog(@"%s",__func__);
//
//  self.backgroundColor = [UIColor colorWithRed:((float)arc4random_uniform(256) / 255.0) green:((float)arc4random_uniform(256) / 255.0) blue:((float)arc4random_uniform(256) / 255.0) alpha:1.0];

    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"News" bundle:nil];
    
    self.newsVC = [storyboard instantiateInitialViewController];
    
    self.newsVC.tableView.frame = self.contentView.bounds;
    
    self.newsVC.tableView.backgroundColor = [UIColor colorWithRed:((float)arc4random_uniform(256) / 255.0) green:((float)arc4random_uniform(256) / 255.0) blue:((float)arc4random_uniform(256) / 255.0) alpha:1.0];
    [self addSubview:self.newsVC.tableView];
    
}

-(void)setUrlstr:(NSString *)urlstr{
    
    
    _urlstr = urlstr;
    self.newsVC.urlstr = urlstr;
    
    

    
    
    



}







@end
