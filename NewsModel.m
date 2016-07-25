//
//  NewsModel.m
//  cx 第九天 网易新闻01
//
//  Created by 程星的mac on 16/7/20.
//  Copyright © 2016年 chengxing. All rights reserved.
//

#import "NewsModel.h"
#import "NetWorkTool.h"
@implementation NewsModel
//-(void)download{

//[NetWorkTool sharedNetWorkTool]GET:<#(nonnull NSString *)#> parameters:<#(nullable id)#> progress:<#^(NSProgress * _Nonnull downloadProgress)downloadProgress#> success:<#^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)success#> failure:<#^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)failure#>

//}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
}
+(instancetype)NewsModelWithDic:(NSDictionary *)dic
{
    NewsModel *model = [[NewsModel alloc]init];
    [model setValuesForKeysWithDictionary:dic];
    return model;
}

+(void)downloadWithUrlstr:(NSString *)urlstr successBlock:(void(^)(NSArray *arr))successBlock failureBlock:(void(^)(NSError *error))failureBlock{
    
    [[NetWorkTool sharedNetWorkTool]GET:urlstr parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
//        NSLog(@"%@",responseObject);
        NSDictionary* dic = responseObject;
        NSString* key = dic.keyEnumerator.nextObject;
        
        NSArray *arr = [dic objectForKey:key];
        //可变数组
        NSMutableArray *arrM = [NSMutableArray arrayWithCapacity:arr.count];
        

        
        
        //遍历arr
        [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NewsModel *model = [self NewsModelWithDic:obj];
            [arrM addObject:model];
        }];
        
        if (successBlock) {
            successBlock(arrM.copy);
        }
        

        
        
        
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
       
        
        
        
        
    }];
    
    
    
    
    


}






@end
