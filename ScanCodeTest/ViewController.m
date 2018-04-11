//
//  ViewController.m
//  ScanCodeTest
//
//  Created by 51dgwmac1 on 2018/4/10.
//  Copyright © 2018年 51DGW. All rights reserved.
//

#import "ViewController.h"
#import "ScanCodeViewController.h"
@interface ViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property(nonatomic,strong)UIImageView *codeImg;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.title = @"二维码";
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(20, 100, 50, 35)];
    [self.view addSubview:btn];
    [btn setTitle:@"扫描" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(scanAction) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    UIButton *creatbtn = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 100, 35)];
    [self.view addSubview:creatbtn];
    [creatbtn setTitle:@"生成二维码" forState:UIControlStateNormal];
    [creatbtn addTarget:self action:@selector(creatbtnAction) forControlEvents:UIControlEventTouchUpInside];
    [creatbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    UIButton *readbtn = [[UIButton alloc] initWithFrame:CGRectMake(220, 100, 80, 35)];
    [self.view addSubview:readbtn];
    [readbtn setTitle:@"读取图片" forState:UIControlStateNormal];
    [readbtn addTarget:self action:@selector(readbtnAction) forControlEvents:UIControlEventTouchUpInside];
    [readbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
}
-(void)scanAction{
    ScanCodeViewController *ScanCodeView = [[ScanCodeViewController alloc] init];
    ScanCodeView.SYQRCodeSuncessBlock = ^(ScanCodeViewController *aqrvc,NSString *qrString){
        //替换特定位置数据
        
        if (qrString == nil || [qrString isEqualToString:@""]) {
            //            [self alertMethod:@"您的二维码有误"];
            return ;
        }
        UIAlertView *aletview = [[UIAlertView alloc] initWithTitle:@"扫描结果" message:qrString delegate:self cancelButtonTitle:@"关闭" otherButtonTitles:nil, nil];
        [aletview show];
        [aqrvc dismissViewControllerAnimated:NO completion:nil];
    };
    ScanCodeView.SYQRCodeFailBlock = ^(ScanCodeViewController *aqrvc){
        
        
        [aqrvc dismissViewControllerAnimated:NO completion:nil];
    };
    ScanCodeView.SYQRCodeCancleBlock = ^(ScanCodeViewController *aqrvc){
        [aqrvc dismissViewControllerAnimated:NO completion:nil];
        
    };
    [self presentViewController:ScanCodeView animated:YES completion:nil];
}
-(void)creatbtnAction{
    self.codeImg.image = [ScanCodeViewController qrImageForString:@"12345678" imageSize:150 logoImageSize:30];
}

-(UIImageView *)codeImg{
    if (!_codeImg) {
        _codeImg = [[UIImageView alloc] initWithFrame:CGRectMake(100, 200, 150, 150)];
        [self.view addSubview:self.codeImg];
    }
    
    return _codeImg;
}
-(void)readbtnAction{
    //相册可用
    if([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypePhotoLibrary])
    {
        if (@available(iOS 11.0, *)) {
            [[UIScrollView appearance] setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentAutomatic];
        }
        UIImagePickerController *imgPicker = [[UIImagePickerController alloc] init];
//        [imgPicker setAllowsEditing:YES];
        [imgPicker setDelegate:self];
        [imgPicker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
        [self.navigationController presentViewController:imgPicker animated:YES completion:nil];
    }
    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(nullable NSDictionary<NSString *,id> *)editingInfo {
    
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    if(picker) {
        UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
        NSString *qrString = [ScanCodeViewController codeFormImage:image];
        UIAlertView *aletview = [[UIAlertView alloc] initWithTitle:@"识别结果" message:qrString delegate:self cancelButtonTitle:@"关闭" otherButtonTitles:nil, nil];
        [aletview show];
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        if (@available(iOS 11.0, *)) {
            [[UIScrollView appearance] setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentNever];
        }
        [picker dismissViewControllerAnimated:NO completion:^(void){
            
        }];
    });
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    if (@available(iOS 11.0, *)) {
        [[UIScrollView appearance] setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentNever];
    }
     dispatch_async(dispatch_get_main_queue(), ^{
        [picker dismissViewControllerAnimated:NO completion:nil];
    });
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
