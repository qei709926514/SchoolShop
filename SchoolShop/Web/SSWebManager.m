//
//  SSWebManager.m
//  SchoolShop
//
//  Created by 度度度度的 on 15/1/19.
//  Copyright (c) 2015年 度度度度的. All rights reserved.
//

#import "SSWebManager.h"
#import <BmobSDK/Bmob.h>

static SSWebManager *WebManger;

@implementation SSWebManager

+ (SSWebManager *)shareHttpManage
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        WebManger = [[super allocWithZone:NULL] init];
    });
    return WebManger;
}

- (void)accessGetDicObject:(BmobObject *)object
{
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    
    [dic setObject:object.objectId forKey:@"objectid"];
    [dic setObject:[object objectForKey:@"tiltle"] forKey:@"tiltle"];
    [dic setObject:[object objectForKey:@"info"] forKey:@"info"];
    BmobFile *flie = [object objectForKey:@"mainImage"];
    [dic setObject:flie.url forKey:@"mainimage"];
    [dic setObject:[object objectForKey:@"attention"] forKey:@"attention"];
    [dic setObject:[object objectForKey:@"price"] forKey:@"price"];
    [dic setObject:[object objectForKey:@"isCP"] forKey:@"isCP"];
    [dic setObject:[object objectForKey:@"isW"] forKey:@"isW"];
    [dic setObject:[object objectForKey:@"class"] forKey:@"Kclass"];
    [dic setObject:object.createdAt forKey:@"createdAt"];
    BmobQuery *bquery = [BmobQuery queryWithClassName:@"image"];
    [bquery whereKey:@"in" equalTo:object];
    [bquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        
       NSMutableArray *imageArr = [NSMutableArray array];
        BmobObject *image = [array firstObject];
            for (NSInteger k = 1; k<6; k++) {
                NSString *key = [NSString stringWithFormat:@"image%d",k];
                BmobFile *ima = [image objectForKey:key];
                [imageArr addObject:ima.url];
            }
        
       [dic setObject:imageArr forKey:@"image"];
      
        [[NSNotificationCenter defaultCenter] postNotificationName:@"dic" object:dic];
   
    }];
    
}




@end
