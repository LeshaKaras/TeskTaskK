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

NSString* const AKViewControllerDescriptionSetDataNotification = @"AKViewControllerDescriptionSetDataNotification";

@interface AKViewControllerDescription ()

@end

@implementation AKViewControllerDescription

- (id) init {
    
    self = [super init];
    
    if (self) {
        _dataLoad = NO;
    }
    return self;
}


-(void) loadView {
    [super loadView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(methodNotifDisc:)
                                                 name:AKViewControllerDescriptionSetDataNotification
                                               object:nil];
    
    [self setWaitingData];

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        dispatch_sync(dispatch_get_main_queue(), ^{
    
    [self loadDataDesc];
            
    });
});
    
}

-(void) methodNotifDisc:(NSNotification*) notification {
    
    [self.indicator stopAnimating];
    [self dataSet];
}

-(void) setDataLoad:(BOOL)dataLoad {
    _dataLoad = dataLoad;
    [[NSNotificationCenter defaultCenter] postNotificationName:AKViewControllerDescriptionSetDataNotification object:nil];
    
}

-(IBAction)actionCancel:(UIBarButtonItem*)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void) loadDataDesc {
    
    AKDataManager* manager = [AKDataManager sharedManager];
    [[AKDataManager sharedManager] loadAPIDataForCity:manager.citySelected];
    
}

- (void) dataSet {
    
    AKDataManager* manager = [AKDataManager sharedManager];
    self.descriptionCity.text = manager.descCity;
    
}

-(void) setWaitingData {
    
    self.navigationBar.topItem.title = @"Description";
    
    AKCityEntity* cityObject = [[AKDataManager sharedManager] citySelected];
    self.lableNameCity.text = cityObject.nameCity;
    [self.indicator startAnimating];
    
}

-(void) dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
