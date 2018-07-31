//
//  UserModel.m
//  Softphone
//
//  Created by Hoang Duoc on 3/20/18.
//  Copyright © 2018 Hoang Duoc. All rights reserved.
//

#import "UserModel.h"

@implementation UserModel

- (instancetype)initWithData:(NSDictionary *)data {
    self = [super init];
    if (self) {
        _phone = (data[@"phone"] != nil && data[@"phone"] != [NSNull null]) ? (NSString *)data[@"phone"] : @"";
        _token = (data[@"token"] != nil && data[@"token"] != [NSNull null]) ? (NSString *)data[@"token"] : @"";
        _accessToken = (data[@"access_token"] != nil && data[@"access_token"] != [NSNull null]) ? (NSString *)data[@"access_token"] : @"";
        _expireTime = (data[@"expire_time"] != nil && data[@"expire_time"] != [NSNull null]) ? ((NSNumber *)data[@"expire_time"]).longLongValue : 0;
        
        NSArray *phones = (data[@"callOutNumber"] != nil && data[@"callOutNumber"] != [NSNull null]) ? (NSArray *)data[@"callOutNumber"] : [[NSArray alloc] init];
        NSMutableArray *tempArray = [[NSMutableArray alloc] init];
        for (NSString *phone in phones) {
            CalloutNumberModel *calloutNumber = [[CalloutNumberModel alloc] initWithPhone:phone];
            [tempArray addObject:calloutNumber];
        }
        _calloutNumbers = tempArray;
    }
    return self;
}

- (instancetype)initWithFinData:(NSDictionary *)data {
    self = [super init];
    if (self) {
        _email = (data[@"account"][@"email"] != nil && data[@"account"][@"email"] != [NSNull null]) ? (NSString *)data[@"account"][@"email"] : @"";
        _phone = (data[@"account"][@"phone"] != nil && data[@"account"][@"phone"] != [NSNull null]) ? (NSString *)data[@"account"][@"phone"] : @"";
        _token = (data[@"token"][@"token"] != nil && data[@"token"][@"token"] != [NSNull null]) ? (NSString *)data[@"token"][@"token"] : @"";
        _accessToken = (data[@"token"][@"access_token"] != nil && data[@"token"][@"access_token"] != [NSNull null]) ? (NSString *)data[@"token"][@"access_token"] : @"";
        _expireTime = (data[@"token"][@"expire_time"] != nil && data[@"token"][@"expire_time"] != [NSNull null]) ? ((NSNumber *)data[@"token"][@"expire_time"]).longLongValue : 0;
        
        NSArray *phones = (data[@"call_out_number"] != nil && data[@"call_out_number"] != [NSNull null]) ? (NSArray *)data[@"call_out_number"] : [[NSArray alloc] init];
        NSMutableArray *tempArray = [[NSMutableArray alloc] init];
        for (NSString *phone in phones) {
            CalloutNumberModel *calloutNumber = [[CalloutNumberModel alloc] initWithPhone:phone];
            [tempArray addObject:calloutNumber];
        }
        _calloutNumbers = tempArray;
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder;
{
    [coder encodeObject:_email forKey:@"email"];
    [coder encodeObject:_phone forKey:@"phone"];
    [coder encodeObject:_token forKey:@"token"];
    [coder encodeObject:_accessToken forKey:@"accessToken"];
    [coder encodeObject:[NSNumber numberWithLongLong:_expireTime] forKey:@"expireTime"];
    [coder encodeObject:_calloutNumbers forKey:@"calloutNumbers"];

}

- (id)initWithCoder:(NSCoder *)coder {
    self = [super init];
    if (self != nil) {
        _email = [coder decodeObjectForKey:@"email"];
        _phone = [coder decodeObjectForKey:@"phone"];
        _token = [coder decodeObjectForKey:@"token"];
        _accessToken = [coder decodeObjectForKey:@"accessToken"];
        _expireTime = ((NSNumber *)[coder decodeObjectForKey:@"expireTime"]).longLongValue;
        _calloutNumbers = (NSArray *)[coder decodeObjectForKey:@"calloutNumbers"];
    }
    return self;
}

@end
