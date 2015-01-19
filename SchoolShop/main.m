//
//  main.m
//  SchoolShop
//
//  Created by 度度度度的 on 15/1/16.
//  Copyright (c) 2015年 度度度度的. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import <BmobSDK/Bmob.h>

int main(int argc, char * argv[]) {
    @autoreleasepool {
        [Bmob registerWithAppKey:@"2b6da370934215820bf9b89c30a24c31"];
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
