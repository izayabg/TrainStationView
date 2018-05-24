//
//  CustomView.h
//  TrainStationCALayer
//
//  Created by MacOsGjf on 2018/5/24.
//  Copyright © 2018年 MacOsGjf. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomView : UIView

@property(nonatomic, assign)NSInteger count;
@property(nonatomic, assign)NSInteger lineCount;
@property(nonatomic, assign)NSInteger startStation;
@property(nonatomic, assign)NSInteger endStation;

@property(nonatomic, weak)NSArray *buttonArray;

@end
