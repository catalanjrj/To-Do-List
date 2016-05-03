//
//  DetailViewController.m
//  ToDo
//
//  Created by Jorge Catalan on 5/3/16.
//  Copyright © 2016 Jorge Catalan. All rights reserved.
//

#import "DetailViewController.h"


@interface DetailViewController ()

@end

@implementation DetailViewController

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem {
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
            
        // Update the view.
        [self configureView];
    }
}

- (void)configureView {
    // Update the user interface for the detail item.
    if (self.detailItem) {
        self.detailTextField.text = [[self.detailItem valueForKey:@"title"]description];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)cancelButtonTapped:(UIButton*)sender{
    self.detailTextField.text = [self.detailItem valueForKey:@"title"];

}
-(IBAction)saveButtonTapped:(UIButton*)sender{
//    NSString *dateString = self.detailTextField.text;
//    NSDateFormatter *dateFormatter =[[NSDateFormatter alloc]init];
//    [dateFormatter setDateFormat: @"yyyy-mm-dd HH: mm: ss +0000"];
//    NSDate *newDate = [dateFormatter dateFromString:dateString];
  
    [self.detailItem setValue:self.detailTextField.text forKey:@"title"];

     self.saveButton.enabled = NO;
     self.cancelButton.enabled = NO;
    [self.masterVC detailChangedObject];
}
@end