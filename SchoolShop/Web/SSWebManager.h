//
//  SSWebManager.h
//  SchoolShop
//
//  Created by 度度度度的 on 15/1/19.
//  Copyright (c) 2015年 度度度度的. All rights reserved.
//

#import <Foundation/Foundation.h>
@class BmobObject;

@interface SSWebManager : NSObject

+ (SSWebManager *)shareHttpManage;

- (void)accessGetDicObject:(BmobObject *)object;

- (void)accessUploadImage:(NSArray *)arr;

@end
