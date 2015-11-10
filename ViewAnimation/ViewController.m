//
//  ViewController.m
//  ViewAnimation
//
//  Created by Tran Tuan Hai on 10/1/15.
//  Copyright (c) 2015 Tran Tuan Hai. All rights reserved.
//

#import "ViewController.h"

void delay(double second, dispatch_block_t completion){
  dispatch_time_t poptime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(NSEC_PER_SEC*second));
  dispatch_after(poptime, dispatch_get_main_queue(), ^{
    completion();
  });
}

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *heading;
@property (weak, nonatomic) IBOutlet UITextField *username;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;

@property (weak, nonatomic) IBOutlet UIImageView *cloud1;
@property (weak, nonatomic) IBOutlet UIImageView *cloud2;
@property (weak, nonatomic) IBOutlet UIImageView *cloud3;
@property (weak, nonatomic) IBOutlet UIImageView *cloud4;

@end

@implementation ViewController {
  UIActivityIndicatorView *_spinner;
  UIImageView *_status;
  UILabel *_label;
  NSArray *_message;
  CGPoint _statusPosition;
}

#pragma mark - View Life Cycle

- (void)viewDidLoad {
  [super viewDidLoad];
  
  //Set up UI
  self.loginButton.layer.cornerRadius = 8.0f;
  self.loginButton.layer.masksToBounds = YES;
  
  _spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
  _spinner.frame = CGRectMake(-20.0f, 16.0f, 20.0f, 20.0f);
  [_spinner startAnimating];
  _spinner.alpha = 0.0f;
  [self.loginButton addSubview:_spinner];
  
  _status = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"banner"]];
  _status.hidden = YES;
  _status.center = self.loginButton.center;
  [self.view addSubview:_status];
  
  _statusPosition = _status.center;
  
  _label = [UILabel new];
  _label.frame = CGRectMake(0.0f, 0.0f, _status.frame.size.width, _status.frame.size.height);
  _label.font = [UIFont fontWithName:@"HelveticaNeue" size:18];
  _label.textColor = [UIColor colorWithRed:0.89f green:0.38f blue:0.0f alpha:1.0f];
  _label.textAlignment = NSTextAlignmentCenter;
  [_status addSubview:_label];
  
  _message = @[@"Connecting ...",@"Authorizing ...",@"Failed ..."];
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  
  //Move form element out of screen
  [self moveOutFormElement:self.heading];
  [self moveOutFormElement:self.username];
  [self moveOutFormElement:self.password];
  
  //Hide clouds
  [self fadeCloud:self.cloud1];
  [self fadeCloud:self.cloud2];
  [self fadeCloud:self.cloud3];
  [self fadeCloud:self.cloud4];
  
  [self moveAndHideLoginButton];
}

- (void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];
  
  //Move form element back with animation
  [self moveBackFormElement:self.heading duration:0.5f delay:0.0f option:0 useSpringAnimation:NO];
  [self moveBackFormElement:self.username duration:0.5f delay:0.3f option:0 useSpringAnimation:YES];
  [self moveBackFormElement:self.password duration:0.5f delay:0.4f option:0 useSpringAnimation:YES];
  
  //Show cloud
  [self showCloud:self.cloud1 duration:0.5f delay:0.5f options:0];
  [self showCloud:self.cloud2 duration:0.5f delay:0.7f options:0];
  [self showCloud:self.cloud3 duration:0.5f delay:0.9f options:0];
  [self showCloud:self.cloud4 duration:0.5f delay:1.1f options:0];
  
  [self moveAndShowLoginButton];
  
  [self animateCloud:self.cloud1];
  [self animateCloud:self.cloud2];
  [self animateCloud:self.cloud3];
  [self animateCloud:self.cloud4];
}

#pragma mark - IBAction

- (IBAction)login:(id)loginButton {
  [UIView animateWithDuration:1.5f
                        delay:0.0f
       usingSpringWithDamping:0.2f
        initialSpringVelocity:0.0f
                      options:0
                   animations:^{
                     self.loginButton.bounds = ({
                       CGRect bounds = self.loginButton.bounds;
                       bounds.size.width += 80;
                       bounds;
                     });
                   } completion:^(BOOL finished){
                     [self showMessage:0];
                   }];
  
  [UIView animateWithDuration:0.33f
                        delay:0.0f
       usingSpringWithDamping:0.7f
        initialSpringVelocity:0.0f
                      options:0
                   animations:^{
                     self.loginButton.center = ({
                       CGPoint center = self.loginButton.center;
                       center.y += 60.0f;
                       center;
                     });
                     self.loginButton.backgroundColor = [UIColor colorWithRed:0.85f
                                                                        green:0.83f
                                                                         blue:0.45f
                                                                        alpha:1.0f];
                     _spinner.center = CGPointMake(40.0f, self.loginButton.frame.size.height/2);
                     _spinner.alpha = 1.0f;
                   } completion:nil];
}

#pragma mark - Animation

