//
//  GlobalService.h
//  Softphone
//
//  Created by Hoang Duoc on 3/5/18.
//  Copyright © 2018 Hoang Duoc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GlobalService : NSObject

+ (void)loginWithPhoneNumber:(NSString *)phone completionHandler:(void(^)(BOOL status, int code, id responseObject))completionHandler;

+ (void)comfirmWithPhoneNumber:(NSString *)phone code:(NSString *)code completionHandler:(void(^)(BOOL status, int code, id responseObject))completionHandler;

+ (void)checkPhoneBookExistedWithPhoneBook:(NSDictionary *)phoneBook token:(NSString *)token completionHandler:(void(^)(BOOL status, int code, id responseObject))completionHandler;

+ (void)getAccessTokenWithToken:(NSString *)token completionHandler:(void(^)(BOOL status, int code, id responseObject))completionHandler;

+ (void)checkBalanceForPhone:(NSString *)phone completionHandler:(void(^)(BOOL status, int code, id responseObject))completionHandler;

+ (void)registerAccountWithEmail:(NSString *)email phone:(NSString *)phone password:(NSString *)password completionHandler:(void(^)(BOOL status, int code, id responseObject))completionHandler;

+ (void)loginAccountWithEmail:(NSString *)email password:(NSString *)password completionHandler:(void(^)(BOOL status, int code, id responseObject))completionHandler;

+ (void)resetPasswordWithEmail:(NSString *)email completionHandler:(void(^)(BOOL status, int code, id responseObject))completionHandler;

@end
