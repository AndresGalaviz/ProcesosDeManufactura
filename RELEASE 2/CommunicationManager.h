//
//  CommunicationManager.h
//  Prototipo para simulador de procesos de manufactura
//  Juan Paulo Lara, Manuel Calzado y Andrés López De León
//  Alberto Astiazarán, Andrés Galaviz
//
//
//  Fecha de creación: 04/22/15.
//  Fecha de última actualización: 05/10/15
//  Descripción general: Archivo que se encarga de la comunicación del estado
//  del proceso y de codificar y decodificar la información que se transmite.
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
#import "Process.h"

@interface CommunicationManager : NSObject

@property (strong, nonatomic) Process *process;
@property BOOL admin;

-(id)initWithProcess:(Process *)process asAdmin:(BOOL)admin;

-(NSString *)getGeneralProcessStatus;
-(void)receiveInformation:(NSString *)info;
-(NSString *)endProcess;
-(NSString *)turnOnMachine:(NSInteger)numMachine;
-(NSString *)turnOffMachine:(NSInteger)numMachine;
-(NSString *)buyMaterial:(NSInteger)numMaterial quantity:(NSInteger)q;
-(void)showMachinesWithType:(NSInteger)type;
-(void)hideMachines;

@end
