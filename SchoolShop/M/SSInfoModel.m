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


- (instancetype)initWithDate:(BmobObject *)data
{
    if (self = [super init]) {
        self.objectid = data.objectId;
        self.tiltle = [data objectForKey:@"tiltle"];
        self.info = [data objectForKey:@"info"];
        BmobFile *flie = [data objectForKey:@"mainImage"];
        self.mainimage = flie.url;
        self.attention = [data objectForKey:@"attention"];
        self.price = [data objectForKey:@"price"];
        self.isCP = [data objectForKey:@"isCP"];
        self.isW = [data objectForKey:@"isW"];
        self.Kclass = [data objectForKey:@"class"];
        
        self.createdAt = data.createdAt;
    }
    return self;
}

+ (instancetype)infoWithkDate:(BmobObject *)data
{
    SSInfoModel *info = [[SSInfoModel alloc]initWithDate:data];
    return info;
}

@end
