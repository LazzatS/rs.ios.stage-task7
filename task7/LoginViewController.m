//
//  LoginViewController.m
//  task7
//
//  Created by Lazzat Seiilova on 03.07.2021.
//

#import "LoginViewController.h"
#define littleBlueBoyColor [UIColor colorWithRed:128/255.0 green:164/255.0 blue:237/255.0 alpha:1.0]
#define littleBlueBoyColorAlphaButton [UIColor colorWithRed:128/255.0 green:164/255.0 blue:237/255.0 alpha:0.2]
#define littleBlueBoyColorAlphaText [UIColor colorWithRed:128/255.0 green:164/255.0 blue:237/255.0 alpha:0.4]
#define littleBlueBoyColorAlphaDisabled [UIColor colorWithRed:128/255.0 green:164/255.0 blue:237/255.0 alpha:0.5]
#define venetianRedColor [UIColor colorWithRed:194/255.0 green:1/255.0 blue:20/255.0 alpha:1]
#define turquoiseGreenColor [UIColor colorWithRed:145/255.0 green:199/255.0 blue:177/255.0 alpha:1]
#define roundButtonWidth 50

@interface LoginViewController () <UITextViewDelegate, UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UITextField *loginTextField;
@property (strong, nonatomic) IBOutlet UITextField *passwordTextField;
@property (strong, nonatomic) IBOutlet UIButton *authorizeButton;
@property (strong, nonatomic) IBOutlet UIButton *roundButton;
@end

@interface LoginViewController (KeyboardHandling)
- (void) hideWhenTappedAround;
@end

@implementation LoginViewController

@synthesize loginTextField;
@synthesize passwordTextField;
@synthesize authorizeButton;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view layoutIfNeeded];
    self.view.backgroundColor = [UIColor whiteColor];
    
    // register keyboard notifications
    [self hideWhenTappedAround];

    // School name label
    [self createSchoolNameLogin];
    
    // login textfield
    CGFloat loginPositionY = 100 + schoolNameLabel.frame.size.height + 80;
    [self createLoginTextField:loginPositionY];
    
    
    // password textfield
    CGFloat passwordPositionY = loginPositionY + loginTextField.frame.size.height + 30;
    [self createPasswordTextField:passwordPositionY];
    
    
    // authorize button
    CGFloat buttonPositionY = passwordPositionY;
    [self createAuthorizeButton:buttonPositionY];
    
    //create round buttons
    [self createRoundButton:buttonPositionY+100 :@"1"];
    
}

// text field delegate methods

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    if (textField == loginTextField) {
        NSCharacterSet *latinCharacters = [NSCharacterSet characterSetWithCharactersInString:@"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"];
        for (int i = 0; i < string.length; i++) {
            unichar ch = [string characterAtIndex:i];
            if (![latinCharacters characterIsMember:ch]) {
                return  NO;
            }
        }
        return YES;
    }
    return YES;
}

// button actions

-(void) authorizeButtonTapped {
    authorizeButton.layer.backgroundColor = littleBlueBoyColorAlphaButton.CGColor;
    authorizeButton.titleLabel.textColor = littleBlueBoyColorAlphaText;
    
    if (![loginTextField.text  isEqual: @"username"]) {
        loginTextField.layer.borderColor = venetianRedColor.CGColor;
        authorizeButton.tintColor = littleBlueBoyColorAlphaDisabled;
    }
    
    if (![passwordTextField.text isEqual:@"password"]) {
        passwordTextField.layer.borderColor = venetianRedColor.CGColor;
        authorizeButton.tintColor = littleBlueBoyColorAlphaDisabled;
    }
    
    if ([loginTextField.text  isEqual: @"username"] && [passwordTextField.text  isEqual: @"password"]) {
        loginTextField.layer.borderColor = turquoiseGreenColor.CGColor;
        passwordTextField.layer.borderColor = turquoiseGreenColor.CGColor;
        [self.view endEditing:true];
    }
}

// MARK: - School Name Label

- (void) createSchoolNameLogin {
    UIFont *schoolNameFont = [UIFont boldSystemFontOfSize:36];
    schoolNameLabel = [[UILabel alloc] init];
    
    schoolNameLabel.text = @"RSSchool";
    schoolNameLabel.textColor = [UIColor blackColor];
    schoolNameLabel.font = schoolNameFont;
    schoolNameLabel.textAlignment = NSTextAlignmentCenter;
    schoolNameLabel.center = CGPointMake(self.view.frame.size.width / 4, 100);
    [schoolNameLabel sizeToFit];
    
    [self.view addSubview:schoolNameLabel];
}

// MARK: - Login Text Field