- (void)moveOutFormElement:(UIView*)element{
  element.center = ({
    CGPoint center = element.center;
    center.x -= self.view.bounds.size.width;
    center;
  });
}

- (void)moveBackFormElement:(UIView*)element
                   duration:(NSTimeInterval)duration
                      delay:(NSTimeInterval)delay
                     option:(UIViewAnimationOptions)options
         useSpringAnimation:(BOOL)animation{
  if (animation) {
    [UIView animateWithDuration:duration
                          delay:delay
         usingSpringWithDamping:0.6f
          initialSpringVelocity:0.0f
                        options:options
                     animations:^{
                       element.center = ({
                         CGPoint center = element.center;
                         center.x += self.view.bounds.size.width;
                         center;
                       });
    } completion:nil];
  }else{
    [UIView animateWithDuration:duration
                          delay:delay
                        options:options
                     animations:^{
                       element.center = ({
                         CGPoint center = element.center;
                         center.x += self.view.bounds.size.width;
                         center;
                       });
                     } completion:nil];
  }
  
}

- (void)fadeCloud:(UIView*)cloud{
  cloud.alpha = 0.0f;
}

- (void)showCloud:(UIView*)cloud
         duration:(NSTimeInterval)duration
            delay:(NSTimeInterval)delay
          options:(UIViewAnimationOptions)options {
  [UIView animateWithDuration:duration
                        delay:delay
                      options:options
                   animations:^{
    cloud.alpha = 1.0f;
  } completion:nil];
}

- (void)animateCloud:(UIView*)cloud{
  CGFloat cloudSpeed = 60.0f / self.view.bounds.size.width;
  CGFloat duration = (self.view.bounds.size.width - cloud.frame.origin.x) * cloudSpeed;
  [UIView animateWithDuration:duration delay:0.0f options:UIViewAnimationOptionCurveLinear
                   animations:^{
                     cloud.frame = ({
                       CGRect frame = cloud.frame;
                       frame.origin.x = self.view.bounds.size.width;
                       frame;
                     });
                   } completion:^(BOOL finished) {
                     cloud.frame = ({
                       CGRect frame = cloud.frame;
                       frame.origin.x = -self.view.bounds.size.width;
                       frame;
                     });
                     [self animateCloud:cloud];
                   }];
}

- (void)moveAndHideLoginButton {
  self.loginButton.center = ({
    CGPoint center = self.loginButton.center;
    center.y += 30;
    center;
  });
  self.loginButton.alpha = 0.0f;
}

- (void)moveAndShowLoginButton {
  //Less damping -> bouncier animation
  //More velocity -> bouncier animation
  [UIView animateWithDuration:0.5f
                        delay:0.5f
       usingSpringWithDamping:0.5f
        initialSpringVelocity:0.0f
                      options:0
                   animations:^{
    self.loginButton.alpha = 1.0f;
    self.loginButton.center = ({
      CGPoint center = self.loginButton.center;
      center.y -= 30;
      center;
    });
  } completion:nil];
}

- (void)showMessage:(NSUInteger)index{
  _label.text = _message[index];
  [UIView transitionWithView:_status
                    duration:0.33f
                     options:UIViewAnimationOptionCurveEaseOut|UIViewAnimationOptionTransitionCurlDown
                  animations:^{
                    _status.hidden = NO;
                  } completion:^(BOOL finished){
                    //Delay 2 second before change message
                    delay(2.0f, ^{
                      if (index < (_message.count - 1)) {
                        [self removeMessage:index];
                      }else{
                        [self resetForm];
                      }
                    });
                  }];
}

- (void)removeMessage:(NSUInteger)index{
  [UIView animateWithDuration:0.33f
                        delay:0.0f
                      options:0
                   animations:^{
                     _status.center = ({
                       CGPoint center = _status.center;
                       center.x += self.view.bounds.size.width;
                       center;
                     });
                   } completion:^(BOOL finished) {
                     _status.hidden = YES;
                     _status.center = _statusPosition;
                     [self showMessage:(index+1)];
                   }];
}

- (void)resetForm{
  //Hide status
  [UIView transitionWithView:_status
                    duration:0.2f
                     options:UIViewAnimationOptionTransitionCurlUp
                  animations:^{
                    _status.hidden = YES;
                  } completion:nil];
  
  [UIView animateWithDuration:0.5f
                        delay:0.0f
                      options:0
                   animations:^{
                     _spinner.center = CGPointMake(-20.0f, 16.0f);
                     _spinner.alpha = 0.0f;
                     self.loginButton.backgroundColor = [UIColor colorWithRed:160.0f/255
                                                                        green:214.0f/255
                                                                         blue:90.0f/255
                                                                        alpha:1.0f];
                     self.loginButton.bounds = ({
                       CGRect bounds = self.loginButton.bounds;
                       bounds.size.width -= 80;
                       bounds;
                     });
                     self.loginButton.center = ({
                       CGPoint center = self.loginButton.center;
                       center.y -= 60.0f;
                       center;
                     });
                     
                   }
                   completion:nil];
}
@end
