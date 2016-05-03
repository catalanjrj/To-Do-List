//
//  MasterViewController.h
//  ToDo
//
//  Created by Jorge Catalan on 5/3/16.
//  Copyright © 2016 Jorge Catalan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@class DetailViewController;

@interface MasterViewController : UITableViewController <NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) DetailViewController *detailViewController;

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

-(void)detailChangedObject;

@end

