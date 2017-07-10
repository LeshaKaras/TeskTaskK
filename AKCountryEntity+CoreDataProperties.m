//
//  AKCountryEntity+CoreDataProperties.m
//  TestTaskK
//
//  Created by Alexei Karas on 09.07.17.
//  Copyright © 2017 Alexei Karas. All rights reserved.
//

#import "AKCountryEntity+CoreDataProperties.h"

@implementation AKCountryEntity (CoreDataProperties)

+ (NSFetchRequest<AKCountryEntity *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"AKCountryEntity"];
}

@dynamic nameCountry;
@dynamic listCity;

@end
