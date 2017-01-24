//
//  HotPepperAPI.h
//  TrainingTestSecondMonth
//
//  Created by Kouki Enomoto on 2017/01/23.
//  Copyright © 2017年 enomt. All rights reserved.
//

@import Foundation;

#import "Gourmet.h"

@class HotPepperAPI;

@protocol HotPepperAPIDelegate <NSObject>

@optional
- (void)hotPepperAPI:(HotPepperAPI *)hotPepperAPI fetchResponse:(NSArray <Gourmet *> *)fetchResponse;
- (void)hotPepperAPI:(HotPepperAPI *)hotPepperAPI fetchError:(NSError *)fetchError;

- (void)hotPepperAPI:(HotPepperAPI *)hotPepperAPI addResponse:(NSArray <Gourmet *> *)addResponse;
- (void)hotPepperAPI:(HotPepperAPI *)hotPepperAPI overResultAvailable:(NSInteger)overResultAvailable;
- (void)hotPepperAPI:(HotPepperAPI *)hotPepperAPI addError:(NSError *)addError;

@end

@interface HotPepperAPI : NSObject

@property (weak, nonatomic) id<HotPepperAPIDelegate> delegate;

- (void)fetchGotandaGourmet;

- (void)addGotandaGourmet;

@end
