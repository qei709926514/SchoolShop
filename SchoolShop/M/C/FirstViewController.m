//
//  FirstViewController.m
//  SchoolShop
//
//  Created by 度度度度的 on 15/1/16.
//  Copyright (c) 2015年 度度度度的. All rights reserved.
//

#import "FirstViewController.h"
#import "SSInfoModel.h"
#import "SSWebManager.h"
#import "JKImagePickerController.h"
#import "SShelp.h"

@interface FirstViewController ()<JKImagePickerControllerDelegate>

@property (nonatomic,retain) SSInfoModel *upmodel;

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    
        SSWebManager *webManager = [SSWebManager shareHttpManage];
            [webManager accessGetList:1];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(didaccessGetList:) name:@"List" object:nil];
    
}
- (IBAction)pickImage:(UIButton *)sender {
    
    JKImagePickerController *imagePickerController = [[JKImagePickerController alloc] init];
    imagePickerController.delegate = self;
    imagePickerController.showsCancelButton = YES;
    imagePickerController.allowsMultipleSelection = YES;
    imagePickerController.minimumNumberOfSelection = 1;
    imagePickerController.maximumNumberOfSelection = 5;
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:imagePickerController];
    [self presentViewController:navigationController animated:YES completion:NULL];

}


- (void)imagePickerController:(JKImagePickerController *)imagePicker didSelectAsset:(JKAssets *)asset isSource:(BOOL)source
{
    [imagePicker dismissViewControllerAnimated:YES completion:^{
        
    }];
}
- (void)imagePickerController:(JKImagePickerController *)imagePicker didSelectAssets:(NSArray *)assets isSource:(BOOL)source
{
    
    
        
        [imagePicker dismissViewControllerAnimated:YES completion:^{
            
            [SShelp saveImage:assets];
            [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(didSaveImage:) name:@"saveI" object:nil];
        }];
    
    
}
- (void)imagePickerControllerDidCancel:(JKImagePickerController *)imagePicker
{
    [imagePicker dismissViewControllerAnimated:YES completion:^{
        
    }];
}


- (void)didaccessGetList:(NSNotification *)noti
{
    NSArray *dataArr = noti.object;
    
//     NSLog(@"%@",model);
//    self.upmodel = model;

   
}

- (void)didSaveImage:(NSNotification *)noti
{
    
    NSMutableArray *pathArr = noti.object;
    self.upmodel.image = pathArr;
    [[SSWebManager shareHttpManage]accessSaveinfo:self.upmodel];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
