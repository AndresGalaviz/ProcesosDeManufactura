//
//  Proceso.h
//  release 2
//
//  Created by alumno on 15/04/15.
//  Copyright (c) 2015 JuanPauloLara. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Process : NSObject

@property NSMutableArray *maquinas;
@property NSMutableArray *conecciones;
@property NSMutableArray *numDestino;

-(id) init;
-(id) initDemo;

@end
