//
//  UITableViewCell+Identifier.m
//  TrainingTestSecondMonth
//
//  Created by Kouki Enomoto on 2017/01/23.
//  Copyright © 2017年 enomt. All rights reserved.
//

#import "UITableViewCell+Identifier.h"

@implementation UITableViewCell (Identifier)

+ (NSString *)defaultIdentifier {
    return [NSStringFromClass(self) componentsSeparatedByString:@"."].lastObject;
}

@end
