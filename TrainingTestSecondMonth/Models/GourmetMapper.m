//
//  GourmetMapper.m
//  TrainingTestSecondMonth
//
//  Created by Kouki Enomoto on 2017/01/23.
//  Copyright © 2017年 enomt. All rights reserved.
//

#import "GourmetMapper.h"

static NSString *const KeyResults = @"results";
static NSString *const KeyResultsAvailable = @"results_available";
static NSString *const KeyShop = @"shop";
static NSString *const KeyShopGenre = @"genre";
static NSString *const KeyShopGenreName = @"name";
static NSString *const KeyShopName = @"name";
static NSString *const KeyShopPhoto = @"photo";
static NSString *const KeyShopPhotoMobile = @"mobile";
static NSString *const KeyShopPhotoMobileL = @"l";
static NSString *const KeyShopFood = @"food";
static NSString *const KeyShopFoodName = @"name";
static NSString *const KeyShopBudget = @"budget";
static NSString *const KeyShopBudgetAverage = @"average";
static NSString *const KeyShopOpen = @"open";
static NSString *const KeyShopAccess = @"access";
static NSString *const KeyShopAddress = @"address";

@implementation GourmetMapper

+ (NSInteger)resultAvailableForResponseObject:(id)responseObject {
    NSDictionary *results = responseObject[KeyResults];
    NSString *resultAvailableString = results[KeyResultsAvailable];
    return [resultAvailableString integerValue];
}

+ (NSArray<Gourmet *> *)translateWithResponseObject:(id)responseObject {
    NSDictionary *results = responseObject[KeyResults];
    NSArray<NSDictionary *> *shop = results[KeyShop];

    NSMutableArray<Gourmet *> *gourmets = [@[] mutableCopy];
    [shop enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        Gourmet *gourmet = [[Gourmet alloc] init];
        NSString *genre = obj[KeyShopGenre][KeyShopGenreName];
        NSString *shop = obj[KeyShopName];
        NSString *photo = obj[KeyShopPhoto][KeyShopPhotoMobile][KeyShopPhotoMobileL];
        NSString *food = obj[KeyShopFood][KeyShopFoodName];
        NSString *average = obj[KeyShopBudget][KeyShopBudgetAverage];
        NSString *open = obj[KeyShopOpen];
        NSString *access = obj[KeyShopAccess];
        NSString *address = obj[KeyShopAddress];

        gourmet.genre = [genre isEqual:[NSNull null]] ? @"" : genre;
        gourmet.shop = [shop isEqual:[NSNull null]] ? @"" : shop;
        gourmet.photoURL = [NSURL URLWithString:[photo isEqual:[NSNull null]] ? @"" : photo];
        gourmet.food = [food isEqual:[NSNull null]] ? @"" : food;
        gourmet.average = [average isEqual:[NSNull null]] ? @"" : average;
        gourmet.open = [open isEqual:[NSNull null]] ? @"" : open;
        gourmet.access = [access isEqual:[NSNull null]] ? @"" : access;
        gourmet.address = [address isEqual:[NSNull null]] ? @"" : address;
        [gourmets addObject:gourmet];
    }];
    return gourmets;
}

@end
