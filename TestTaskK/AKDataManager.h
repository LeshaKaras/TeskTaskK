//
//  AKDataManager.h
//  TestTaskK
//
//  Created by Alexei Karas on 09.07.17.
//  Copyright © 2017 Alexei Karas. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "AKCityEntity+CoreDataClass.h"
#import "AKCountryEntity+CoreDataClass.h"
#import "AFNetworking.h"
#import "AKViewControllerDescription.h"


@interface AKDataManager : NSObject

@property (readonly, strong) NSPersistentContainer *persistentContainer;
@property (strong, nonatomic) AKCountryEntity* countrySelected;
@property (strong, nonatomic) AKCityEntity* citySelected;
@property (strong, nonatomic) NSString* descCity;

@property (strong, nonatomic) AFHTTPResponseSerializer* responseSerializer;
@property (strong, nonatomic) AFHTTPRequestSerializer* requestSerializer;

- (void)saveContext;

+(AKDataManager*) sharedManager;
- (void) request;
- (void) loadAPIDataForCity: (AKCityEntity *) city;

- (NSArray*) executeFetchRequestCountry;
-(NSArray *) makeArrayFromSet: (NSSet *) set;

@end
