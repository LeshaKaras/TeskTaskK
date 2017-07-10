//
//  AKDataManager.m
//  TestTaskK
//
//  Created by Alexei Karas on 09.07.17.
//  Copyright © 2017 Alexei Karas. All rights reserved.
//

#import "AKDataManager.h"

@implementation AKDataManager

+(AKDataManager*) sharedManager {
    
    static AKDataManager* manager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[AKDataManager alloc] init];
    });
    
    return manager;
}


#pragma mark - Core Data stack

@synthesize persistentContainer = _persistentContainer;

- (NSPersistentContainer *)persistentContainer {
    // The persistent container for the application. This implementation creates and returns a container, having loaded the store for the application to it.
    @synchronized (self) {
        if (_persistentContainer == nil) {
            _persistentContainer = [[NSPersistentContainer alloc] initWithName:@"TestTaskK"];
            [_persistentContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription *storeDescription, NSError *error) {
                if (error != nil) {
                    NSLog(@"Unresolved error %@, %@", error, error.userInfo);
                    abort();
                }
            }];
        }
    }
    
    return _persistentContainer;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *context = self.persistentContainer.viewContext;
    NSError *error = nil;
    if ([context hasChanges] && ![context save:&error]) {
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
}

- (void) request {
    
    NSString * urlString = @"https://raw.githubusercontent.com/David-Haim/CountriesToCitiesJSON/master/countriesToCities.json";
    NSURL * url = [NSURL URLWithString:urlString];
    NSData * data = [NSData dataWithContentsOfURL:url];
    
    NSString * response = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    
    NSRange range1 = NSMakeRange(0, 1);
    NSRange range2 = NSMakeRange(response.length-3, 2);
    
    response = [response stringByReplacingCharactersInRange:range1 withString:@""];
    response = [response stringByReplacingCharactersInRange:range2 withString:@""];
    
    NSArray * countriesAndCitiesUnseparated = [response componentsSeparatedByString:@"],"];
    
    for (NSString* unseparated in countriesAndCitiesUnseparated) {
        
        NSArray * array = [unseparated componentsSeparatedByString:@":["];
        NSString * countryName = [array firstObject];
                                  
        countryName = [countryName substringFromIndex:1];
        countryName = [countryName substringToIndex:countryName.length-1];
        
        if (![countryName isEqualToString:@""]) {
            
            AKCountryEntity* objectCountry = [NSEntityDescription insertNewObjectForEntityForName:@"AKCountryEntity"
                                                                    inManagedObjectContext:self.persistentContainer.viewContext];
            
            objectCountry.nameCountry = countryName;
            
            NSString * citiesUnseparated = [array lastObject];
            NSArray* cities = [citiesUnseparated componentsSeparatedByString:@","];
            
            
            for (NSString * string in cities) {
                
                NSString * cityName = [string substringFromIndex:1];
                cityName = [cityName substringToIndex:cityName.length-1];
                
                if (![cityName isEqualToString:@""]) {
                    
                    if (cityName.length > 2) {
                        
                        AKCityEntity* objectCity = [NSEntityDescription insertNewObjectForEntityForName:@"AKCityEntity"
                                                                                 inManagedObjectContext:self.persistentContainer.viewContext];
                        objectCity.nameCity = cityName;
                        
                        [objectCountry addListCityObject:objectCity];
                        
                    }
                } 
            }
        }
    }
    
    NSError * error = nil;
    [self.persistentContainer.viewContext save:&error];
    
}

- (NSArray*) executeFetchRequestCountry {
    
    NSFetchRequest * request = [[NSFetchRequest alloc]init];
    
    NSEntityDescription * entityDescription = [NSEntityDescription entityForName:@"AKCountryEntity"
                                                          inManagedObjectContext:self.persistentContainer.viewContext];
    
    [request setEntity:entityDescription];
    
    NSError * error = nil;
    NSArray * resultArray = [self.persistentContainer.viewContext executeFetchRequest:request error:&error];
    
    NSSortDescriptor * sdName = [NSSortDescriptor sortDescriptorWithKey:@"nameCountry" ascending:YES];
    NSArray* arraySd = @[sdName];
    
    NSArray* sortedResultArray = [resultArray sortedArrayUsingDescriptors:arraySd];
    
    return sortedResultArray;
    
}

-(NSArray *) makeArrayFromSet: (NSSet *) set {
    
    NSMutableArray * array = [NSMutableArray array];
    for (AKCityEntity * city in set) {
        [array addObject:city];
    }
    
    NSArray * resultArray = [NSArray arrayWithArray:array];
    return resultArray;
}


- (void) loadAPIDataForCity:(AKCityEntity *)city {
    
    NSString* urlString = @"http://api.geonames.org/wikipediaSearchJSON?";
    NSURL* url = [NSURL URLWithString:urlString];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSDictionary * params = @{
                              @"q":city.nameCity,
                              @"maxRows":@"15",
                              @"username":@"leshakaras",
                              };

    [manager GET:url.absoluteString
      parameters:params
        progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * task, id   responseObject) {
            
            NSString * desc = [self getDescriptionStringFromResponse:responseObject];
            
            AKDataManager* manager = [AKDataManager sharedManager];
            manager.descCity = desc;

        } failure:^(NSURLSessionDataTask * task, NSError * error) {
            NSLog(@"error: %@", error);
        }];
    
    
}

-(NSString*) getDescriptionStringFromResponse:(id) response {
    
    NSString* string = [[NSString alloc] initWithData:response encoding:NSUTF8StringEncoding];
    
    NSArray* array = [string componentsSeparatedByString:@":[{"];
    
    NSRange range = NSMakeRange(0, 11);
    NSString* result = [[array lastObject] stringByReplacingCharactersInRange:range withString:@""];
    
    return result;
}

@end
