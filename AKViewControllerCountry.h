//
//  AKViewControllerCountry.h
//  TestTaskK
//
//  Created by Alexei Karas on 09.07.17.
//  Copyright © 2017 Alexei Karas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AKDataManager.h"

@interface AKViewControllerCountry : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (strong,nonatomic) IBOutlet UITableView* tableViewCountry;
@property (strong,nonatomic) IBOutlet UINavigationBar* navigationBar;

@property (strong, nonatomic) NSArray* arrayData;

@end
