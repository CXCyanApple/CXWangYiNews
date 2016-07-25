//
//  NewsTableViewController.h
//  cx 第九天 网易新闻01
//
//  Created by 程星的mac on 16/7/20.
//  Copyright © 2016年 chengxing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewsTableViewController : UITableViewController
//接受HomeCollectionViewCell传递过来的数据
@property(copy, nonatomic)NSString* urlstr;
@end
