//
//  AKViewControllerCountry.m
//  TestTaskK
//
//  Created by Alexei Karas on 09.07.17.
//  Copyright © 2017 Alexei Karas. All rights reserved.
//

#import "AKViewControllerCountry.h"
#import "AKViewControllerCity.h"

NSString* const AKViewControllerCountrySetDataNotification = @"AKViewControllerCountrySetDataNotification";

@interface AKViewControllerCountry ()

@end

@implementation AKViewControllerCountry

-(id) init {
    
    self = [super init];
    
    if (self) {
        _dataIsSet = NO;
    }
    return self;
}

-(void)loadView {
    [super loadView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(methodNotif:)
                                                 name:AKViewControllerCountrySetDataNotification
                                               object:nil];
    
    self.arrayData = [[AKDataManager sharedManager] executeFetchRequestCountry];
    if ([self.arrayData count] == 0 ) {
        [self.indicatorLoad startAnimating];
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            dispatch_sync(dispatch_get_main_queue(), ^{

                [[AKDataManager sharedManager]request];
                
                self.dataIsSet = YES;
                
            });
        });
    }
    self.navigationBar.topItem.title = @"Country";
}

-(void) setDataIsSet:(BOOL)dataIsSet {
    _dataIsSet = dataIsSet;
    [[NSNotificationCenter defaultCenter] postNotificationName:AKViewControllerCountrySetDataNotification
                                                        object:nil];
}

-(void) dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return  [self.arrayData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString * identifier = @"identifier";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    AKCountryEntity* object = [self.arrayData objectAtIndex:indexPath.row];

    cell.textLabel.text = object.nameCountry;
    
    return cell;
    
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    AKCountryEntity* object = [self.arrayData objectAtIndex:indexPath.row];
    
    AKDataManager* manager = [AKDataManager sharedManager];
    manager.countrySelected = object;
    
    AKViewControllerCity* vc = [self.storyboard instantiateViewControllerWithIdentifier:@"VCCity"];
    [self presentViewController:vc animated:YES completion:nil];
    
}
#pragma mark - method 

-(void) methodNotif:(NSNotification*) notification {
    
    self.arrayData = [[AKDataManager sharedManager] executeFetchRequestCountry];
    [self.indicatorLoad stopAnimating];
    [self.tableViewCountry reloadData];
    
}

@end
