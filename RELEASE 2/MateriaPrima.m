//
//  MateriaPrima.m
//  DibujarProceso
//
//  Created by alumno on 21/04/15.
//  Copyright (c) 2015 ITESM. All rights reserved.
//

#import "MateriaPrima.h"

@implementation MateriaPrima

-(id)initWithPrecio:(NSInteger)precio posicion:(NSInteger)posicion {
    _count = 0;
    _precio = precio;
    _posicion = posicion;
    return self;
}

@end
