//
//  ViewController.m
//  SearchAndReplaceBar
//
//  Created by Permanote on 3/14/17.
//  Copyright © 2017 GnasherMobilesoft. All rights reserved.
//

#import "ViewController.h"
#import "GMSearchAndReplaceBar.h"
#import <Masonry/Masonry.h>


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self addSearchBar];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void) addSearchBar {
    GMSearchAndReplaceBar * searchBar = [[GMSearchAndReplaceBar alloc] init];
    
    [self.view addSubview:searchBar.view];
    [self addChildViewController:searchBar];
    
    [searchBar.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.view);
        make.height.equalTo(@(searchBar.height));
        make.left.equalTo(self.view.mas_leftMargin);
        make.right.equalTo(self.view.mas_rightMargin);
    }];
    
    [searchBar becomeFirstResponder];
    
}

@end
