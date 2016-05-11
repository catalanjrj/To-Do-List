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
    -(IBAction)ImAPeoplePerson:(id)sender{
        
        NSManagedObjectContext *context = [self.fetchedResultsController managedObjectContext];
        NSEntityDescription *entity = [[self.fetchedResultsController fetchRequest] entity];
        NSManagedObject *newManagedObject = [NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:context];
        [newManagedObject setValue:@"John" forKey:@"firstName"];
        [newManagedObject setValue:@"Doe" forKey:@"lastName"];
        [newManagedObject setValue:@22 forKey:@"age"];
        
        
         NSManagedObject *spouseManagedObject = [NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:context];
            
            [spouseManagedObject setValue:@"Jane" forKey:@"firstName"];
            [spouseManagedObject setValue:@"Doe" forKey:@"lastName"];
        [spouseManagedObject setValue:@20 forKey:@"age"];
        
        [newManagedObject setValue:spouseManagedObject forKey:@"spouse"];
        
        NSError *error = nil;
        if (![self.fetchedResultsController performFetch:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }

    
    
    }

- (void)configureView {
    // Update the user interface for the detail item.
    if (self.detailItem) {
        
        self.dueDate.text = self.detailItem.timeStamp;
        self.detailTextField.text = [[self.detailItem valueForKey:@"title"]description];
            self.listTextView.text = [self.detailItem valueForKey:@"list"];
                                      }}
        
    


- (void)viewDidLoad {
    self.title = @"List";
    [self.detailTextField resignFirstResponder];
    self.listTextView.delegate = self;
    
    [super viewDidLoad];
    
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
//    [dateFormatter setDateFormat: @"mm-dd-yyyy HH: mm"];
//    NSDate *newDate = [dateFormatter dateFromString:dateString];
    
    [self.detailItem setValue:self.listTextView.text forKey:@"list"];
    [self.detailItem setValue:self.detailTextField.text forKey:@"title"];
   
    NSError *error;
    
    
    if(![self.detailItem.managedObjectContext save:&error]){
            NSLog(@"Unresolved error %@ %@",error, [error userInfo]);
        
        }

    



     self.saveButton.enabled = NO;
     self.cancelButton.enabled = NO;
    
    [self.detailTextField resignFirstResponder];
    [self.listTextView resignFirstResponder];
    
    [self.masterVC detailChangedObject];
}
#pragma mark - Fetched results controller

- (NSFetchedResultsController *)fetchedResultsController
{
    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    // Edit the entity name as appropriate.
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"person" inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    
    [fetchRequest setFetchBatchSize:20];
    
    // Edit the sort key as appropriate.
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"lastName" ascending:YES];
    NSSortDescriptor *secondSort = [[NSSortDescriptor alloc]initWithKey:@"fristName" ascending:YES];
    
    [fetchRequest setSortDescriptors:@[sortDescriptor,secondSort]];
    
    // Edit the section name key path and cache name if appropriate.
    // nil for section name key path means "no sections".
    NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
    aFetchedResultsController.delegate = self;
    self.fetchedResultsController = aFetchedResultsController;
    [self.managedObjectContext reset];
    
    NSError *error = nil;
    if (![self.fetchedResultsController performFetch:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _fetchedResultsController;
}

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller
{
   // [self.tableView beginUpdates];
}

- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo
           atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type
{
    switch(type) {
        case NSFetchedResultsChangeInsert:
//            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            NSLog(@"Got and insert here!!");
            break;
            
        case NSFetchedResultsChangeDelete:
//            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            
            NSLog(@"Got a delete here!!");
            break;
            
        default:
            return;
    }
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath
{
    UITableView *tableView = nil;
    
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeUpdate:
//            [self configureCell:[tableView cellForRowAtIndexPath:indexPath] withObject:anObject];
            break;
            
        case NSFetchedResultsChangeMove:
            [tableView moveRowAtIndexPath:indexPath toIndexPath:newIndexPath];
            break;
    }
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
//    [self.tableView endUpdates];
}















@end
