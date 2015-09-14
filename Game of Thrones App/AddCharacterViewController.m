//
//  ViewController.m
//  Game of Thrones App
//
//  Created by Mateo Mauricio Samaranch on 14/09/15.
//  Copyright (c) 2015 matsam. All rights reserved.
//


#import "AddCharacterViewController.h"

static NSUInteger const padding = 8;

static NSUInteger const margin = 10;

static NSUInteger const heightUnit = 40;

static NSUInteger const initialUpperMargin = 40;


@interface AddCharacterViewController () <UITextFieldDelegate, UITextViewDelegate>

@property (strong, nonatomic) UITextField *nameTextField;

@property (assign, nonatomic) CGSize screenSize;

@property (strong, nonatomic) UITextView *biographyTextView;

@property (strong, nonatomic) UISegmentedControl *houseSegmentedControl;

@property (strong, nonatomic) UIButton *addCharacterButton;

@end

@implementation AddCharacterViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.screenSize = self.view.frame.size;
    
    [self controlMethod];
}

- (void)controlMethod
{
    [self drawName];
    
    [self drawBiography];
    
    [self drawHouseSegmentedControl];
    
    [self drawAddCharacterButton];
}


- (void) drawName
{
    UILabel *nameLabel = [[UILabel alloc]init];
    
    nameLabel.text = @"Nombre";
    
    [self placeView:nameLabel underView:nil withHeightUnits:1];
    
    self.nameTextField = [[UITextField alloc] init];
    
    self.nameTextField.borderStyle = UITextBorderStyleRoundedRect;
    
    self.nameTextField.delegate = self;
    
    [self placeView:self.nameTextField underView:nameLabel withHeightUnits:1];
    
}

- (void) drawBiography
{
    UILabel *biographyLabel = [[UILabel alloc]init];
    
    biographyLabel.text = @"Biography";
    
    [self placeView:biographyLabel underView:self.nameTextField withHeightUnits:1];
    
    self.biographyTextView = [[UITextView alloc] init];
    
    [self showBiographyPlaceHolder];
    
    self.biographyTextView.delegate = self;
    
    [self placeView:self.biographyTextView underView:biographyLabel withHeightUnits:2];
}


- (void) showBiographyPlaceHolder
{
    self.biographyTextView.text = @"Ecribe la biografía del personaje...";
    
    self.biographyTextView.textColor = [UIColor lightGrayColor];
    
    self.biographyTextView.tag = 0;
}

- (void) drawHouseSegmentedControl
{
    self.houseSegmentedControl = [[UISegmentedControl alloc]initWithItems:@[@"Stark",
                                                                            @"Lannister",
                                                                            @"Targaryen",
                                                                            @"Baratheon",
                                                                            @"Tully"]];
    
    [self placeView:self.houseSegmentedControl underView:self.biographyTextView withHeightUnits:1];
}

- (void) drawAddCharacterButton
{
    self.addCharacterButton = [UIButton buttonWithType:UIButtonTypeSystem];
    
    [self.addCharacterButton setTitle:@"Add" forState:UIControlStateNormal];
    
    [self placeView:self.addCharacterButton underView:self.houseSegmentedControl withHeightUnits:1];
    
}

#pragma mark - TextViewDelegate

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if (textView == self.biographyTextView)
    {
        textView.text = @"";
        
        textView.textColor = [UIColor blackColor];
        
        textView.tag = 1;
    }
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    if (textView == self.biographyTextView && [textView.text length] == 0)
    {
        [self showBiographyPlaceHolder];
    }
}

#pragma  mark - TextFieldDelegate

- (void) textFieldDidEndEditing:(UITextField *)textField
{
    if (textField == self.nameTextField)
    {
        NSString *nameString = textField.text;
        
        [self.addCharacterButton setTitle:[NSString stringWithFormat:@"Add %@", nameString] forState:UIControlStateNormal];
    }
    
    [textField resignFirstResponder];
}

- (BOOL) textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}

#pragma mark - Control Positioning

- (void) placeView: (UIView *)bottomView underView:(UIView *)upperView withHeightUnits: (CGFloat)heightUnits
{
   
    if (!upperView)
    {
        bottomView.frame = CGRectMake(padding, initialUpperMargin, self.screenSize.width - 2*padding, heightUnit * heightUnits);
    }
    else
    {
         bottomView.frame = [self frameUnderFrame:upperView.frame withHeightUnits:heightUnits];
    }
    
    [self.view addSubview:bottomView];
}

- (CGRect)frameUnderFrame: (CGRect)sourceFrame withHeightUnits: (CGFloat)heightUnits
{
    CGFloat y = sourceFrame.origin.y + sourceFrame.size.height + margin;
    
    return CGRectMake(padding, y, self.screenSize.width - 2*padding, heightUnit * heightUnits);
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
