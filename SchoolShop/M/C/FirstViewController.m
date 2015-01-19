//
//  FirstViewController.m
//  SchoolShop
//
//  Created by 度度度度的 on 15/1/16.
//  Copyright (c) 2015年 度度度度的. All rights reserved.
//

#import "FirstViewController.h"
#import <BmobSDK/Bmob.h>
#import "SSInfoModel.h"
#import "SSWebManager.h"

@interface FirstViewController ()

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    BmobQuery *que = [BmobQuery queryWithClassName:@"mainInfo"];
    
    [que findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        for (BmobObject *obj in array) {
            SSWebManager *webManager = [SSWebManager shareHttpManage];
            [webManager accessGetDicObject:obj];
        }
        
    }];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(didaccessGetDic:) name:@"dic" object:nil];
    
}

- (void)didaccessGetDic:(NSNotification *)noti
{
    NSDictionary *dic = noti.object;
    SSInfoModel *model = [SSInfoModel infoWithkDate:dic];
     NSLog(@"%@",model);

   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
