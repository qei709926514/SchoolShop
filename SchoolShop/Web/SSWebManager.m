//
//  SSWebManager.m
//  SchoolShop
//
//  Created by 度度度度的 on 15/1/19.
//  Copyright (c) 2015年 度度度度的. All rights reserved.
//

#import "SSWebManager.h"
#import <BmobSDK/Bmob.h>
#import "SSInfoModel.h"
#import "SSusrModel.h"

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


- (void)Login:(NSString *)username password:(NSString *)password
{
    [BmobUser loginWithUsernameInBackground:username password:password block:^(BmobUser *user, NSError *error) {
        SSusrModel *model = [self accessGetUserInfo:user];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"Login" object:model];
    }];
}


- (SSusrModel *)accessGetUserInfo:(BmobUser *)user
{
    NSMutableDictionary *userDic = [NSMutableDictionary dictionary];
    [userDic setObject:user.objectId forKey:@"objectid"];
    [userDic setObject:[user objectForKey:@"name"] forKey:@"name"];
    [userDic setObject:[user objectForKey:@"writed"] forKey:@"writed"];
    [userDic setObject:[user objectForKey:@"email"] forKey:@"email"];
    [userDic setObject:[user objectForKey:@"emailVerified"] forKey:@"emailVerified"];
    BmobFile *icon = [user objectForKey:@"icon"];
    [userDic setObject:icon.url forKey:@"icon"];
    BmobFile *setting = [user objectForKey:@"setting"];
    [userDic setObject:setting.url forKey:@"setting"];
    SSusrModel *model = [SSusrModel userWithkDate:userDic];
    return model;
}



- (void)accessGetList:(NSInteger)page
{
    BmobQuery *que = [BmobQuery queryWithClassName:@"mainInfo"];
    que.limit = 10;
    que.skip = page*10-10;
    [que includeKey:@"image,FBZ"];

    [que findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        NSMutableArray *arrData = [NSMutableArray array];
        for (BmobObject *obj in array) {
            [arrData addObject:[self accessGetDicObject:obj]];
            if (arrData.count == array.count ) {
               [[NSNotificationCenter defaultCenter] postNotificationName:@"List" object:arrData];
            }
        }
    }];

}


- (SSInfoModel *)accessGetDicObject:(BmobObject *)object
{
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    
    [dic setObject:object.objectId forKey:@"objectid"];
    [dic setObject:[object objectForKey:@"tiltle"] forKey:@"tiltle"];
    [dic setObject:[object objectForKey:@"info"] forKey:@"info"];
    [dic setObject:[object objectForKey:@"attention"] forKey:@"attention"];
    [dic setObject:[object objectForKey:@"price"] forKey:@"price"];
    [dic setObject:[object objectForKey:@"isCP"] forKey:@"isCP"];
    [dic setObject:[object objectForKey:@"isW"] forKey:@"isW"];
    [dic setObject:[object objectForKey:@"class"] forKey:@"Kclass"];
    [dic setObject:object.createdAt forKey:@"createdAt"];
    BmobObject *FBZ = [object objectForKey:@"FBZ"];
    [dic setObject:FBZ.objectId forKey:@"FBZid"];

    BmobObject *imageO = [object objectForKey:@"image"];
    NSMutableArray *imageArr = [NSMutableArray array];
    for (NSInteger k = 1; k < 6; k++) {
        NSString *key = [NSString stringWithFormat:@"image%ld", (long)k];
        BmobFile *ima = [imageO objectForKey:key];
        if (ima) {
            [imageArr addObject:ima.url];
        }
    }
    [dic setObject:imageArr forKey:@"image"];
    SSInfoModel *model = [SSInfoModel infoWithkDate:dic];
    return model;
 }

- (void)accessSaveinfo:(SSInfoModel *)model
{
    BmobObject *info = [BmobObject objectWithClassName:@"mainInfo"];
    [info setObject:model.tiltle forKey:@"tiltle"];
    [info setObject:model.info forKey:@"info"];
    [info setObject:model.attention forKey:@"attention"];
    [info setObject:model.price forKey:@"price"];
    [info setObject:model.isCP forKey:@"isCP"];
    [info setObject:model.isW forKey:@"isW"];
    [info setObject:model.Kclass forKey:@"class"];
    [info saveInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
        if (isSuccessful) {
            NSLog(@"%@",info.objectId);
            [self accessUploadImage:model.image withIn:info];
        }
        

    }];
        
}



- (void)accessUploadImage:(NSArray *)arr withIn:(BmobObject *)object
{
    [BmobFile filesUploadBatchWithPaths:arr progressBlock:^(int index, float progress) {
        
    } resultBlock:^(NSArray *array, BOOL isSuccessful, NSError *error) {
        BmobObject *obj = [[BmobObject alloc]initWithClassName:@"image"];
        [array enumerateObjectsUsingBlock:^(BmobFile *file, NSUInteger idx, BOOL *stop) {
            [obj setObject:file forKey:[NSString stringWithFormat:@"image%lu",idx+1]];
        }];
        [obj setObject:object forKey:@"in"];
        [obj saveInBackground];
    }];
}




@end
