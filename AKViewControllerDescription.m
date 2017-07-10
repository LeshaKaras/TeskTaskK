//
//  AKViewControllerDescription.m
//  TestTaskK
//
//  Created by Alexei Karas on 09.07.17.
//  Copyright © 2017 Alexei Karas. All rights reserved.
//

#import "AKViewControllerDescription.h"
#import "AKViewControllerCity.h"
#import "AKDataManager.h"

@interface AKViewControllerDescription ()

@end

@implementation AKViewControllerDescription



-(void) loadView {
    [super loadView];
    
    [self setWaitingData];
    [self loadDataDesc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self dataSet];
}

-(IBAction)actionCancel:(UIBarButtonItem*)sender {
    
    AKViewControllerCity* vc = [self.storyboard instantiateViewControllerWithIdentifier:@"VCCity"];
    
    [self presentViewController:vc animated:YES completion:nil];
}

- (void) loadDataDesc {
    
    AKDataManager* manager = [AKDataManager sharedManager];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        dispatch_sync(dispatch_get_main_queue(), ^{
            
            [[AKDataManager sharedManager] loadAPIDataForCity:manager.citySelected];
        
        });
    });
}

- (void) dataSet {
    
    AKDataManager* manager = [AKDataManager sharedManager];
    
    self.descriptionCity.text = manager.descCity;
    
}

-(void) setWaitingData {
    
    self.navigationBar.topItem.title = @"Description";
    
    AKCityEntity* cityObject = [[AKDataManager sharedManager] citySelected];
    self.lableNameCity.text = cityObject.nameCity;
    self.descriptionCity.text = @"...";
    
}

@end
