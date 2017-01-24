//
//  RestaurantCell.h
//  TrainingTestSecondMonth
//
//  Created by Kouki Enomoto on 2017/01/23.
//  Copyright © 2017年 enomt. All rights reserved.
//

@import UIKit;

#import "Gourmet.h"

@interface RestaurantCell : UITableViewCell

- (void)setupWithGourmet:(Gourmet *)gourmet;

@end
