//
//  GotandaViewDataSource.m
//  TrainingTestSecondMonth
//
//  Created by Kouki Enomoto on 2017/01/23.
//  Copyright © 2017年 enomt. All rights reserved.
//

#import "GotandaViewDataSource.h"
#import "RestaurantCell.h"
#import "UITableViewCell+Identifier.h"

@implementation GotandaViewDataSource

- (instancetype)initWithGourmets:(NSArray<Gourmet *> *)gourmets {
    if (self = [super init]) {
        _gourmets = gourmets;
    }
    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.gourmets.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RestaurantCell *cell = (RestaurantCell *)[tableView dequeueReusableCellWithIdentifier:[RestaurantCell defaultIdentifier] forIndexPath:indexPath];
    Gourmet *gourmet = self.gourmets[indexPath.row];
    [cell setupWithGourmet:gourmet];
    return cell;
}

@end
