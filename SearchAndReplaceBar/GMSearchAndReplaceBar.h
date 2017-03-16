//
//  GMSearchAndReplaceBar.h
//  SearchAndReplaceBar
//
//  Created by Permanote on 3/14/17.
//  Copyright © 2017 GnasherMobilesoft. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSInteger {
    BarModeSearch = 0,
    BarModeSearchAndReplace
} BarMode;

@class GMSearchAndReplaceBar;

@protocol GMSearchAndReplaceBarDelegate <NSObject>

- (void) searchNextAction: (GMSearchAndReplaceBar *) searchAndReplaceBar;
- (void) searchPreviousAction: (GMSearchAndReplaceBar *) searchAndReplaceBar;
- (void) replaceAction: (GMSearchAndReplaceBar *) searchAndReplaceBar;

@end

#import "GMSearchTypeTable.h"

@interface GMSearchAndReplaceBar : UIViewController <GMSearchTypeTableDelegate, UITextFieldDelegate>

@property (nonatomic, strong) UITextField * searchField;
@property (nonatomic, strong) UITextField * replaceField;
@property (nonatomic, assign) BarMode mode;

@property (nonatomic, weak) id <GMSearchAndReplaceBarDelegate> delegate;

- (CGFloat) height;
@end
