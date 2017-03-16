//
//  GMSearchAndReplaceBar.m
//  SearchAndReplaceBar
//
//  Created by Permanote on 3/14/17.
//  Copyright © 2017 GnasherMobilesoft. All rights reserved.
//

#import "GMSearchAndReplaceBar.h"
#import "GMSearchTypeTable.h"

#import <Masonry/Masonry.h>

//FindReplace_ChromeBG.png
//FindReplace_Gear.png
//FindReplace_Glyph_Clear.png
//FindReplace_Glyph_Find.png
//FindReplace_Glyph_Replace.png
//FindReplace_Line.png
//FindReplace_Next.png
//FindReplace_Previous.png
//FindReplace_TextField.png
//FindToolIcon.png

@interface GMSearchAndReplaceBar()
@property (nonatomic, strong) NSLayoutConstraint * searchFieldRightConstraint;
@property (nonatomic, strong) NSLayoutConstraint * replaceContainerLeftConstraintHidden;
@property (nonatomic, strong) UIButton * settingsButton;
@property (nonatomic, strong) UIButton * replaceButton;
@property (nonatomic, strong) UIButton * nextButton;
@property (nonatomic, strong) UIButton * previousButton;
@property (nonatomic, strong) UIImageView * backgroundImage;
@property (nonatomic, strong) UIView * replaceContainer;
@end

@implementation GMSearchAndReplaceBar

- (void) viewDidLoad {
    self.view.clipsToBounds = true;
    self.backgroundImage = [[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"FindReplace_ChromeBG"] resizableImageWithCapInsets:UIEdgeInsetsMake(7.0, 7.0, 7.0, 7.0)]];

    // ===== Settings Button =======
    self.settingsButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    UIImage * settingsImage = [UIImage imageNamed:@"FindReplace_Gear"];
    UIImage * settingsTintedImage = [settingsImage imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];

    [self.settingsButton setImage:settingsTintedImage forState:UIControlStateNormal];
    self.settingsButton.tintColor = [UIColor orangeColor];
    [self.settingsButton addTarget:self action:@selector(settingsTouched:) forControlEvents:UIControlEventTouchUpInside];
    self.settingsButton.adjustsImageWhenHighlighted = true;
    self.settingsButton.adjustsImageWhenDisabled = true;

    // ===== Replace Button =======

        self.replaceButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    NSMutableAttributedString * titleString = [[NSMutableAttributedString alloc] initWithString:@"Replace" attributes:@{NSUnderlineStyleAttributeName: @(NSUnderlineStyleSingle)}];
    [self.replaceButton setAttributedTitle:titleString forState:UIControlStateNormal];
    [self.replaceButton addTarget:self action:@selector(replaceAction:) forControlEvents:UIControlEventTouchUpInside];
    self.replaceButton.adjustsImageWhenHighlighted = true;
    self.replaceButton.adjustsImageWhenDisabled = true;

    // ===== Next / Previous Buttons =======

    UIImage * image = [UIImage imageNamed:@"FindReplace_Next"];
    UIImage * tintedImage = [image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    self.nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.nextButton setImage:tintedImage forState:UIControlStateNormal];
    self.nextButton.tintColor = [UIColor orangeColor];
    [self.nextButton setContentMode:UIViewContentModeScaleAspectFit];
    [self.nextButton addTarget:self action:@selector(nextAction:) forControlEvents:UIControlEventTouchUpInside];
    self.nextButton.adjustsImageWhenHighlighted = true;
    self.nextButton.adjustsImageWhenDisabled = true;

    image = [UIImage imageNamed:@"FindReplace_Previous"];
    tintedImage = [image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    self.previousButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.previousButton setImage:tintedImage forState:UIControlStateNormal];
    [self.previousButton addTarget:self action:@selector(previousAction:) forControlEvents:UIControlEventTouchUpInside];
    self.previousButton.tintColor = [UIColor orangeColor];
    self.previousButton.adjustsImageWhenHighlighted = true;
    self.previousButton.adjustsImageWhenDisabled = true;

    // ======= Text Fields
    
    self.searchField = [[UITextField alloc] init];
    self.replaceField = [[UITextField alloc] init];
    
    self.replaceField.background = [[UIImage imageNamed:@"FindReplace_TextField"] resizableImageWithCapInsets:UIEdgeInsetsMake(7.0, 7.0, 7.0, 7.0)];
    self.searchField.background = [[UIImage imageNamed:@"FindReplace_TextField"] resizableImageWithCapInsets:UIEdgeInsetsMake(7.0, 7.0, 7.0, 7.0)];
    self.replaceField.leftView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"FindReplace_Glyph_Replace"]];
    self.searchField.leftView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"FindReplace_Glyph_Find"]];

    self.replaceContainer = [[UIView alloc] init];
    self.replaceContainer.backgroundColor = [UIColor clearColor];
    self.replaceContainer.userInteractionEnabled = false;

    [self setupTextField:self.replaceField];
    [self setupTextField:self.searchField];

    [self.view addSubview:self.backgroundImage];
    [self.view addSubview:self.settingsButton];
    [self.view addSubview:self.searchField];
    [self.view addSubview:self.replaceContainer];
    [self.view addSubview:self.nextButton];
    [self.view addSubview:self.previousButton];
    
    [self.replaceContainer addSubview:self.replaceField];
    [self.replaceContainer addSubview:self.replaceButton];
    self.replaceContainer.alpha = 0;
    
    self.replaceContainer.userInteractionEnabled = true;
    self.view.userInteractionEnabled = true;
    
    [self setupConstraints];
}

