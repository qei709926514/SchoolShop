//
//  SSInfoModel.h
//  SchoolShop
//
//  Created by 度度度度的 on 15/1/17.
//  Copyright (c) 2015年 度度度度的. All rights reserved.
//

#import <Foundation/Foundation.h>
@class BmobObject;



@interface SSInfoModel : NSObject

@property (nonatomic,copy) NSString* objectid;
@property (nonatomic,copy) NSString* tiltle;
@property (nonatomic,copy) NSString* info;
@property (nonatomic,retain) NSMutableArray* image;
@property (nonatomic,copy) NSString* mainimage;
@property (nonatomic,assign) NSNumber* attention;
@property (nonatomic,assign) NSNumber* price;
@property (nonatomic,assign) BOOL isCP;
@property (nonatomic,assign) BOOL isW;
@property (nonatomic,copy) NSString* Kclass;
@property (nonatomic,retain) NSDate* createdAt;

- (instancetype)initWithDate:(NSDictionary *)data;
+ (instancetype)infoWithkDate:(NSDictionary *)data;



@end
