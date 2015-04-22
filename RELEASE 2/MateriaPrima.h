//
//  MateriaPrima.h
//  DibujarProceso
//
//  Created by alumno on 21/04/15.
//  Copyright (c) 2015 ITESM. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MateriaPrima : NSObject

@property NSInteger count;
@property NSInteger precio;
@property NSInteger posicion;

-(id)initWithPrecio:(NSInteger)precio posicion:(NSInteger)posicion;

@end