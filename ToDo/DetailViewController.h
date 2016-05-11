//
//  DetailViewController.h
//  ToDo
//
//  Created by Jorge Catalan on 5/3/16.
//  Copyright © 2016 Jorge Catalan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MasterViewController.h"
#import "ToDo.h"
@interface DetailViewController : UIViewController<UITextViewDelegate,NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) ToDo *detailItem;

@property(weak,nonatomic) MasterViewController * masterVC;
@property (weak, nonatomic) IBOutlet UITextField *detailTextField;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
@property (weak, nonatomic) IBOutlet UIButton *saveButton;
@property (weak,nonatomic)IBOutlet UITextView *listTextView;

@property (weak, nonatomic) IBOutlet UITextField *dueDate;


@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@end

