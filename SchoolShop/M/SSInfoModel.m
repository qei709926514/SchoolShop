//
//  SSInfoModel.m
//  SchoolShop
//
//  Created by 度度度度的 on 15/1/17.
//  Copyright (c) 2015年 度度度度的. All rights reserved.
//

#import "SSInfoModel.h"
#import <BmobSDK/Bmob.h>

@implementation SSInfoModel

@synthesize objectid = _objectid;
@synthesize tiltle = _tiltle;
@synthesize info = _info;
@synthesize image = _image;
@synthesize mainimage = _mainimage;
@synthesize attention = _attention;
@synthesize price = _price;
@synthesize isCP = _isCP;
@synthesize isW = _isW;
@synthesize Kclass = _Kclass;
@synthesize createdAt = _createdAt;


- (instancetype)initWithDate:(NSDictionary *)data
{
    if (self = [super init]) {
    
        [self setValuesForKeysWithDictionary:data];
    }
    return self;
}

+ (instancetype)infoWithkDate:(NSDictionary *)data
{
    SSInfoModel *info = [[SSInfoModel alloc]initWithDate:data];
    return info;
}

@end
