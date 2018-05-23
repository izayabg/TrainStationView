//
//  UIButton+EXFont.m
//  TrainStationCALayer
//
//  Created by MacOsGjf on 2018/5/23.
//  Copyright © 2018年 MacOsGjf. All rights reserved.
//

#import "UIButton+EXFont.h"
#import <objc/runtime.h>

#define IPHONE_HEIGHT [UIScreen mainScreen].bounds.size.height

//不同设备的屏幕比例(当然倍数可以自己控制)
#define SizeScale ((IPHONE_HEIGHT > 568) ? IPHONE_HEIGHT/568 : 1)

@implementation UIButton (EXFont)


void swizzleMethod(Class class, SEL originalSelector, SEL swizzleSelector) {
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method swizzleMethod = class_getInstanceMethod(class, swizzleSelector);
    
    //class_addMethod will fail if original method already exists
    //先尝试添加原 selector 是为了做一层保护，因为如果这个类没有实现 originalSelector ，但其父类实现了，那 class_getInstanceMethod 会返回父类的方法
    BOOL didAddMethod = class_addMethod(class, originalSelector, method_getImplementation(swizzleMethod), method_getTypeEncoding(swizzleMethod));
    
    if (didAddMethod) {
        //class_replaceMethod 该方法本身会尝试调用class_addMethod和method_setImplementation
        class_replaceMethod(class, swizzleSelector, method_getImplementation(swizzleMethod), method_getTypeEncoding(swizzleMethod));
    }else {
        method_exchangeImplementations(originalMethod, swizzleMethod);
    }
}


+ (void)initialize {
    swizzleMethod([self class], @selector(initWithFrame:), @selector(myInitWithFrame:));
}

- (instancetype)myInitWithFrame:(CGRect)frame {
    [self myInitWithFrame:frame];
   
    CGFloat fontSize = self.titleLabel.font.pointSize;
    self.titleLabel.font = [UIFont systemFontOfSize:fontSize*SizeScale];
    
    return self;
}

@end
