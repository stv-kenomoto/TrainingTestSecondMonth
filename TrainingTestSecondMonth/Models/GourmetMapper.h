//
//  GourmetMapper.h
//  TrainingTestSecondMonth
//
//  Created by Kouki Enomoto on 2017/01/23.
//  Copyright © 2017年 enomt. All rights reserved.
//

@import Foundation;

#import "Gourmet.h"

@interface GourmetMapper : NSObject

+ (NSInteger)resultAvailableForResponseObject:(id)responseObject;
+ (NSArray<Gourmet *> *)translateWithResponseObject:(id)responseObject;

@end