- (void) setupTextField:(UITextField *) textField {
    textField.borderStyle = UITextBorderStyleNone;
    textField.textColor = [UIColor darkTextColor];
    textField.autocorrectionType = UITextAutocorrectionTypeNo;
    textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    textField.leftViewMode = UITextFieldViewModeAlways;
    
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self changeMode:BarModeSearch];
}

- (CGFloat) height {
    return 44.0;
}

- (void)setReplaceButtonsEnabled:(BOOL) enabled {
    self.previousButton.enabled = enabled;
    self.nextButton.enabled = enabled;
    self.replaceButton.enabled = enabled;
    
    self.previousButton.alpha = enabled ? 1.0 : .15;
    self.nextButton.alpha = enabled ? 1.0 : .15;
    self.replaceButton.alpha = enabled ? 1.0 : .15;
}


- (void) setupConstraints {
    [self.backgroundImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    // Replace Items
    [self.replaceButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.replaceContainer.mas_right);
        make.centerY.equalTo(self.replaceContainer);
        make.height.equalTo(@44);
        make.width.equalTo(@70);
    }];

    [self.replaceField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.replaceContainer.mas_centerY);
        make.right.equalTo(self.replaceButton.mas_left);
        make.height.equalTo(self.searchField.mas_height);
        make.left.equalTo(self.replaceContainer.mas_left);
    }];
    
    [self.replaceContainer mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.view);
        make.height.equalTo(self.view);
        make.right.equalTo(self.previousButton.mas_left).offset(-8);
        make.left.equalTo(self.view.mas_centerX);
    }];

    // Search Items
    [self.settingsButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_leftMargin).with.offset(16);
        make.centerY.equalTo(self.view);
        make.height.equalTo(@28);
        make.width.equalTo(@28);
    }];
    
    [self.searchField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.view);
        make.left.equalTo(self.settingsButton.mas_right).with.offset(16);
        make.height.equalTo(@31);
    }];
    
    [self adjustSearchFieldForMode];
    
    [self.nextButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view.mas_right);
        make.centerY.equalTo(self.view);
        make.height.equalTo(@28);
        make.width.equalTo(@44);
    }];
    
    [self.previousButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.nextButton.mas_left);
        make.centerY.equalTo(self.view);
        make.height.equalTo(@28);
        make.width.equalTo(@44);
    }];

    
}
- (void) adjustSearchFieldForMode {
    
    [self.view removeConstraint:self.searchFieldRightConstraint];
    
    if (self.mode == BarModeSearch) {
        self.searchFieldRightConstraint = [NSLayoutConstraint constraintWithItem:self.searchField attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.previousButton attribute:NSLayoutAttributeLeft multiplier:1 constant:0];
        [self.view addConstraint:self.searchFieldRightConstraint];
    }
    else {
        self.searchFieldRightConstraint = [NSLayoutConstraint constraintWithItem:self.searchField attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.replaceContainer attribute:NSLayoutAttributeLeft multiplier:1 constant:-16];
        [self.view addConstraint:self.searchFieldRightConstraint];
    }

}
- (void) changeMode:(BarMode) mode {
    
    if (self.mode == mode) return;
    
    self.mode = mode;

    if (self.mode == BarModeSearch) {
        [UIView animateWithDuration:0.1 animations:^{
            self.replaceContainer.alpha = 0;
        } completion:^(BOOL finished) {
            
            [self adjustSearchFieldForMode];

            [UIView animateWithDuration:0.2
                             animations:^{
                                 [self.view layoutIfNeeded];
                             }];
        }];
    }
    else {
        [self adjustSearchFieldForMode];

        [UIView animateWithDuration:0.2 animations:^{
            [self.view layoutIfNeeded];
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.1
                             animations:^{
                                 self.replaceContainer.alpha = 1;
                             }];
        }];
    }
}

- (void) searchTypeTabledDidChangeSettings:(GMSearchTypeTable *)table {
    [self dismissViewControllerAnimated:YES completion:NULL];
    
    if (self.mode == BarModeSearch)
        [self changeMode:BarModeSearchAndReplace];
    else
        [self changeMode:BarModeSearch];
}

#pragma mark Actions

- (void) replaceAction:(id) sender {
    [self.delegate replaceAction:self];
}

- (void) nextAction:(id) sender {
    [self.delegate searchNextAction:self];
}

- (void) previousAction:(id) sender {
    [self.delegate searchPreviousAction:self];
}

- (void) settingsTouched: (UIButton * ) sender  {
    GMSearchTypeTable * popoverContent = [[GMSearchTypeTable alloc] init];
    popoverContent.modalPresentationStyle = UIModalPresentationPopover;
    popoverContent.preferredContentSize = CGSizeMake(200,180);
    popoverContent.delegate = self;
    
    UIPopoverPresentationController * popover = [popoverContent popoverPresentationController];
    popover.sourceView = sender;
    popover.permittedArrowDirections = UIPopoverArrowDirectionDown | UIPopoverArrowDirectionUp;
    
    [self presentViewController:popoverContent animated:true completion:nil];
}

@end
