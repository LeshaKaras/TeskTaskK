//
//  AKCityEntity+CoreDataProperties.h
//  TestTaskK
//
//  Created by Alexei Karas on 09.07.17.
//  Copyright © 2017 Alexei Karas. All rights reserved.
//

#import "AKCityEntity+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface AKCityEntity (CoreDataProperties)

+ (NSFetchRequest<AKCityEntity *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *nameCity;
@property (nullable, nonatomic, retain) AKCountryEntity *ownerCountry;

@end

NS_ASSUME_NONNULL_END
