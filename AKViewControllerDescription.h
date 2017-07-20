//
//  AKViewControllerDescription.h
//  TestTaskK
//
//  Created by Alexei Karas on 09.07.17.
//  Copyright © 2017 Alexei Karas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AKViewControllerCountry.h"
#import "Reachability.h"

extern NSString* const AKViewControllerDescriptionSetDataNotification;

@interface AKViewControllerDescription : UIViewController

@property (strong, nonatomic) IBOutlet UILabel* lableNameCity;
@property (strong, nonatomic) IBOutlet UILabel* descriptionCity;
@property (strong, nonatomic) IBOutlet UINavigationBar* navigationBar;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView* indicator;
@property (nonatomic) Reachability* internetReachability;

@property (assign, nonatomic) BOOL dataLoad;

-(IBAction)actionCancel:(UIBarButtonItem*)sender;

@end
