//
//  SSusrModel.h
//  SchoolShop
//
//  Created by 度度度度的 on 15/1/20.
//  Copyright (c) 2015年 度度度度的. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SSusrModel : NSObject

@property (nonatomic,copy) NSString* objectid;
@property (nonatomic,copy) NSString* name;
@property (nonatomic,copy) NSString* writed;
@property (nonatomic,copy) NSString* iconUrl;
@property (nonatomic,copy) NSString* email;
@property (nonatomic,assign) NSNumber* emailVerified;
@property (nonatomic,copy) NSString* setting;

- (instancetype)initWithDate:(NSDictionary *)data;

+ (instancetype)userWithkDate:(NSDictionary *)data;



@end
