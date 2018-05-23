//
//  ViewController.m
//  TrainStationCALayer
//
//  Created by MacOsGjf on 2018/5/23.
//  Copyright © 2018年 MacOsGjf. All rights reserved.
//

#import "ViewController.h"
#import "UIButton+EXFont.h"
#import <SDAutoLayout.h>

//一行显示最多站点
#define LINE_MAXNUM 3

#define TOP_MARGIN 60

@interface ViewController ()

@property(nonatomic, strong)NSArray *stations;

@property(nonatomic, strong)NSArray *stationButtons;

@property(nonatomic, assign)NSInteger startStation;
@property(nonatomic, assign)NSInteger endStation;


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
    
    NSMutableArray *mutable = [NSMutableArray arrayWithCapacity:self.stations.count];
    for (int i = 0; i<self.stations.count; i++) {
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectZero];
        [button setTitle:self.stations[i] forState:UIControlStateNormal];
        [button setBackgroundColor:[UIColor blueColor]];
        UIFont *font = [UIFont systemFontOfSize:24];
        [button addTarget:self action:@selector(didClickButton:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
        NSString *content = self.stations[i];
        CGSize size = CGSizeMake(MAXFLOAT, 30.0f);
        CGSize buttonSize = [content boundingRectWithSize:size
                                                  options:NSStringDrawingTruncatesLastVisibleLine  | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                               attributes:@{ NSFontAttributeName:font}
                                                  context:nil].size;
        
        if (i%LINE_MAXNUM == i%(LINE_MAXNUM*2)) {
            button.frame = CGRectMake(self.view.frame.size.width/(LINE_MAXNUM+1)*(i%LINE_MAXNUM+1)-(buttonSize.width/2),
                                      150+TOP_MARGIN*(i/3)+buttonSize.height*(i/3),
                                      buttonSize.width,
                                      buttonSize.height);
        }else {
            button.frame = CGRectMake(self.view.frame.size.width/(LINE_MAXNUM+1)*(LINE_MAXNUM - i%LINE_MAXNUM)-(buttonSize.width/2),
                                      150+TOP_MARGIN*(i/3)+buttonSize.height*(i/3),
                                      buttonSize.width,
                                      buttonSize.height);
        }
        
        [mutable addObject:button];
    }
    
    self.stationButtons = [NSArray arrayWithArray:mutable];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark action
- (void)didClickButton:(UIButton *)sender {
    NSInteger nowStation = [self.stationButtons indexOfObject:sender];
    //设置起始站和终点站
    if (self.startStation <0) {
        //无起点站
        self.startStation = nowStation;
    }else if (self.startStation>=0 && self.endStation == -1){
        //有起点站无终点站
        
    }
    
    //修改界面
    for (NSInteger i = 0; i<self.stations.count; i++) {
        UIButton *tempBtn = self.stationButtons[i];
        if (i < self.startStation) {
            [tempBtn setBackgroundColor:[UIColor darkGrayColor]];
        }else if ((i>= self.startStation && i<= self.endStation) || i == self.startStation){
            [tempBtn setBackgroundColor:[UIColor blueColor]];
        }else {
            [tempBtn setBackgroundColor:[UIColor blueColor]];
        }
    }
}

#pragma mark lazy
- (NSArray *)stations {
    if (!_stations) {
        _stations = @[@"武夷山", @"武夷山东", @"建瓯", @"南平", @"古田", @"福州", @"莆田", @"泉州", @"晋江", @"厦门北", @"漳州"];
        return _stations;
    }
    return _stations;
}

@end
