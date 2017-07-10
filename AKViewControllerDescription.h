//
//  AKViewControllerDescription.h
//  TestTaskK
//
//  Created by Alexei Karas on 09.07.17.
//  Copyright © 2017 Alexei Karas. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AKViewControllerDescription : UIViewController

@property (strong, nonatomic) IBOutlet UILabel* lableNameCity;
@property (strong, nonatomic) IBOutlet UILabel* descriptionCity;
@property (strong, nonatomic) IBOutlet UINavigationBar* navigationBar;

-(IBAction)actionCancel:(UIBarButtonItem*)sender;

@end
