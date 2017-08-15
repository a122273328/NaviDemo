//
//  MapTool.m
//  xss
//
//  Created by wzh on 2017/8/14.
//  Copyright © 2017年 Facebook. All rights reserved.
//

#import "MapTool.h"
#define WEAKSELF     typeof(self) __weak weakSelf = self;
@implementation MapTool


+ (MapTool *)sharedMapTool{


  static MapTool *mapTool = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    mapTool = [[MapTool alloc] init];
  });
  
  return mapTool;
  
}
/**
 调用三方导航
 
 @param coordinate 经纬度
 @param name 地图上显示的名字
 @param tager 当前控制器
 */
- (void)navigationActionWithCoordinate:(CLLocationCoordinate2D)coordinate WithENDName:(NSString *)name tager:(UIViewController *)tager{

  WEAKSELF
  UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"导航到设备" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
  
  [alertController addAction:[UIAlertAction actionWithTitle:@"苹果自带地图" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    
    [weakSelf appleNaiWithCoordinate:coordinate andWithMapTitle:name];
    
  }]];
  //判断是否安装了高德地图，如果安装了高德地图，则使用高德地图导航
  if ( [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"iosamap://"]]) {
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"高德地图" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
      
      NSLog(@"alertController -- 高德地图");
      [weakSelf aNaviWithCoordinate:coordinate andWithMapTitle:name];
      
    }]];
  }
  //判断是否安装了百度地图，如果安装了百度地图，则使用百度地图导航
  if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"baidumap://"]]) {
    [alertController addAction:[UIAlertAction actionWithTitle:@"百度地图" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
      NSLog(@"alertController -- 百度地图");
      [weakSelf baiduNaviWithCoordinate:coordinate andWithMapTitle:name];
      
    }]];
  }
  //添加取消选项
  [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    [alertController dismissViewControllerAnimated:YES completion:nil];
  }]];
  
  //显示alertController
  [tager presentViewController:alertController animated:YES completion:nil];
}

//唤醒苹果自带导航
- (void)appleNaiWithCoordinate:(CLLocationCoordinate2D)coordinate andWithMapTitle:(NSString *)map_title{
  
    MKMapItem *currentLocation = [MKMapItem mapItemForCurrentLocation];
    MKMapItem *tolocation = [[MKMapItem alloc] initWithPlacemark:[[MKPlacemark alloc] initWithCoordinate:coordinate addressDictionary:nil]];
    tolocation.name = map_title;
    [MKMapItem openMapsWithItems:@[currentLocation,tolocation] launchOptions:@{MKLaunchOptionsDirectionsModeKey:MKLaunchOptionsDirectionsModeDriving,
                                                                               MKLaunchOptionsShowsTrafficKey:[NSNumber numberWithBool:YES]}];
}


/**
 高德导航
 */
- (void)aNaviWithCoordinate:(CLLocationCoordinate2D)coordinate andWithMapTitle:(NSString *)map_title{
  
    NSString *urlsting =[[NSString stringWithFormat:@"iosamap://navi?sourceApplication= &backScheme= &lat=%f&lon=%f&dev=0&style=2",coordinate.latitude,coordinate.longitude]stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [[UIApplication  sharedApplication]openURL:[NSURL URLWithString:urlsting]];
  
}

- (void)baiduNaviWithCoordinate:(CLLocationCoordinate2D)coordinate andWithMapTitle:(NSString *)map_title{
  
  
    NSString *urlsting =[[NSString stringWithFormat:@"baidumap://map/direction?origin={{我的位置}}&destination=latlng:%f,%f|name=目的地&mode=driving&coord_type=gcj02",coordinate.latitude,coordinate.longitude] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlsting]];
  
}


@end
