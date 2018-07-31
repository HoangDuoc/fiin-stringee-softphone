//
//  SPManager.m
//  Softphone
//
//  Created by Hoang Duoc on 3/5/18.
//  Copyright © 2018 Hoang Duoc. All rights reserved.
//

#import "SPManager.h"
#import "Constants.h"
#import "Utils.h"
#import "GlobalService.h"

@implementation SPManager

static SPManager *spManager = nil;

// MARK: - Init
+ (SPManager *)instance {
    @synchronized(self) {
        if (spManager == nil) {
            spManager = [[self alloc] init];
        }
    }
    return spManager;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        // Lắng nghe sự kiện terminate app
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(saveCallHistories) name:UIApplicationWillTerminateNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(saveCallHistories) name:UIApplicationWillResignActiveNotification object:nil];
        
        _listKeys = [[NSMutableArray alloc] init];
        _dicSections = [[NSMutableDictionary alloc] init];
        _allKeys = @{
                    @"A" : @"A",
                    @"B" : @"B",
                    @"C" : @"C",
                    @"D" : @"D",
                    @"E" : @"E",
                    @"F" : @"F",
                    @"G" : @"G",
                    @"H" : @"H",
                    @"I" : @"I",
                    @"J" : @"J",
                    @"K" : @"K",
                    @"L" : @"L",
                    @"M" : @"M",
                    @"N" : @"N",
                    @"O" : @"O",
                    @"P" : @"P",
                    @"Q" : @"Q",
                    @"R" : @"R",
                    @"S" : @"S",
                    @"T" : @"T",
                    @"U" : @"U",
                    @"V" : @"V",
                    @"X" : @"X",
                    @"Y" : @"Y",
                    @"Z" : @"Z",
                    @"W" : @"W"
                    };
        
        NSArray *callHistories = (NSArray *)[Utils readCustomObjFromUserDefaults:@"call_history"];
        if (callHistories) {
            _arrayCallHistories = [[NSMutableArray alloc] initWithArray:callHistories];
        } else {
            _arrayCallHistories = [[NSMutableArray alloc] init];
        }
        
        _myUser = (UserModel *)[Utils readCustomObjFromUserDefaults:@"myUser"];
        
        if (@available(iOS 10.0, *)) {
            _callObserver = [[CXCallObserver alloc] init];
        } else {
            _callCenter = [[CTCallCenter alloc] init];
        }
        
        _deviceToken = @"";
        _hasRegisteredToReceivePush = NO;
        _isAppleCheck = NO;
        _isAppleToken = @"";
        _balance = @"";
    }
    return self;
}

- (NSString *)getNumberForCallOut {
    NSString *number = @"";
    
    for (CalloutNumberModel *calloutNumber in _myUser.calloutNumbers) {
        if (calloutNumber.phone.length && calloutNumber.isEnable) {
            number = calloutNumber.phone;
            break;
        }
    }
    
    return number;
}

- (void)saveCallHistories {
    [Utils writeCustomObjToUserDefaults:@"call_history" object:_arrayCallHistories];
}

- (BOOL)isSystemCall {
    BOOL isSystemCall = NO;
    if (@available(iOS 10, *)) {
        if (_callObserver.calls.count) {
            isSystemCall = YES;
        }
    } else {
        if (_callCenter.currentCalls.count) {
            isSystemCall = YES;
        }
    }
    
    return isSystemCall;
}

- (void)addPrivateContact:(ContactModel *)contactModel {
    
    // Thêm vào mảng để kiểm tra tên trong cuộc khi gọi
    NSString *username = contactModel.name;
    
    // Xem may thuoc nhom nao
    NSString *firstLetter =  nil;
    //
    if (username.length <1) {
        firstLetter = @"#";
    }
    else {
        firstLetter = [[username substringToIndex:1] uppercaseString];
        firstLetter = [Utils convertUTF8ToAscii:firstLetter];
    }
    
    if (!_allKeys[firstLetter] && username.length >=1) {
        firstLetter = @"#";
    }
    // Nhet may vao dung vi tri cua may
    NSMutableArray *contactModels = _dicSections[firstLetter];
    if(!contactModels) {
        contactModels = [NSMutableArray array];
        _dicSections[firstLetter] = contactModels;
    }
    [contactModels addObject:contactModel];
    // lay list key moi nhat nhe
    _listKeys = [[NSMutableArray alloc] initWithArray:[_dicSections.allKeys sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)]];
}

- (NSString *)findUsernameWithPhone:(NSString *)phone {
    NSLog(@"phone: %@", phone);
    // Nếu số điện thoại tồn tại thì mới tìm
    if (phone.length) {
        for (NSString *key in self.listKeys) {
            NSArray *contactOfSection = [self.dicSections objectForKey:key];
            for (ContactModel *contactModel in contactOfSection) {
                if ([contactModel.phone_display isEqualToString:phone] || [contactModel.phone_call isEqualToString:phone]) {
                    return contactModel.name;
                }
            }
        }
    }
    return  @"";
}

- (void)checkBalanceForPhone:(NSString *)phone {
    if (!phone || !phone.length) {
        return;
    }
    [GlobalService checkBalanceForPhone:phone completionHandler:^(BOOL status, int code, id responseObject) {
        if (status) {
            NSDictionary *data = (NSDictionary *)responseObject;
            _balance = (data[@"amount"] != nil && data[@"amount"] != [NSNull null]) ? (NSString *)data[@"amount"] : @"";
            [[NSNotificationCenter defaultCenter] postNotificationName:BalanceNotification object:self];
            NSLog(@"****** BALANCE %@", _balance);
        }
    }];
}

@end
