//
//  BEPLookAndFeelViewController.m
//  BepBop
//
//  Created by Hiedi Utley on 9/10/13.
//  Copyright (c) 2013 Bleeding Edge Press. All rights reserved.
//

#import "BEPLookAndFeelViewController.h"

@interface BEPLookAndFeelViewController ()

@property (nonatomic, weak) UINavigationController* navController;
@property (nonatomic, weak) IBOutlet UILabel* tintedLabel;
@property (nonatomic, weak) IBOutlet UIButton* changeTintButton;

@property (nonatomic, strong) UIColor* savedTintColor;

@end

@implementation BEPLookAndFeelViewController

- (id) initWithNibName:(NSString*)nibNameOrNil bundle:(NSBundle*)nibBundleOrNil
{
    self = [super initWithNibName:@"BEPLookAndFeelView" bundle:nibBundleOrNil];
    if (self)
    {
        // Custom initialization
        self.title = NSLocalizedString(@"Chapter 1", nil);
    }
    return self;
}

- (void) viewDidLoad
{
    [super viewDidLoad];

    //_tintedLabel.hidden = !IS_IOS_7;
    //_changeTintButton.hidden = !IS_IOS_7;
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    _navController = self.navigationController;
    
    if ([_navController.view respondsToSelector:@selector(tintColor:)]) {
        self.savedTintColor = _navController.view.tintColor;
        
        [self changeTintColorTo:[UIColor randomColor]];
    }
}

- (void) viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];

    dispatch_async(dispatch_get_main_queue(), ^{
                       if ([_navController.view respondsToSelector:@selector(setTintColor:)])
                       {
                           _navController.view.tintColor = _savedTintColor;
                       }
                   });
}

#pragma mark IBActions

- (IBAction) changeTintColor:(id)sender
{
    if (IS_IOS_7)
    {
        [self changeTintColorTo:[UIColor randomColor]];
    }
    else
    {
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"iOS6 No-Op" message:@"Since you are running IOS6 you have to use the appearance proxy to change the tintColors..." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
}

- (void) changeTintColorTo:(UIColor*)color
{
    if ([_navController.view respondsToSelector:@selector(setTintColor:)])
    {
        _navController.view.tintColor = color;
    }
}

- (IBAction) showAlert:(id)sender
{
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Tint Color Demo" message:@"The tint colors on the UI should now have a disabled appearance!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
}
@end
