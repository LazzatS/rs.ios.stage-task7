//
//  LoginViewController.h
//  task7
//
//  Created by Lazzat Seiilova on 03.07.2021.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LoginViewController : UIViewController {
    UILabel *schoolNameLabel;
    UITextField *loginTextField;
    UITextField *passwordTextField;
    UIButton *authorizeButton;
    UIAlertController *alert;
}

@end

NS_ASSUME_NONNULL_END
