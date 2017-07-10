//
//  AKCountryEntity+CoreDataProperties.h
//  TestTaskK
//
//  Created by Alexei Karas on 09.07.17.
//  Copyright © 2017 Alexei Karas. All rights reserved.
//

#import "AKCountryEntity+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface AKCountryEntity (CoreDataProperties)

+ (NSFetchRequest<AKCountryEntity *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *nameCountry;
@property (nullable, nonatomic, retain) NSSet<AKCityEntity *> *listCity;

@end

@interface AKCountryEntity (CoreDataGeneratedAccessors)

- (void)addListCityObject:(AKCityEntity *)value;
- (void)removeListCityObject:(AKCityEntity *)value;
- (void)addListCity:(NSSet<AKCityEntity *> *)values;
- (void)removeListCity:(NSSet<AKCityEntity *> *)values;

@end

NS_ASSUME_NONNULL_END
