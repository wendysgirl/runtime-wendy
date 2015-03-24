//
//  ViewController.m
//  RunningMan
//
//  Created by 丹丹 on 15-3-19.
//  Copyright (c) 2015年 博文卡特. All rights reserved.
//

#import "ViewController.h"
#import "DogClass.h"
#import "CarClass.h"
#import <objc/runtime.h>
@interface ViewController ()<UITextFieldDelegate>
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
//    UITextField *tf  = [[UITextField alloc]initWithFrame:CGRectMake(50, 200, 200, 40)];
//    tf.delegate = self;
//    tf.backgroundColor = [UIColor redColor];
//    [self.view addSubview:tf];
//
//    NSLog(@"111%@",tf.text);
    
    self.view.backgroundColor = [UIColor greenColor];
    DogClass *dog = [[DogClass alloc]init];
    NSLog(@"%p",&dog);
//    arc下不能使用
//    id car = object_copy(dog, sizeof(dog));
    Class aClass;
    aClass = object_getClass(dog);//获取类名
    NSLog(@"%@",NSStringFromClass(aClass));
    
    class_getName([DogClass class]);
    object_getClassName(dog);
    
    NSString *className = [NSString stringWithCString:object_getClassName(dog) encoding:NSUTF8StringEncoding];
    NSLog(@"%@",className);
    
    [dog isKindOfClass:[DogClass class]];
    NSLog(@"%@",NSStringFromClass([DogClass class]));
    
    
    
//    class_addMethod([DogClass class], @selector(click), <#IMP imp#>, <#const char *types#>)
//    class_addMethod(<#__unsafe_unretained Class cls#>, <#SEL name#>, <#IMP imp#>, <#const char *types#>)
    DogClass *instance = [[DogClass alloc]init];
    //    方法添加
//    下面的这种写法会出现警告
//    NSSelectorFromString(@"click");
//    class_addMethod([DogClass class],@selector(click), (IMP)cfunction,"i@:@");
    
    class_addMethod([DogClass class], NSSelectorFromString(@"click"), (IMP)cfunction, "i@:@");
    if ([instance respondsToSelector:NSSelectorFromString(@"click")]) {
        NSLog(@"Yes, instance respondsToSelector:@selector(ocMethod:)");
    } else
    {
        NSLog(@"Sorry");
    }
    
    int a = (int)[instance ocMethod:@"我是一个OC的method，C函数实现"];
    NSLog(@"a:%d", a);
    
    u_int count;
    class_copyPropertyList([DogClass class], &count);
//    class_copyPropertyList(<#__unsafe_unretained Class cls#>, <#unsigned int *outCount#>)
    
    class_getName([DogClass class]);
    object_getClassName(dog);
    
    class_addMethod([DogClass class], NSSelectorFromString(@"afun"), (IMP)cfunction, "i@:@");
#pragma mark 获取当前安装的所有app
//    获取当前安装的所有App
    Class LSApplicationWorkspace_class = objc_getClass("LSApplicationWorkspace");
    NSObject *workspace = [LSApplicationWorkspace_class performSelector:@selector(defaultWorkspace)];
    NSLog(@"apps: %@", [workspace performSelector:@selector(allApplications)]);
    
    
    
    
}

int cfunction(id self, SEL _cmd, NSString *str) {
    NSLog(@"1000%@", str);
    return 10;//随便返回个值
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField;
{
    NSLog(@"222%@",textField.text);
    return YES;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
