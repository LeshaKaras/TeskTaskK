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
    self.navigationBar.topItem.title = @"Country";
   
}

-(void) viewDidLoad {
    [super viewDidLoad];
    [self rechability];
    
}

-(void) setDataIsSet:(BOOL)dataIsSet {
    _dataIsSet = dataIsSet;
    [[NSNotificationCenter defaultCenter] postNotificationName:AKViewControllerCountrySetDataNotification
                                                        object:nil];
}

-(void) dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:AKViewControllerCountrySetDataNotification
                                                  object:nil];
    
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
#pragma mark - methodNSNotification

-(void) methodNotif:(NSNotification*) notification {
    
    self.arrayData = [[AKDataManager sharedManager] executeFetchRequestCountry];
    [self.indicatorLoad stopAnimating];
    [self.tableViewCountry reloadData];
    
}

#pragma mark - Reachability

- (void) rechability {
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(reachabilityChanged:)
                                                 name:kReachabilityChangedNotification
                                               object:nil];
    
    self.internetReachability = [Reachability reachabilityForInternetConnection];
    [self.internetReachability startNotifier];
    [self updateInterfaceWithReachability:self.internetReachability];
}

- (void) reachabilityChanged:(NSNotification *)note{
    Reachability* curReach = [note object];
    NSParameterAssert([curReach isKindOfClass:[Reachability class]]);
    [self updateInterfaceWithReachability:curReach];
}

- (void) updateInterfaceWithReachability:(Reachability *)reachability {
    
    if (reachability == self.internetReachability){
        
        [self internetReachability:reachability];
        
    }
}

- (void) internetReachability:(Reachability *)reachability
{
    NetworkStatus netStatus = [reachability currentReachabilityStatus];
    
    switch (netStatus) {
        case NotReachable:{
            
            if ([self.arrayData count] == 0) {
                
                dispatch_async(dispatch_get_main_queue(), ^ {
                
                [self showAlertNoInternetConnection];
                    
                });
                
            }
            
            NSLog(@"NOT WORK");
            break;
        }
            
        case ReachableViaWWAN:{
            
            [self dataRequestForProcessing];
            
            NSLog(@"WWAN WORK");
            break;
        }
        case ReachableViaWiFi:{
            
            [self dataRequestForProcessing];
            
            NSLog(@"WIFI WORK");
            break;
        }
    }
}

-(void) dataRequestForProcessing {
    
    if ([self.arrayData count] == 0 ) {
        [self.indicatorLoad startAnimating];
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            dispatch_sync(dispatch_get_main_queue(), ^{
                
                [[AKDataManager sharedManager]request];
                
                self.dataIsSet = YES;
                
            });
        });
    }
    
}

#pragma mark - AlertView

-(void) showAlertNoInternetConnection {
    
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Error"
                                                                   message:@"No internet connection"
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction * cancel = [UIAlertAction actionWithTitle:@"Cancel"
                                                      style:UIAlertActionStyleCancel
                                                    handler:^(UIAlertAction *  action) {
        
                                        [self dismissViewControllerAnimated:self completion:nil];
            
                                                    }];
    
    [alert addAction:cancel];
    [self presentViewController:alert animated:YES completion:nil];
    
}

@end
