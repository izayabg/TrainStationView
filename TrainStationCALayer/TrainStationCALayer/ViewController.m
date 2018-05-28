//
//  ViewController.m
//  TrainStationCALayer
//
//  Created by MacOsGjf on 2018/5/23.
//  Copyright © 2018年 MacOsGjf. All rights reserved.
//

#import "ViewController.h"
#import "UIButton+EXFont.h"
#import "CustomView.h"

//一行显示最多站点
#define LINE_MAXNUM 3

#define TOP_MARGIN 60

#define buttonSizeHeight 40

@interface ViewController () <CALayerDelegate, CAAnimationDelegate>

@property(nonatomic, strong)NSArray *stations;

@property(nonatomic, strong)NSArray *stationButtons;

@property(nonatomic, assign)NSInteger startStation;
@property(nonatomic, assign)NSInteger endStation;

@property(nonatomic, weak)CustomView *cv;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.startStation = -1;
    self.endStation = -1;
    [self setupUI];

    
   
}

/**
 界面元素
 */
- (void)setupUI {
    
    CustomView *cv = [[CustomView alloc] initWithFrame:CGRectMake(20, 150, self.view.frame.size.width-40, (self.stations.count/LINE_MAXNUM+1)*buttonSizeHeight+(self.stations.count/3)*TOP_MARGIN)];
    cv.backgroundColor = [UIColor purpleColor];
    [self.view addSubview:cv];
    self.cv = cv;
    UIFont *font = [UIFont systemFontOfSize:24];
    CGSize size = CGSizeMake(MAXFLOAT, 30.0f);
    NSMutableArray *mutable = [NSMutableArray arrayWithCapacity:self.stations.count];
    for (int i = 0; i<self.stations.count; i++) {
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectZero];
        [button setTitle:self.stations[i] forState:UIControlStateNormal];
        [button setBackgroundColor:[UIColor blueColor]];
        
        [button addTarget:self action:@selector(didClickButton:) forControlEvents:UIControlEventTouchUpInside];
        [cv addSubview:button];
        NSString *content = self.stations[i];
        CGSize buttonSize = [content boundingRectWithSize:size
                                                  options:NSStringDrawingTruncatesLastVisibleLine  | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                               attributes:@{ NSFontAttributeName:font}
                                                  context:nil].size;
        
        if (i%LINE_MAXNUM == i%(LINE_MAXNUM*2)) {
            button.frame = CGRectMake(cv.frame.size.width/(LINE_MAXNUM+1)*(i%LINE_MAXNUM+1)-(buttonSize.width/2),
                                      TOP_MARGIN*(i/3)+buttonSizeHeight*(i/3),
                                      buttonSize.width,
                                      buttonSizeHeight);
        }else {
            button.frame = CGRectMake(cv.frame.size.width/(LINE_MAXNUM+1)*(LINE_MAXNUM - i%LINE_MAXNUM)-(buttonSize.width/2),
                                      TOP_MARGIN*(i/3)+buttonSizeHeight*(i/3),
                                      buttonSize.width,
                                      buttonSizeHeight);
        }
        
        [mutable addObject:button];
    }
    self.stationButtons = [NSArray arrayWithArray:mutable];
  
    cv.lineCount = LINE_MAXNUM;
    cv.count = self.stationButtons.count;
    cv.buttonArray = self.stationButtons;
    [cv setNeedsDisplay];
    
    
    //Solution #1
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:5.0];
    //    [UIView setAnimationTransition:(UIViewAnimationTransition)110 forView:view cache:NO];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self.view cache:NO];
    [UIView commitAnimations];
    
    //Solution #2
    CATransition *animation = [CATransition animation];
    [animation setDelegate:self];
    [animation setDuration:5.0f];
    //    [animation setTimingFunction:UIViewAnimationCurveEaseInOut];
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    [animation setType:@"rippleEffect"];
    [cv.layer addAnimation:animation forKey:NULL];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark delegate
- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx {
    
}


#pragma mark action
- (void)didClickButton:(UIButton *)sender {
    NSInteger nowStation = [self.stationButtons indexOfObject:sender];
    //设置起始站和终点站
    if (self.startStation <0) {
        //无起点站
        self.startStation = nowStation;
        sender.backgroundColor = [UIColor redColor];
        return;
    }else if (self.startStation>=0 && nowStation==self.startStation){
        self.endStation = -1;
        self.startStation = -1;
    }else if (self.startStation>=0 && nowStation > self.startStation){
        //有起点站
        self.endStation = nowStation;
    }else if (self.startStation>=0 && nowStation<self.startStation){
        self.endStation = self.startStation;
        self.startStation = nowStation;
    }
    self.cv.startStation = self.startStation;
    self.cv.endStation = self.endStation;
    [self.cv setNeedsDisplay];
    //修改界面
    for (NSInteger i = 0; i<self.stationButtons.count; i++) {
        UIButton *tempBtn = self.stationButtons[i];
        if (i>=self.startStation && i<=self.endStation) {
            tempBtn.backgroundColor = [UIColor redColor];
        }else {
            tempBtn.backgroundColor = [UIColor blueColor];
        }
    }
}

#pragma mark lazy
- (NSArray *)stations {
    if (!_stations) {
        _stations = @[@"武夷山", @"建瓯", @"南平", @"古田", @"福州", @"莆田", @"泉州", @"晋江", @"厦门北"];
        return _stations;
    }
    return _stations;
}

@end
