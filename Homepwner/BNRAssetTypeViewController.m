//
//  BNRAssetTypeViewController.m
//  Homepwner
//
//  Created by Leksha Ramdenee on 2016-11-10.
//  Copyright © 2016 Leksha Ramdenee. All rights reserved.
//

#import "BNRAssetTypeViewController.h"
#import "BNRItemStore.h"
#import "BNRItem+CoreDataProperties.h"

@interface BNRAssetTypeViewController ()

@end

@implementation BNRAssetTypeViewController

- (instancetype)init {
    self = [super initWithStyle:UITableViewStylePlain];
    if (self){
        UIBarButtonItem *addAssetTypeButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                                                            target:self
                                                                                            action:@selector(addAssetType:)];
        self.navigationItem.title = NSLocalizedString(@"Asset Type", @"BNRAssetTypeViewController title");
        self.navigationItem.rightBarButtonItem = addAssetTypeButton;
    }
    return self;
}

//- (instancetype)initWithStyle:(UITableViewStyle)style {
//    return [self init];
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // One to Show all the Asset types available
    // The other one to show the assets that have the selected asset type
    return (self.item.assetType ? 2 : 1);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.item.assetType != nil && section == 1){
        NSString *assetTypeSelected = [self.item.assetType valueForKey:@"label"];
        NSInteger itemsCount = [[BNRItemStore sharedStore] countNumbeOfItemsInSection:assetTypeSelected];
        return itemsCount;
    }
    return [[[BNRItemStore sharedStore] allAssetTypes] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"UITableViewCell"];
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    
    // Configure the cell...
    NSArray *allAssets = [[BNRItemStore sharedStore] allAssetTypes];
    NSManagedObject *assetType = allAssets[indexPath.row];
    
    // Use key-value coding to get the asset type='s label
    NSString *assetLabel = [assetType valueForKey:@"label"];
    
    if (indexPath.section == 0) {
        cell.textLabel.text = assetLabel;
        // Checkmark the one that is currently selected
        if (assetType == self.item.assetType) {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        } else {
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
    } else {
        BNRItem *item = [[BNRItemStore sharedStore] itemsWithAssetTypeSelected:indexPath.row];
        cell.textLabel.text = item.itemName;
        cell.detailTextLabel.text = item.serialNumber;
        cell.imageView.image = item.thumbnail;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    cell.accessoryType = UITableViewCellAccessoryCheckmark;
    
    NSArray *allAssets = [[BNRItemStore sharedStore] allAssetTypes];
    NSManagedObject *assetType = allAssets[indexPath.row];
    self.item.assetType = assetType;
    
    [self.navigationController popViewControllerAnimated:YES];
//    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark addAssetTypeButton

- (void)addAssetType:(id)sender {
    UIAlertController *addAssetTypeAlert = [UIAlertController alertControllerWithTitle:@"Add new asset type"
                                                                               message:@"Enter new asset type name"
                                                                        preferredStyle:UIAlertControllerStyleAlert];
    
    [addAssetTypeAlert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"Enter asset type name";
        textField.keyboardType = UIKeyboardTypeDefault;
    }];
    
    [addAssetTypeAlert addAction:[UIAlertAction actionWithTitle:@"Done" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        NSString *assetTypeName = addAssetTypeAlert.textFields[0].text;
        [[BNRItemStore sharedStore] addAssetType:assetTypeName];
        [self.tableView reloadData];
    }]];
    
    [self presentViewController:addAssetTypeAlert animated:YES completion:nil];
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0){
        return @"Asset Types";
    } else {
        return [NSString stringWithFormat:@"Items in %@", [self.item.assetType valueForKey:@"label"]];
    }
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


@end
