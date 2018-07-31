//
//  GlobalService.m
//  Softphone
//
//  Created by Hoang Duoc on 3/5/18.
//  Copyright © 2018 Hoang Duoc. All rights reserved.
//

#import "GlobalService.h"
#import "HTTPClient.h"

@implementation GlobalService

+ (void)loginWithPhoneNumber:(NSString *)phone completionHandler:(void(^)(BOOL status, int code, id responseObject))completionHandler {
    NSDictionary *params = @{
                             @"phone" : phone
                             };
    [[HTTPClient instance] POST:@"login" parameters:params completionHandler:^(BOOL status, int code, id responseObject) {
        if (status) {
            NSDictionary *data = [((NSDictionary *)responseObject) objectForKey:@"data"];
            completionHandler(status, code, data);
        } else {
            completionHandler(status, code, (NSString *)responseObject);
        }
    }];
}

+ (void)comfirmWithPhoneNumber:(NSString *)phone code:(NSString *)code completionHandler:(void(^)(BOOL status, int code, id responseObject))completionHandler {
    NSDictionary *params = @{
                             @"phone" : phone,
                             @"code" : code
                             };
    [[HTTPClient instance] POST:@"confirm" parameters:params completionHandler:^(BOOL status, int code, id responseObject) {
        if (status) {
            NSDictionary *data = [((NSDictionary *)responseObject) objectForKey:@"data"];
            completionHandler(status, code, data);
        } else {
            completionHandler(status, code, (NSString *)responseObject);
        }
    }];
}

+ (void)checkPhoneBookExistedWithPhoneBook:(NSDictionary *)phoneBook token:(NSString *)token completionHandler:(void(^)(BOOL status, int code, id responseObject))completionHandler {
    NSDictionary *params = @{
                             @"token" : token,
                             @"phonebook" : phoneBook
                             };
    [[HTTPClient instance] POST:@"checkphonebookexisted" parameters:params completionHandler:^(BOOL status, int code, id responseObject) {
        if (status) {
            NSDictionary *data = [((NSDictionary *)responseObject) objectForKey:@"data"];
            completionHandler(status, code, data);
        } else {
            completionHandler(status, code, (NSString *)responseObject);
        }
    }];
}

+ (void)getAccessTokenWithToken:(NSString *)token completionHandler:(void(^)(BOOL status, int code, id responseObject))completionHandler {
    NSDictionary *params = @{
                             @"token" : token
                             };
    [[HTTPClient instance] POST:@"getaccesstoken" parameters:params completionHandler:^(BOOL status, int code, id responseObject) {
        if (status) {
            NSDictionary *data = [((NSDictionary *)responseObject) objectForKey:@"data"];
            completionHandler(status, code, data);
        } else {
            completionHandler(status, code, (NSString *)responseObject);
        }
    }];
}

+ (void)checkBalanceForPhone:(NSString *)phone completionHandler:(void(^)(BOOL status, int code, id responseObject))completionHandler {
    NSDictionary *params = @{
                             @"phone" : phone
                             };
    [[HTTPClient instance] POST:@"checkmoney" parameters:params completionHandler:^(BOOL status, int code, id responseObject) {
        if (status) {
            NSDictionary *data = [((NSDictionary *)responseObject) objectForKey:@"data"];
            completionHandler(status, code, data);
        } else {
            completionHandler(status, code, (NSString *)responseObject);
        }
    }];
}

+ (void)registerAccountWithEmail:(NSString *)email phone:(NSString *)phone password:(NSString *)password completionHandler:(void(^)(BOOL status, int code, id responseObject))completionHandler {
    NSDictionary *params = @{@"email" : email,
                             @"phone" : phone,
                             @"password" : password
                             };
    [[HTTPClient instance] POST:@"register" parameters:params completionHandler:^(BOOL status, int code, id responseObject) {
        if (status) {
            NSDictionary *data = [((NSDictionary *)responseObject) objectForKey:@"data"];
            completionHandler(status, code, data);
        } else {
            completionHandler(status, code, (NSString *)responseObject);
        }
    }];
}

+ (void)loginAccountWithEmail:(NSString *)email password:(NSString *)password completionHandler:(void(^)(BOOL status, int code, id responseObject))completionHandler {
    NSDictionary *params = @{@"email" : email,
                             @"password" : password
                             };
    [[HTTPClient instance] POST:@"login" parameters:params completionHandler:^(BOOL status, int code, id responseObject) {
        if (status) {
            NSDictionary *data = [((NSDictionary *)responseObject) objectForKey:@"data"];
            completionHandler(status, code, data);
        } else {
            completionHandler(status, code, (NSString *)responseObject);
        }
    }];
}

+ (void)resetPasswordWithEmail:(NSString *)email completionHandler:(void(^)(BOOL status, int code, id responseObject))completionHandler {
    NSDictionary *params = @{@"email" : email
                             };
    [[HTTPClient instance] POST:@"forgot" parameters:params completionHandler:^(BOOL status, int code, id responseObject) {
        if (status) {
            NSDictionary *data = [((NSDictionary *)responseObject) objectForKey:@"data"];
            completionHandler(status, code, data);
        } else {
            completionHandler(status, code, (NSString *)responseObject);
        }
    }];
}

@end
