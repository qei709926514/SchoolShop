//
//  SShelp.m
//  SchoolShop
//
//  Created by 度度度度的 on 15/1/20.
//  Copyright (c) 2015年 度度度度的. All rights reserved.
//

#import "SShelp.h"
#import "JKAssets.h"
#import <AssetsLibrary/ALAssetRepresentation.h>
#import "SSWebManager.h"

#define KOriginalPhotoImagePath [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"OriginalPhotoImages"]



@implementation SShelp

+ (void)saveImage:(NSArray *)arr
{
    __block int i = 0;
    NSMutableArray *pathArr = [NSMutableArray array];
    [arr enumerateObjectsUsingBlock:^(JKAssets* obj, NSUInteger idx, BOOL *stop) {
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
                    NSString * imagePath = [KOriginalPhotoImagePath stringByAppendingPathComponent:[NSString stringWithFormat:@"image%lu",idx+1]];
                    [pathArr addObject:imagePath];
                    [data writeToFile:imagePath atomically:YES];
                    if (pathArr.count == arr.count) {
                        if (!i++) {
                            NSLog(@"%lu",(unsigned long)pathArr.count);
                            [[NSNotificationCenter defaultCenter] postNotificationName:@"saveI" object:pathArr];
                        }
            }
                    
                } failureBlock:nil];
            }
            
        });
    }];
    
}

@end
