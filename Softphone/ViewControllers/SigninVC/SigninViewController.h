//
//  SigninViewController.h
//  Softphone
//
//  Created by Hoang Duoc on 7/30/18.
//  Copyright © 2018 Hoang Duoc. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, AuthenControllerType) {
    AuthenControllerTypeSignIn,
    AuthenControllerTypeSignUp,
    AuthenControllerTypeForgot
};

@interface SigninViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *tfEmail;
@property (weak, nonatomic) IBOutlet UITextField *tfPhone;
@property (weak, nonatomic) IBOutlet UITextField *tfPassword;
@property (weak, nonatomic) IBOutlet UITextField *tfRePassword;
@property (weak, nonatomic) IBOutlet UIButton *btSignin;
@property (weak, nonatomic) IBOutlet UIButton *btSingup;
@property (weak, nonatomic) IBOutlet UIButton *btForgotPassword;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lcPhoneTop;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lcPhoneHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lcPasswordTop;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lcPasswordHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lcRePasswordTop;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lcRePasswordHeight;

- (IBAction)signinTapped:(UIButton *)sender;
- (IBAction)signupTapped:(UIButton *)sender;
- (IBAction)forgotTapped:(UIButton *)sender;

@property (assign, nonatomic) AuthenControllerType type;

- (instancetype)initWithAuthenControllerType:(AuthenControllerType)type;

@end
