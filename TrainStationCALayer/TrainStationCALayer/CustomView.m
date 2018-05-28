//
//  CustomView.m
//  TrainStationCALayer
//
//  Created by MacOsGjf on 2018/5/24.
//  Copyright © 2018年 MacOsGjf. All rights reserved.
//


#import "CustomView.h"
#import <CoreImage/CoreImage.h>


//半径
#define kRadius (15.0f)

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
    
    if (self.count <= 0 || self.lineCount <= 0 || self.buttonArray.count == 0) {
        return;
    }else {
    // Drawing code
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetLineWidth(context, 10);
        CGContextSetLineCap(context, kCGLineCapRound);
        
        [self drawLineInRect:rect context:context start:0 end:self.count withColor:[UIColor blueColor]];
        if (self.startStation >=0 && self.endStation > self.startStation) {
            [self drawLineInRect:rect context:context start:self.startStation end:self.endStation+1 withColor:[UIColor redColor]];
        }
       
    }
}

- (void)drawLineInRect:(CGRect)rect context:(CGContextRef)context start:(NSInteger)start end:(NSInteger)end withColor:(UIColor *)color{
   
    UIButton *firstBtn = self.buttonArray[start];
    CGContextMoveToPoint(context, firstBtn.center.x, firstBtn.center.y);
    for (NSInteger i = start; i<end; i++) {
        
        UIButton *tempBtn = self.buttonArray[i];
        //绘制横线  判断是否换行
        if ((i%self.lineCount==0) && i>start) {
            UIButton *beforBtn = self.buttonArray[i-1];
            //绘制换行弧线
            if (i%self.lineCount != i%(self.lineCount*2)) {
                //右弧线
                CGContextAddLineToPoint(context, CGRectGetMaxX(beforBtn.frame), beforBtn.center.y);
                CGContextAddArcToPoint(context, CGRectGetMaxX(beforBtn.frame)+kRadius, beforBtn.center.y, CGRectGetMaxX(beforBtn.frame)+kRadius, beforBtn.center.y+kRadius, kRadius);
                CGContextAddLineToPoint(context, CGRectGetMaxX(tempBtn.frame)+kRadius, tempBtn.center.y-kRadius);
                CGContextAddArcToPoint(context, CGRectGetMaxX(tempBtn.frame)+kRadius, tempBtn.center.y, CGRectGetMaxX(tempBtn.frame), tempBtn.center.y, kRadius);
                CGContextAddLineToPoint(context, tempBtn.center.x, tempBtn.center.y);
            }else {
                //左弧线
                CGContextAddLineToPoint(context, CGRectGetMinX(beforBtn.frame), beforBtn.center.y);
                CGContextAddArcToPoint(context, CGRectGetMinX(beforBtn.frame)-kRadius, beforBtn.center.y, CGRectGetMinX(beforBtn.frame)-kRadius, beforBtn.center.y+kRadius, kRadius);
                CGContextAddLineToPoint(context, CGRectGetMinX(tempBtn.frame)-kRadius, tempBtn.center.y-kRadius);
                CGContextAddArcToPoint(context, CGRectGetMinX(tempBtn.frame)-kRadius, tempBtn.center.y, CGRectGetMinX(tempBtn.frame), tempBtn.center.y, kRadius);
                CGContextAddLineToPoint(context, tempBtn.center.x, tempBtn.center.y);
                
            }
            
        }else {
            CGContextAddLineToPoint(context, tempBtn.center.x, tempBtn.center.y);
        }
    }
    [color setStroke];
    CGContextDrawPath(context, kCGPathStroke); //根据坐标绘制路径
}

@end
