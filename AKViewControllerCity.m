//
//  AKViewControllerCity.m
//  TestTaskK
//
//  Created by Alexei Karas on 09.07.17.
//  Copyright © 2017 Alexei Karas. All rights reserved.
//

#import "AKViewControllerCity.h"
#import "AKViewControllerCountry.h"
#import "AKViewControllerDescription.h"
@interface AKViewControllerCity ()


@end

@implementation AKViewControllerCity

-(void) loadView {
    [super loadView];
    
    
    AKCountryEntity* country = [[AKDataManager sharedManager] countrySelected];
    self.navigationBar.topItem.title = [NSString stringWithFormat:@"%@ : Сities",country.nameCountry];
    self.arrayData = [[AKDataManager sharedManager] makeArrayFromSet:country.listCity];
    
}

- (void)viewDidLoad {
    
    [self.indicatorLoad startAnimating];
    [super viewDidLoad];
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    if ([self.arrayData count] == 0) {
        [self alert];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return  [self.arrayData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self.indicatorLoad stopAnimating];
    
    static NSString * identifier = @"identifier";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    AKCityEntity* object = [self.arrayData objectAtIndex:indexPath.row];
    
    cell.textLabel.text = object.nameCity;
    
    return cell;
    
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    AKCityEntity* object = [self.arrayData objectAtIndex:indexPath.row];
    
    AKDataManager* manager = [AKDataManager sharedManager];
    manager.citySelected = object;
    
    AKViewControllerDescription* vc = [self.storyboard instantiateViewControllerWithIdentifier:@"VCDescription"];
    [self presentViewController:vc animated:YES completion:nil];
    
}


#pragma mark - Action 

-(IBAction)actionCancel:(UIBarButtonItem*)sende {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void) alert {
    
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Error"
                                                                   message:@":("
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* cancel = [UIAlertAction actionWithTitle:@"Cancel"
                                                     style:UIAlertActionStyleDestructive
                                                   handler:^(UIAlertAction * _Nonnull action) {
                                                       [alert dismissViewControllerAnimated:YES
                                                                                 completion:nil];
                                                       
      AKViewControllerCountry* vc = [self.storyboard instantiateViewControllerWithIdentifier:@"VCCountry"];
    [self presentViewController:vc animated:YES completion:nil];
                                                   
    }];
                                                       
    
    [alert addAction:cancel];
    
    [self presentViewController:alert animated:YES completion:nil];
}

@end
