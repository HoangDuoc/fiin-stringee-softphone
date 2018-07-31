//
//  SigninViewController.m
//  Softphone
//
//  Created by Hoang Duoc on 7/30/18.
//  Copyright © 2018 Hoang Duoc. All rights reserved.
//  Dùng chung thằng này cho cả trường hợp signin và signup

#import "SigninViewController.h"
#import "Utils.h"
#import "GlobalService.h"
#import "SPManager.h"
#import "MainTabBarController.h"

@interface SigninViewController ()

@end

@implementation SigninViewController

- (instancetype)initWithAuthenControllerType:(AuthenControllerType)type {
    self = [super initWithNibName:@"SigninViewController" bundle:nil];
    if (self) {
        _type = type;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    switch (_type) {
        case AuthenControllerTypeSignIn:
            [_btSignin setTitle:@"Đăng nhập" forState:UIControlStateNormal];
            
            _lcPhoneTop.constant = 0;
            _lcPhoneHeight.constant = 0;
            _tfPhone.hidden = YES;
            [_tfPhone setNeedsUpdateConstraints];
            [_tfPhone layoutIfNeeded];
            
            _lcRePasswordTop.constant = 0;
            _lcRePasswordHeight.constant = 0;
            _tfRePassword.hidden = YES;
            [_tfRePassword setNeedsUpdateConstraints];
            [_tfRePassword layoutIfNeeded];
            break;
        case AuthenControllerTypeSignUp:
            self.title = @"Đăng ký";
            [_btSignin setTitle:@"Đăng ký" forState:UIControlStateNormal];
            _btForgotPassword.hidden = YES;
            _btSingup.hidden = YES;
            
            [self addDoneBT];
            break;
        case AuthenControllerTypeForgot:
            self.title = @"Lấy lại mật khẩu";
            [_btSignin setTitle:@"Lấy lại mật khẩu" forState:UIControlStateNormal];
            _btForgotPassword.hidden = YES;
            _btSingup.hidden = YES;
            
            _lcPhoneTop.constant = 0;
            _lcPhoneHeight.constant = 0;
            _tfPhone.hidden = YES;
            [_tfPhone setNeedsUpdateConstraints];
            [_tfPhone layoutIfNeeded];
            
            _lcPasswordTop.constant = 0;
            _lcPasswordHeight.constant = 0;
            _tfPassword.hidden = YES;
            [_tfPassword setNeedsUpdateConstraints];
            [_tfPassword layoutIfNeeded];
            
            _lcRePasswordTop.constant = 0;
            _lcRePasswordHeight.constant = 0;
            _tfRePassword.hidden = YES;
            [_tfRePassword setNeedsUpdateConstraints];
            [_tfRePassword layoutIfNeeded];
            
            [self addDoneBT];
            break;
        default:
            break;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)signinTapped:(UIButton *)sender {

    switch (_type) {
        case AuthenControllerTypeSignIn: {
            if (![self validateEmail]) return;
            if (![self validatePassword]) return;
            [self signin];
        } break;
        case AuthenControllerTypeSignUp:
            if (![self validateEmail]) return;
            if (![self validatePhone]) return;
            if (![self validatePassword]) return;
            if (![self validateRePassword]) return;
            [self signup];
            break;
        case AuthenControllerTypeForgot:
            if (![self validateEmail]) return;
            [self forgot];
            break;
        default:
            break;
    }
}

- (IBAction)signupTapped:(UIButton *)sender {
    SigninViewController *signupVC = [[SigninViewController alloc] initWithAuthenControllerType:AuthenControllerTypeSignUp];
    UINavigationController *signupNavi = [[UINavigationController alloc] initWithRootViewController:signupVC];
    [self presentViewController:signupNavi animated:YES completion:nil];
}

- (IBAction)forgotTapped:(UIButton *)sender {
    SigninViewController *forgotVC = [[SigninViewController alloc] initWithAuthenControllerType:AuthenControllerTypeForgot];
    UINavigationController *forgotNavi = [[UINavigationController alloc] initWithRootViewController:forgotVC];
    [self presentViewController:forgotNavi animated:YES completion:nil];
}

- (void)addDoneBT {
    UIBarButtonItem *done = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(dismissView)];
    self.navigationItem.rightBarButtonItem = done;
}

- (void)dismissView {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (BOOL)validateEmail {
    NSString *email = self.tfEmail.text;
    if (!email.length || !STEValidateEmail(email)) {
        [Utils showToastWithString:@"Email không hợp lệ" withView:self.view];
        return NO;
    }
    return YES;
}

- (BOOL)validatePhone {
    NSString *phone = self.tfPhone.text;
    if (!phone.length) {
        [Utils showToastWithString:@"Số điện thoại không hợp lệ" withView:self.view];
        return NO;
    }
    return YES;
}

- (BOOL)validatePassword {
    NSString *password = self.tfPassword.text;
    if (!password.length) {
        [Utils showToastWithString:@"Mật khẩu không hợp lệ" withView:self.view];
        return NO;
    }
    return YES;
}

- (BOOL)validateRePassword {
    NSString *password = self.tfPassword.text;
    NSString *rePassword = self.tfRePassword.text;

    if (![rePassword isEqualToString:password]) {
        [Utils showToastWithString:@"Mật khẩu nhập lại không hợp lệ" withView:self.view];
        return NO;
    }
    return YES;
}

- (void)signup {
    [Utils showProgressViewWithString:nil inView:self.view];
    NSString *email = self.tfEmail.text;
    NSString *phone = self.tfPhone.text;
    NSString *password = self.tfPassword.text;
    [GlobalService registerAccountWithEmail:email phone:phone password:password completionHandler:^(BOOL status, int code, id responseObject) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [Utils hideProgressViewInView:self.view];
            if (status) {
                [self dismissViewControllerAnimated:YES completion:^{
                    [Utils showToastWithString:@"Đăng ký thành công. Vui lòng kiểm tra mail và làm theo hướng dẫn." withView:nil];
                }];
            } else {
                if (((NSString *)responseObject).length) {
                    [Utils showToastWithString:responseObject withView:self.view];
                }
            }
        });
    }];
}

