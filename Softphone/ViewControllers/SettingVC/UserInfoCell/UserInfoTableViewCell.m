//
//  SPUserInfoTableViewCell.m
//  Softphone
//
//  Created by Hoang Duoc on 7/11/17.
//  Copyright © 2017 Hoang Duoc. All rights reserved.
//

#import "UserInfoTableViewCell.h"
#import "StringeeImplement.h"
#import "AvatarControl.h"
#import "Utils.h"
#import "SPManager.h"
#import "Constants.h"

@implementation UserInfoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.imageAvatar.backgroundColor = [UIColor grayColor];
    self.imageAvatar.layer.cornerRadius = self.imageAvatar.frame.size.width / 2;
    self.imageAvatar.clipsToBounds = YES;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(balanceEvent) name:BalanceNotification object:[SPManager instance]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)configureCell {
    
    NSString *username = [SPManager instance].myUser.email.length ? [SPManager instance].myUser.email : @"Không xác định";
    
    self.labelName.text = username;
    
    NSString *strAvatar = [Utils getStrLetterWithName:username];
    self.imageAvatar.image = [[AvatarControl instance] getAvatar:strAvatar];
    
    self.labelPhone.text = [SPManager instance].myUser.phone.length ? [SPManager instance].myUser.phone : @"Không xác định";
    
    NSString *number = [[SPManager instance] getNumberForCallOut];
    self.labelBalance.text = number.length ? [@" +" stringByAppendingString:number] : @" Không có số gọi ra";
    
}

- (void)balanceEvent {
    dispatch_async(dispatch_get_main_queue(), ^{
        self.labelBalance.text = [NSString stringWithFormat:@"%@$", [SPManager instance].balance];
    });
}

@end
