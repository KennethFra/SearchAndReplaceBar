//
//  GMSearchTypeTableTableViewController.h
//  SearchAndReplaceBar
//
//  Created by Permanote on 3/14/17.
//  Copyright © 2017 GnasherMobilesoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GMSearchTypeTable;

@protocol GMSearchTypeTableDelegate <NSObject>

- (void) searchTypeTabledDidChangeSettings:(GMSearchTypeTable * _Nonnull) table ;

@end

#import "GMSearchAndReplaceBar.h"

@interface GMSearchTypeTable : UITableViewController

@property (nonatomic, assign) BarMode mode;
@property (weak) id   <GMSearchTypeTableDelegate >  _Nullable delegate;

@end
