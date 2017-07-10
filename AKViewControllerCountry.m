//
//  AKViewControllerCountry.m
//  TestTaskK
//
//  Created by Alexei Karas on 09.07.17.
//  Copyright © 2017 Alexei Karas. All rights reserved.
//

#import "AKViewControllerCountry.h"
#import "AKViewControllerCity.h"
@interface AKViewControllerCountry ()

@end

@implementation AKViewControllerCountry

-(void)loadView {
    [super loadView];
    
    self.arrayData = [[AKDataManager sharedManager] executeFetchRequestCountry];
    if ([self.arrayData count] == 0 ) {
        [[AKDataManager sharedManager]request];
        self.arrayData = [[AKDataManager sharedManager] executeFetchRequestCountry];
    }
    self.navigationBar.topItem.title = @"Country";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
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

@end
