//
//  GotandaViewDataSource.h
//  TrainingTestSecondMonth
//
//  Created by Kouki Enomoto on 2017/01/23.
//  Copyright © 2017年 enomt. All rights reserved.
//

@import UIKit;

#import "Gourmet.h"

@interface GotandaViewDataSource : NSObject <UITableViewDataSource>

@property (strong, nonatomic) NSArray<Gourmet *> *gourmets;

- (instancetype)initWithGourmets:(NSArray<Gourmet *> *)gourmets;

@end
