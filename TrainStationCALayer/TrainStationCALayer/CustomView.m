//
//  CustomView.m
//  TrainStationCALayer
//
//  Created by MacOsGjf on 2018/5/24.
//  Copyright © 2018年 MacOsGjf. All rights reserved.
//

#import "CustomView.h"

@implementation CustomView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.count = -1;
        self.lineCount = -1;
        self.startStation = -1;
        self.endStation = -1;
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    
    if (self.count <= 0 || self.lineCount <= 0) {
        return;
    }else {
    // Drawing code
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetLineWidth(context, 10);
        CGContextSetLineCap(context, kCGLineCapRound);
        //points[]坐标数组，和count大小
        UIButton *firstBtn = self.buttonArray.firstObject;
        CGContextMoveToPoint(context, 0, firstBtn.center.y);
        for (int i = 0; i<self.count; i++) {
            //绘制横线
            if (i%self.lineCount == self.lineCount-1 && i<self.count-1) {
                UIButton *tempBtn = self.buttonArray[i];
                CGContextMoveToPoint(context, tempBtn.center.x, tempBtn.center.y);
            }
        }
        
        CGContextAddLineToPoint(context, 130, 80);
        [[UIColor blueColor] setStroke];
        CGContextDrawPath(context, kCGPathStroke); //根据坐标绘制路径
        CGContextMoveToPoint(context, 130, 80);
        CGContextAddLineToPoint(context, 160, 80);
        CGContextAddArcToPoint(context, 175, 80, 175, 95, 15);
        CGContextAddLineToPoint(context, 175, 115);
        [[UIColor redColor] setStroke];
        CGContextDrawPath(context, kCGPathStroke); //根据坐标绘制路径
    }
}



@end
