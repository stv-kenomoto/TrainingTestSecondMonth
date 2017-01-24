//
//  RestaurantCell.m
//  TrainingTestSecondMonth
//
//  Created by Kouki Enomoto on 2017/01/23.
//  Copyright © 2017年 enomt. All rights reserved.
//

#import <SDWebImage/UIImageView+WebCache.h>
#import "RestaurantCell.h"
#import "UIImage+ImageNamed.h"

@interface RestaurantCell ()

@property (weak, nonatomic) IBOutlet UILabel *genreLabel;
@property (weak, nonatomic) IBOutlet UILabel *shopLabel;
@property (weak, nonatomic) IBOutlet UIImageView *photoImageView;
@property (weak, nonatomic) IBOutlet UILabel *foodLabel;
@property (weak, nonatomic) IBOutlet UILabel *averageLabel;
@property (weak, nonatomic) IBOutlet UILabel *openLabel;
@property (weak, nonatomic) IBOutlet UILabel *accessLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;

@end

@implementation RestaurantCell

- (void)prepareForReuse {
    self.genreLabel.text = @"";
    self.shopLabel.text = @"";
    self.photoImageView.image = nil;
    self.foodLabel.text = @"";
    self.averageLabel.text = @"";
    self.openLabel.text = @"";
    self.accessLabel.text = @"";
    self.addressLabel.text = @"";
}

- (void)setupWithGourmet:(Gourmet *)gourmet {
    self.genreLabel.text = gourmet.genre;
    self.shopLabel.text = gourmet.shop;
    [self.photoImageView sd_setImageWithURL:gourmet.photoURL placeholderImage:[UIImage noimage]];
    self.foodLabel.text = gourmet.food;
    self.averageLabel.text = gourmet.average;
    self.openLabel.text = gourmet.open;
    self.accessLabel.text = gourmet.access;
    self.addressLabel.text = gourmet.address;
}

@end
