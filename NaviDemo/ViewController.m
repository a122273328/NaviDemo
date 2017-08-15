//
//  ViewController.m
//  NaviDemo
//
//  Created by wzh on 2017/8/15.
//  Copyright © 2017年 WZH. All rights reserved.
//

#import "ViewController.h"
#import "MapTool.h"
@interface ViewController ()


/**
 经纬度
 */
@property (nonatomic, assign)CLLocationCoordinate2D coordinate;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)naviAction:(id)sender {
    self.coordinate =  CLLocationCoordinate2DMake(34.72, 113.92);
    [[MapTool sharedMapTool] navigationActionWithCoordinate:self.coordinate WithENDName:@"郑州市中牟县白沙镇刘申庄" tager:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
