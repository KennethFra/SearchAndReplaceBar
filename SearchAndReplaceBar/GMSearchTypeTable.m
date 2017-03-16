//
//  GMSearchTypeTableTableViewController.m
//  SearchAndReplaceBar
//
//  Created by Permanote on 3/14/17.
//  Copyright © 2017 GnasherMobilesoft. All rights reserved.
//

#import "GMSearchTypeTable.h"

@interface GMSearchTypeTable ()

@end

@implementation GMSearchTypeTable

- (instancetype) initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:UITableViewStylePlain];
    
    if (self) {
        self.tableView.backgroundColor = [UIColor clearColor];
        self.tableView.showsVerticalScrollIndicator = false;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.clearsSelectionOnViewWillAppear = YES;
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 1) {
        return 8;
    }
    else {
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    if (indexPath.section == 1) {

        if (indexPath.row == 0)
            cell.textLabel.text = @"Match Case";
        else {
            cell.textLabel.text = @"Whole Words";
        }
        
        UISwitch *aSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(0, 0, 94, 27)];
        aSwitch.tag = indexPath.row;
        [aSwitch addTarget:self action:@selector(switchChanged:) forControlEvents:UIControlEventValueChanged];
        cell.accessoryView = aSwitch;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    else {
        if (indexPath.row == 0)
            cell.textLabel.text = @"Find";
        else {
            cell.textLabel.text = @"Find and Replace";
        }

        cell.accessoryType = UITableViewCellAccessoryNone;
        
        if ((self.mode == BarModeSearch) && (indexPath.row == 0)) {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }
        else if ((self.mode == BarModeSearchAndReplace) && (indexPath.row == 1)) {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }
    }

    return cell;
}

- (void) switchChanged:(UISwitch *) control {
    
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.mode == BarModeSearch) {
        self.mode = BarModeSearchAndReplace;
    }
    else {
        self.mode = BarModeSearch;
    }
    [self.tableView reloadData];
    
    [self.delegate searchTypeTabledDidChangeSettings:self];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
