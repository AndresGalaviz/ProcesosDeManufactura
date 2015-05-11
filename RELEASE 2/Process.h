//
//  Process.h
//  Prototipo para simulador de procesos de manufactura
//  Juan Paulo Lara, Manuel Calzado y Andrés López De León
//  Alberto Astiazarán, Andrés Galaviz
//
//
//  Fecha de creación: 04/15/15.
//  Fecha de última actualización: 05/10/15
//  Descripción general: Clase que administra la simulación de un proceso de
//  manufactura.
//
//  Copyright (c) 2014-2015 ITESM. All rights reserved.
//
//  This file is part of "Prototipo para simulador de procesos de manufactura".
//
//  "Prototipo para simulador de procesos de manufactura" is free software:
//  you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published by
//  the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//
//  "Prototipo para simulador de procesos de manufactura" is distributed in
//  the hope that it will be useful,
//  but WITHOUT ANY WARRANTY; without even the implied warranty of
//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//  GNU General Public License for more details.
//
//  You should have received a copy of the GNU General Public License
//  along with Foobar.  If not, see <http://www.gnu.org/licenses/>.
//
//  Authors:
//
//  Alberto Astiazarán          <a01240828@itesm.mx>
//  Andrés Galaviz              <a01044679@itesm.mx>
//

#import <Foundation/Foundation.h>

@interface Process : NSObject

@property NSMutableArray *maquinas;
@property NSMutableArray *conecciones;
@property NSMutableArray *numDestino;
@property NSMutableArray *materiasPrima;
@property BOOL activo;
@property NSInteger dinero;
@property NSInteger presupuestoInicial;
@property NSInteger minutos;
@property NSInteger segundos;

-(id)init;
-(id)initDemo;
-(void)procesar;
-(void)comprarMateriaPrima:(NSInteger)index cantidad:(NSInteger)cantidad;
-(void)encenderMaquina:(NSInteger)index;
-(void)apagarMaquina:(NSInteger)index;
-(NSString *)exportToString;
-(void)importFromString:(NSString *)receivedInfo;

@end
