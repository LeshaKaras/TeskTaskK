//
//  AKCityEntity+CoreDataProperties.m
//  TestTaskK
//
//  Created by Alexei Karas on 09.07.17.
//  Copyright © 2017 Alexei Karas. All rights reserved.
//

#import "AKCityEntity+CoreDataProperties.h"

@implementation AKCityEntity (CoreDataProperties)

+ (NSFetchRequest<AKCityEntity *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"AKCityEntity"];
}

@dynamic nameCity;
@dynamic ownerCountry;

@end