- (void) createLoginTextField: (CGFloat)positionY {
    loginTextField = [[UITextField alloc] initWithFrame:CGRectMake(36, positionY, 303, 40)];
    
    loginTextField.placeholder = @"Login";
    loginTextField.backgroundColor = [UIColor whiteColor];
    loginTextField.borderStyle = UITextBorderStyleRoundedRect;
    loginTextField.layer.cornerRadius = 5;
    loginTextField.layer.borderWidth = 1.5;
    loginTextField.autocorrectionType = false;
    loginTextField.keyboardType = UIKeyboardAppearanceDefault;
    loginTextField.returnKeyType = UIReturnKeyDone;
    loginTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    loginTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;  //?
    loginTextField.delegate = self;
    
    [self.view addSubview:loginTextField];
}

// MARK: - Password TextField

- (void) createPasswordTextField: (CGFloat) positionY {
    passwordTextField = [[UITextField alloc] initWithFrame:CGRectMake(36, positionY, 303, 40)];
    passwordTextField.placeholder = @"Password";
    passwordTextField.secureTextEntry = true;
    passwordTextField.backgroundColor = [UIColor whiteColor];
    passwordTextField.borderStyle = UITextBorderStyleRoundedRect;
    passwordTextField.layer.cornerRadius = 5;
    passwordTextField.layer.borderWidth = 1.5;
    passwordTextField.autocorrectionType = false;
    passwordTextField.keyboardType = UIKeyboardAppearanceDefault;
    passwordTextField.returnKeyType = UIReturnKeyDone;
    passwordTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    passwordTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;   //?
    passwordTextField.delegate = self;
    
    [self.view addSubview:passwordTextField];
}

// MARK: - Authorize Button

- (void) createAuthorizeButton: (CGFloat) passwordPositionY {
    CGFloat buttonPositionY = passwordPositionY + passwordTextField.frame.size.height + 60;
    UIFont *buttonTitleFont = [UIFont systemFontOfSize:20 weight:UIFontWeightSemibold];
    
    authorizeButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    authorizeButton.frame = CGRectMake(110, buttonPositionY, 156, 42);
    authorizeButton.backgroundColor = [UIColor whiteColor];
    
    authorizeButton.layer.borderWidth = 2;
    authorizeButton.layer.cornerRadius = 10;
    authorizeButton.layer.borderColor = littleBlueBoyColor.CGColor;
    
    [authorizeButton setTitle:@"Authorize" forState:UIControlStateNormal];
    authorizeButton.titleLabel.font = buttonTitleFont;
    [authorizeButton setTitleColor:littleBlueBoyColor forState:UIControlStateNormal];
    
    UIImage *buttonImageNormal = [UIImage systemImageNamed:@"person"];
    authorizeButton.tintColor = littleBlueBoyColor;
    [authorizeButton setImage:buttonImageNormal forState:UIControlStateNormal];
    
    UIImage *buttonImageHighlighted = [UIImage systemImageNamed:@"person.fill"];
    [authorizeButton setImage:buttonImageHighlighted forState:UIControlStateHighlighted];
    
    CGFloat spacing = 5.0;
    CGSize imageSize = authorizeButton.imageView.frame.size;
    CGSize titleSize = authorizeButton.titleLabel.frame.size;
    
    authorizeButton.titleEdgeInsets = UIEdgeInsetsMake(10, spacing + imageSize.width - 10, 10, 20);
    authorizeButton.imageEdgeInsets = UIEdgeInsetsMake(10, 20, 10, titleSize.width + spacing - 10);
    
    [authorizeButton addTarget:self action:@selector(authorizeButtonTapped) forControlEvents:UIControlEventTouchUpInside];

    [self.view addSubview:authorizeButton];
}

// MARK: - Round Button

- (void) createRoundButton: (CGFloat)positionY :(NSString *)numberText {
    UIButton *roundButtonOne = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [roundButtonOne setTitle:numberText forState:UIControlStateNormal];
    [roundButtonOne addTarget:self action:@selector(roundButtonOneTapped:) forControlEvents:UIControlEventTouchUpInside];
    roundButtonOne.frame = CGRectMake(0, positionY, roundButtonWidth, roundButtonWidth);
    roundButtonOne.clipsToBounds = YES;
    roundButtonOne.layer.cornerRadius = 25;
    roundButtonOne.layer.borderColor = littleBlueBoyColor.CGColor;
}

@end


// MARK: - Keyboard category

@implementation LoginViewController (KeyboardHandling)

- (void) hideWhenTappedAround {
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hide)];
    [self.view addGestureRecognizer:gesture];
}

- (void) hide {
    [self.view endEditing:true];
}

@end
