//
//  ViewController.m
//  数据持久化(1)属性列表
//
//  Created by Azuo on 16/1/5.
//  Copyright © 2016年 Azuo. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController

//获取属性列表路径 dataFilepath
-(NSString *)dataFilepath
{
    //NSDocumentDirectory: Documents目录的路径.
    //NSUserDomainMask   : 将搜索限制在应用的沙盒中。
    //返回的paths是一个匹配路径的数组，所以位于索引0处是Document目录(因为只有一个目录。)
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *pathDirectory = [paths objectAtIndex:0];
    return [pathDirectory stringByAppendingPathComponent:@"data.txt"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *filePath = [self dataFilepath];
    //判断是否存在属性列表文件
    if([[NSFileManager defaultManager] fileExistsAtPath:filePath])
    {
        //存在，则把数据赋值给文本框
        NSArray *ar= [[NSArray alloc]initWithContentsOfFile:filePath];
        for(int i =0;i<4;i++)
        {
            UITextField *textField = self.lineFields[i];
            textField.text = ar[i];
        }
    }
    //如果应用进入后台：
    UIApplication *app = [UIApplication sharedApplication];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(applicationWillResignActiveNotification:) name:UIApplicationWillResignActiveNotification object:app];
}

//应用进入后台时执行：
-(void)applicationWillResignActiveNotification:(NSNotification *)notification
{
    NSString *pathFile = [self dataFilepath];
    //把文本框上面的字符串信息放在数组里，
    NSArray *array = [self.lineFields valueForKey:@"text"];
    //把字符串数组写入文件。
    [array writeToFile:pathFile atomically:YES];
}

@end
