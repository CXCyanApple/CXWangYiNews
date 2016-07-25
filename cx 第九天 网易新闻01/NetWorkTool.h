//
//  NetWorkTool.h
//  cx 第九天 网易新闻01
//
//  Created by 程星的mac on 16/7/20.
//  Copyright © 2016年 chengxing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>
@interface NetWorkTool : AFHTTPSessionManager
+(instancetype)sharedNetWorkTool;
@end
