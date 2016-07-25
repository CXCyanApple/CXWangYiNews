//
//  NetWorkTool.m
//  cx 第九天 网易新闻01
//
//  Created by 程星的mac on 16/7/20.
//  Copyright © 2016年 chengxing. All rights reserved.
//

#import "NetWorkTool.h"
#import <AFNetworking.h>
@implementation NetWorkTool

static id _instancetype;
+(instancetype)sharedNetWorkTool{
    
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        NSURL* baseurl = [NSURL URLWithString:@"http://c.m.163.com/nc/"];
        _instancetype = [[self alloc]initWithBaseURL:baseurl];
     });


    return _instancetype;


}
@end
