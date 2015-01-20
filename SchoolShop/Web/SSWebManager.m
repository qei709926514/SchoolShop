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
#import "JKAssets.h"
#import <AssetsLibrary/ALAssetRepresentation.h>
#define KOriginalPhotoImagePath [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"OriginalPhotoImages"]

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
                NSString *key = [NSString stringWithFormat:@"image%ld",(long)k];
                BmobFile *ima = [image objectForKey:key];
                [imageArr addObject:ima.url];
            }
        
       [dic setObject:imageArr forKey:@"image"];
      
        [[NSNotificationCenter defaultCenter] postNotificationName:@"dic" object:dic];
   
    }];
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
    
    BmobFile *mainImage = [[BmobFile alloc]initWithClassName:@"mainInfo" withFilePath:model.mainimage];
    if ([mainImage save]) {
        [info setObject:mainImage forKey:@"mainimage"];
    }
}

- (void)accessUploadImage:(NSArray *)arr
{
    
    
//    [arr enumerateObjectsUsingBlock:^(JKAssets* obj, NSUInteger idx, BOOL *stop) {
    JKAssets* obj = [arr firstObject];
        ALAssetsLibrary *ass = [[ALAssetsLibrary alloc]init];
        
        NSFileManager * fileManager = [NSFileManager defaultManager];
        if (![fileManager fileExistsAtPath:KOriginalPhotoImagePath]) {
            [fileManager createDirectoryAtPath:KOriginalPhotoImagePath withIntermediateDirectories:YES attributes:nil error:nil];
        }
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            if (obj.groupPropertyURL) {
                [ass assetForURL:obj.assetPropertyURL resultBlock:^(ALAsset *asset) {
                    
                    ALAssetRepresentation *rep = [asset defaultRepresentation];
                    Byte *buffer = (Byte*)malloc((unsigned long)rep.size);
                    NSUInteger buffered = [rep getBytes:buffer fromOffset:0.0 length:((unsigned long)rep.size) error:nil];
                    NSData *data = [NSData dataWithBytesNoCopy:buffer length:buffered freeWhenDone:YES];
                    NSString * imagePath = [KOriginalPhotoImagePath stringByAppendingPathComponent:@"image1"];
                    [data writeToFile:imagePath atomically:YES];
                    NSLog(@"%@",imagePath);
                    BmobFile *bmobfile = [[BmobFile alloc]initWithClassName:@"image" withFilePath:imagePath];
                    [bmobfile saveInBackground:^(BOOL isSuccessful, NSError *error) {
                        if (isSuccessful) {
                            BmobObject *obj = [[BmobObject alloc] initWithClassName:@"image"];
                            [obj setObject:bmobfile forKey:@"image1"];
                            [obj saveInBackground];
                        }
                    }];

                } failureBlock:nil];
            }
        
            });
  
    
}




@end
