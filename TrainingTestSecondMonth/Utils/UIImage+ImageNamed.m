//
//  UIImage+ImageNamed.m
//  TrainingTestSecondMonth
//
//  Created by Kouki Enomoto on 2017/01/23.
//  Copyright © 2017年 enomt. All rights reserved.
//

#import "UIImage+ImageNamed.h"

static NSString *const Noimage = @"Noimage";
static NSString *const Refresh = @"Refresh";

@implementation UIImage (ImageNamed)

+ (UIImage *)noimage {
    return [UIImage imageNamed:Noimage];
}

+ (UIImage *)refresh {
    return [UIImage imageNamed:Refresh];
}

@end
