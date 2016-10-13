//
//  BNRItemsViewController.m
//  Homepwner
//
//  Created by Leksha Ramdenee on 2016-10-11.
//  Copyright © 2016 Leksha Ramdenee. All rights reserved.
//

#import "BNRItemsViewController.h"
#import "BNRItemStore.h"
#import "BNRItem.h"
#import "BNRDetailViewController.h"

@interface BNRItemsViewController ()

@end

@implementation BNRItemsViewController

- (instancetype)init {
    // Call the superclass' designated initializer
    self = [super initWithStyle:UITableViewStylePlain];
    if (self) {
        [[BNRItemStore sharedStore] createItem];
        UINavigationItem *navItem = self.navigationItem;
        navItem.title = @"Homepwner";
        
        // Create a new bar button item that will send
        // addNewItem: to BNRItemsViewControlelr
        UIBarButtonItem *bbi = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                                             target:self
                                                                             action:@selector(addNewItem:)];
        // Set this bar button item as the right item in the navgation item
        navItem.rightBarButtonItem = bbi;
        navItem.leftBarButtonItem = self.editButtonItem;
    }
    return self;
}

- (instancetype)initWithStyle:(UITableViewStyle)style {
    return [self init];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerClass:[UITableViewCell class]
           forCellReuseIdentifier:@"UITableViewCell"];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[[BNRItemStore sharedStore] allItems] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // Get a new or recycled cell
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"
                                                            forIndexPath:indexPath];
    
    // Set the text on the cell with the description of the item
    // that is at the nth index of items, where n=row this cell will
    // appear in on the tableview
    NSArray *items = [[BNRItemStore sharedStore] allItems];
    BNRItem *item = items[indexPath.row];
    NSLog(@"Row index: %ld", (long)indexPath.row);
    if (indexPath.row == [[[BNRItemStore sharedStore] allItems] count]-1) {
        NSLog(@"Test: %lu", [[[BNRItemStore sharedStore] allItems] count]-1);
        cell.textLabel.text = @"No more items";
    } else {
        cell.textLabel.text = [item description];
    }
    
    return cell;
}

# pragma mark - Table Header
- (IBAction)addNewItem:(id)sender {
    // Create a new BNRItem and add it to the store
//    BNRItem *newItem = [[BNRItemStore sharedStore] createItem];
    
    // Figure out where that last item is in the array
//    NSInteger lastRow = [[[BNRItemStore sharedStore] allItems] indexOfObject:newItem];
    [[BNRItemStore sharedStore] createItem];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    
    // Insert this new row into the table.
    [self.tableView insertRowsAtIndexPaths:@[indexPath]
                          withRowAnimation:UITableViewRowAnimationTop];
    
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

- (NSIndexPath *)tableView:(UITableView *)tableView targetIndexPathForMoveFromRowAtIndexPath:(nonnull NSIndexPath *)sourceIndexPath toProposedIndexPath:(nonnull NSIndexPath *)proposedDestinationIndexPath {
    NSArray *items = [[BNRItemStore sharedStore] allItems];
    // Prevent rearranging to the last row, set it to the row before instead
    if (proposedDestinationIndexPath.row == [items indexOfObject:[items lastObject]]) {
        return [NSIndexPath indexPathForRow:proposedDestinationIndexPath.row-1 inSection:0];
    }
    return proposedDestinationIndexPath;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    // If the table view is asking to commit a delete command
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        NSArray *items = [[BNRItemStore sharedStore] allItems];
        BNRItem *item = items[indexPath.row];
        [[BNRItemStore sharedStore] removeItem:item];
        
        // Also remove the row from the table view with an animation
        [tableView deleteRowsAtIndexPaths:@[indexPath]
                         withRowAnimation:UITableViewRowAnimationFade];
    } /*else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   */
}

// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
    [[BNRItemStore sharedStore] moveItemAtIndex:fromIndexPath.row toIndex:toIndexPath.row];
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"Remove";
}

// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    NSArray *items = [[BNRItemStore sharedStore] allItems];
    if (indexPath.row == [items indexOfObject:[items lastObject]]) {
        return NO;
    }
    return YES;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *items = [[BNRItemStore sharedStore] allItems];
    // Prevent deletion of last row
    if (indexPath.row == [items indexOfObject:[items lastObject]]) {
        return UITableViewCellEditingStyleNone;
    }
    // The remaining rows can be deleted
    return UITableViewCellEditingStyleDelete;
}

#pragma mark - Navigation
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *items = [[BNRItemStore sharedStore] allItems];
    BNRItem *selectedItem = items[indexPath.row];
    
    // Give the detail view controller a pointer ot the item object in row
    BNRDetailViewController *detailViewController = [[BNRDetailViewController alloc] init];
    detailViewController.item = selectedItem;
    
    // Push it onto the top of the navigation controller's stack
    [self.navigationController pushViewController:detailViewController animated:YES];

}

/*
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
