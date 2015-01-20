//
//  SSWebManager.h
//  SchoolShop
//
//  Created by 度度度度的 on 15/1/19.
//  Copyright (c) 2015年 度度度度的. All rights reserved.
//

#import <Foundation/Foundation.h>
@class BmobObject;
@class SSInfoModel;

@interface SSWebManager : NSObject

+ (SSWebManager *)shareHttpManage;

- (SSInfoModel *)accessGetDicObject:(BmobObject *)object;

- (void)accessGetList:(NSInteger)page;

- (void)accessSaveinfo:(SSInfoModel *)model;

- (void)accessUploadImage:(NSArray *)arr withIn:(BmobObject *)object;

@end
