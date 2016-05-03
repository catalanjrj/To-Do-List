//
//  DetailViewController.h
//  ToDo
//
//  Created by Jorge Catalan on 5/3/16.
//  Copyright © 2016 Jorge Catalan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MasterViewController.h"
@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;

@property(weak,nonatomic) MasterViewController * masterVC;
@property (weak, nonatomic) IBOutlet UITextField *detailTextField;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
@property (weak, nonatomic) IBOutlet UIButton *saveButton;

@end

