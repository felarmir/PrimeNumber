//
//  ViewController.h
//  PrimeNumber
//
//  Created by Denis Andreev on 05/10/2017.
//  Copyright © 2017 Denis Andreev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (nonatomic, weak) IBOutlet UIView *blackBox;
@property (nonatomic, weak) IBOutlet UILabel *numberLabel;
@property (nonatomic, weak) IBOutlet UIButton *hideShowButton;

- (IBAction)hideShowAction:(UIButton*)sender;

@end

