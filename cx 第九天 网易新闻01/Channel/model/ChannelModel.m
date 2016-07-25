//
//  ChannelModel.m
//  cx 第九天 网易新闻01
//
//  Created by 程星的mac on 16/7/20.
//  Copyright © 2016年 chengxing. All rights reserved.
//

#import "ChannelModel.h"

@implementation ChannelModel


-(NSString*)description{

    return [NSString stringWithFormat:@"%@  %@",_tid,_tname];

}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
}



+(instancetype)channelWithDic:(NSDictionary *)dic
{
    ChannelModel *model = [[ChannelModel alloc]init];
    //kvc
    [model setValuesForKeysWithDictionary:dic];
    return model;
}





+(NSArray *)channels{

//获取json文件路径
    NSString *path = [[NSBundle mainBundle]pathForResource:@"topic_news.json" ofType:nil];

//将json转化成二进制
    NSData * data = [NSData dataWithContentsOfFile:path];
    
    //反序列化
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    
    
    //取出tList 相对应的数组
    
    NSArray* arr = [dic objectForKey:@"tList"];

//创建一个可遍数组
    NSMutableArray* arrM = [NSMutableArray arrayWithCapacity:arr.count];
    
    //遍历数组
    [arr enumerateObjectsUsingBlock:^(NSDictionary* obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        
        ChannelModel* model = [self channelWithDic:obj];
        [arrM addObject:model];
        
        
        
    }];
    
    
    //排序
    [arrM sortUsingComparator:^NSComparisonResult(ChannelModel * obj1, ChannelModel * obj2) {
        return [obj1.tid compare:obj2.tid];
    }];
    
    
    return arrM.copy;



}










@end
