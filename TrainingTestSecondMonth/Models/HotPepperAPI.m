//
//  HotPepperAPI.m
//  TrainingTestSecondMonth
//
//  Created by Kouki Enomoto on 2017/01/23.
//  Copyright © 2017年 enomt. All rights reserved.
//

#import <AFNetworking.h>
#import "GourmetMapper.h"
#import "HotPepperAPI.h"

static NSString *const URL = @"https://webservice.recruit.co.jp/hotpepper/gourmet/v1/";
static NSString *const Key = @"key";
static NSString *const KeyFormat = @"format";
static NSString *const KeySmallArea = @"small_area";
static NSString *const KeyCount = @"count";
static NSString *const KeyStart = @"start";
static NSString *const APIKey = @"2ee9321b0d571727";
static NSString *const JsonFormat = @"json";
static NSString *const GotandaSmallAreaCode = @"X086";
static NSString *const DefaultCount = @"50";
static  const NSInteger DefaultStart = 1;

@interface HotPepperAPI ()

@property (assign, nonatomic) NSInteger resultAvailable;
@property (assign, nonatomic) NSInteger startPosition;

@end

@implementation HotPepperAPI

- (instancetype)init {
    if (self = [super init]) {
        _resultAvailable = 0;
        _startPosition = DefaultStart;
    }
    return self;
}

- (void)fetchGotandaGourmet {
    self.startPosition = DefaultStart;
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    __weak typeof(self) weakSelf = self;
    [manager GET:URL parameters:[self parameters] progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        weakSelf.resultAvailable = [GourmetMapper resultAvailableForResponseObject:responseObject];
        weakSelf.startPosition++;
        NSArray<Gourmet *> *gourmets = [GourmetMapper translateWithResponseObject:responseObject];
        if([self.delegate respondsToSelector:@selector(hotPepperAPI:fetchResponse:)]) {
            [self.delegate hotPepperAPI:self fetchResponse:gourmets];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if([self.delegate respondsToSelector:@selector(hotPepperAPI:fetchError:)]) {
            [self.delegate hotPepperAPI:self fetchError:error];
        }
    }];
}

- (void)addGotandaGourmet {
    if (self.resultAvailable < self.startPosition) {
        if([self.delegate respondsToSelector:@selector(hotPepperAPI:overResultAvailable:)]) {
            [self.delegate hotPepperAPI:self overResultAvailable:self.startPosition];
        }
    }

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    __weak typeof(self) weakSelf = self;
    [manager GET:URL parameters:[self parameters] progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        weakSelf.startPosition++;
        NSArray<Gourmet *> *gourmets = [GourmetMapper translateWithResponseObject:responseObject];
        if([self.delegate respondsToSelector:@selector(hotPepperAPI:addResponse:)]) {
            [self.delegate hotPepperAPI:self addResponse:gourmets];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if ([self.delegate respondsToSelector:@selector(hotPepperAPI:addError:)]) {
            [self.delegate hotPepperAPI:self addError:error];
        }
    }];
}

- (NSDictionary *)parameters {
    return @{
             Key: APIKey,
             KeyFormat: JsonFormat,
             KeySmallArea: GotandaSmallAreaCode,
             KeyCount: DefaultCount,
             KeyStart: [NSString stringWithFormat:@"%ld", (long)self.startPosition]
             };
}

@end
