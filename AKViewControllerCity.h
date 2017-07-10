//
//  AKViewControllerCity.h
//  TestTaskK
//
//  Created by Alexei Karas on 09.07.17.
//  Copyright © 2017 Alexei Karas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AKCountryEntity+CoreDataClass.h"

@interface AKViewControllerCity : UIViewController <UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView* tableCity;
@property (strong, nonatomic) IBOutlet UINavigationBar* navigationBar;

-(IBAction)actionCancel:(UIBarButtonItem*)sender;

@property (strong, nonatomic) NSArray* arrayData;


@end
