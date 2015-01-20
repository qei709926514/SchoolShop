//
//  SSusrModel.m
//  SchoolShop
//
//  Created by 度度度度的 on 15/1/20.
//  Copyright (c) 2015年 度度度度的. All rights reserved.
//

#import "SSusrModel.h"

@implementation SSusrModel
@synthesize objectid = _objectid;
@synthesize name = _name;
@synthesize writed = _writed;
@synthesize iconUrl = _iconUrl;
@synthesize email = _email;
@synthesize emailVerified = _emailVerified;
@synthesize setting = _setting;


- (instancetype)initWithDate:(NSDictionary *)data
{
    if (self = [super init]) {
        
        [self setValuesForKeysWithDictionary:data];
    }
    return self;
}

+ (instancetype)userWithkDate:(NSDictionary *)data
{
    SSusrModel *user = [[SSusrModel alloc]initWithDate:data];
    return user;
}

@end
