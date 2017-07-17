//
//  AKViewControllerCountry.h
//  TestTaskK
//
//  Created by Alexei Karas on 09.07.17.
//  Copyright © 2017 Alexei Karas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AKDataManager.h"

extern NSString* const AKViewControllerCountrySetDataNotification;

@interface AKViewControllerCountry : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (strong,nonatomic) IBOutlet UITableView* tableViewCountry;
@property (strong,nonatomic) IBOutlet UINavigationBar* navigationBar;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView* indicatorLoad;

@property (assign, nonatomic) BOOL dataIsSet;
@property (strong, nonatomic) NSArray* arrayData;

@end
