//
//  ViewController.m
//  LKAssociatePlan
//
//  Created by 宋金峰 on 2019/2/13.
//  Copyright © 2019 宋金峰. All rights reserved.
//

#import "ViewController.h"
#import "LKAssociate.h"
#import <MobileCoreServices/MobileCoreServices.h>

@interface ViewController ()<UISearchBarDelegate,UITextFieldDelegate>
@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, strong) UITextField *textField;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UISearchBar *searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(30, 20, 300, 50)];
    searchBar.placeholder = @"搜索内容";
    searchBar.delegate = self;
    [self.view addSubview:searchBar];
    [searchBar openAssociateWithIdentifier:@""];
    searchBar.associateDelegate.selectBlock = ^(UIView<LKAssociateProtocol> *subView, NSInteger index, NSString *content) {
        UISearchBar *searchBar = (UISearchBar *)subView;
        [searchBar resignFirstResponder];
    };
    self.searchBar = searchBar;
    
    
    UITextField *tf = [[UITextField alloc]initWithFrame:CGRectMake(30, 150, 300, 50)];
    tf.delegate = self;
    tf.placeholder = @"哈哈哈";
    tf.layer.borderWidth = 1.0;
    tf.layer.borderColor = [UIColor blackColor].CGColor;
    [self.view addSubview:tf];
//    [tf openAssociateWithIdentifier:@""];
    [tf openAssociateWithSuffixArr:@[@"@qq.com",@"@163.com",@"@126.com",@"@1263.com"]];
    [tf addTarget:self action:@selector(textFieldDidChange:) forControlEvents:(UIControlEventEditingChanged)];
    self.textField = tf;
    
    
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 350, 50, 50)];
    button.backgroundColor = [UIColor greenColor];
    [button addTarget:self action:@selector(buttonAction:) forControlEvents:(UIControlEventTouchUpInside)];
    button.tag = 1;
    [self.view addSubview:button];
    
    
    UIButton *button2 = [[UIButton alloc]initWithFrame:CGRectMake(100, 350, 50, 50)];
    button2.backgroundColor = [UIColor greenColor];
    [button2 addTarget:self action:@selector(buttonAction:) forControlEvents:(UIControlEventTouchUpInside)];
    button2.tag = 2;
//    [self.view addSubview:button2];
    
    
    NSArray *extensionArray = [NSArray arrayWithObjects:@"doc", @"docx", @"ppt", @"pptx", @"xls", @"xlsx",@"mp3",@"mp4",@"rft",@"rtf",@"pages",@"key",@"numbers",@"mv",nil];
    
    for (int i=0; i<[extensionArray count]; i++) {
        NSString *fileExtension = [extensionArray objectAtIndex:i];
        NSString *utiString = (__bridge NSString *)UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension,(__bridge CFStringRef)fileExtension,NULL);
        NSLog(@"Extension: %@ UTI:%@",fileExtension,utiString);
    }
}

- (void)buttonAction:(UIButton *)button{
    if (button.tag == 1) {
        NSArray *arr = @[@"测试内容",@"hahahaha",@"这么show的吗",@"看小破求了吗",@"3135131341",@"嘿嘿嘿",@"no just do it"];
        NSInteger index = (NSInteger)arc4random_uniform((int)arr.count);
        NSString *key = arr[index];
        [self.searchBar saveAssociateContent:key];
    }else{
        [self.searchBar showAssociateView];
        NSLog(@"%@",[self.searchBar showAssociateContentsForKey:self.searchBar.text]);
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    [self.view endEditing:YES];
}


#pragma mark - searchbar delegate
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    [searchBar showAssociateView];
}
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
    [searchBar showAssociateView];
    return YES;
}
- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar{
    [searchBar saveAssociateContent:searchBar.text];
    [searchBar hideAssociateView];
    return YES;
}

#pragma mark - textfield delegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    [textField showAssociateView];
    return YES;
}
- (void)textFieldDidEndEditing:(UITextField *)textField{
    [textField saveAssociateContent:textField.text];
    [textField hideAssociateView];
}


- (void)textFieldDidChange:(UITextField *)textField{
    [textField showAssociateView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