- (void)signin {
    [Utils showProgressViewWithString:nil inView:self.view];
    NSString *email = self.tfEmail.text;
    NSString *password = self.tfPassword.text;
    
    [GlobalService loginAccountWithEmail:email password:password completionHandler:^(BOOL status, int code, id responseObject) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [Utils hideProgressViewInView:self.view];
            if (status) {
                NSDictionary *data = (NSDictionary *)responseObject;
                [SPManager instance].myUser = [[UserModel alloc] initWithFinData:data];
                [Utils writeCustomObjToUserDefaults:@"myUser" object:[SPManager instance].myUser];
                MainTabBarController *mainTabbarVC = [[MainTabBarController alloc] init];
                [UIApplication sharedApplication].keyWindow.rootViewController = mainTabbarVC;
            } else {
                if (((NSString *)responseObject).length) {
                    [Utils showToastWithString:responseObject withView:self.view];
                }
            }
        });
    }];
}

- (void)forgot {
    [Utils showProgressViewWithString:nil inView:self.view];
    NSString *email = self.tfEmail.text;
    [GlobalService resetPasswordWithEmail:email completionHandler:^(BOOL status, int code, id responseObject) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [Utils hideProgressViewInView:self.view];
            if (status) {
                [self dismissViewControllerAnimated:YES completion:^{
                    [Utils showToastWithString:@"Reset password thành công. Vui lòng kiểm tra mail và làm theo hướng dẫn." withView:nil];
                }];
            } else {
                [Utils showToastWithString:@"Reset password thất bại. Vui lòng thử lại sau." withView:self.view];
            }
        });
    }];
}






@end
