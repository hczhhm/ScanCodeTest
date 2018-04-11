//
//  ScanCodeViewController.h
//  FrameworkObj
//
//  Created by walter_air on 15/7/3.

#import <UIKit/UIKit.h>

@interface ScanCodeViewController : UIViewController
@property (nonatomic, copy) void (^SYQRCodeCancleBlock) (ScanCodeViewController *);//扫描取消
@property (nonatomic, copy) void (^SYQRCodeSuncessBlock) (ScanCodeViewController *,NSString *);//扫描结果
@property (nonatomic, copy) void (^SYQRCodeFailBlock) (ScanCodeViewController *);//扫描失败
+(UIImage *)qrImageForString:(NSString *)string imageSize:(CGFloat)Imagesize logoImageSize:(CGFloat)waterImagesize;/**<生成二维码*/
+(NSString *)codeFormImage:(UIImage *)image;//图片识别
@end
