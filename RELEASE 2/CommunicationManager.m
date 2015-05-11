//
//  CommunicationManager.m
//  Prototipo para simulador de procesos de manufactura
//  Juan Paulo Lara, Manuel Calzado y Andrés López De León
//  Alberto Astiazarán, Andrés Galaviz
//
//
//  Fecha de creación: 04/22/15.
//  Fecha de última actualización: 05/10/15
//  Descripción general: Archivo que se encarga de la comunicación del estado
//  del proceso y de codificar y decodificar la información que se transmite.
//  Los strings que regresan estos métodos deben de utilizarse para mandar la
//  información a los demás participantes, y esta debe ser por receiveInformation
//  para su interpretación.
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

#import "CommunicationManager.h"
#import "Stage.h"

@implementation CommunicationManager

-(id)initWithProcess:(Process *)process asAdmin:(BOOL)admin {
    _process = process;
    _admin = admin;
    return self;
}

/*
 info[0]: sender
 info[1]: activo
 info[2]: accion
 */

// Los siguientes métodos deben ser utilizados por el administrador
-(NSString *)getGeneralProcessStatus {
    NSString *info = @"01_";
    info = [info stringByAppendingString:[_process exportToString]];
    return info;
}
-(NSString *)endProcess {
    return @"00";
}

// Los siguientes métodos deben ser utilizados por los usuarios
-(NSString *)turnOnMachine:(NSInteger)numMachine {
    NSString *info = [NSString stringWithFormat:@"110_%d", numMachine];
    return info;
}
-(NSString *)turnOffMachine:(NSInteger)numMachine {
    NSString *info = [NSString stringWithFormat:@"111_%d", numMachine];
    return info;
}
-(NSString *)buyMaterial:(NSInteger)numMaterial quantity:(NSInteger)q {
    NSString *info = [NSString stringWithFormat:@"112_%d_%d", numMaterial, q];
    return info;
}

// Todos deben utilizar este método para recibir información
-(void)receiveInformation:(NSString *)info {
    if (_admin) {
        NSArray *myReceivedInfo= [info componentsSeparatedByString:@"_"];
        if ([info characterAtIndex:2] == '0') {
            NSInteger numMachine = [myReceivedInfo[1] integerValue];
            [_process encenderMaquina:numMachine];
        } else if ([info characterAtIndex:2] == '1') {
            NSInteger numMachine = [myReceivedInfo[1] integerValue];
            [_process apagarMaquina:numMachine];
        }  else if ([info characterAtIndex:2] == '2') {
            NSInteger numMaterial = [myReceivedInfo[1] integerValue];
            NSInteger quantity = [myReceivedInfo[2] integerValue];
            [_process comprarMateriaPrima:numMaterial cantidad:quantity];
        }
    } else if ([info characterAtIndex:0] == '0') {
        if ([info characterAtIndex:1] == '0') {
            _process.activo = NO;
        } else {
            [_process importFromString:info];
        }
    }
}

// Muestra y esconde los IDs de las máquinas para que sean identificadas
-(void)showMachinesWithType:(NSInteger)type {
    for (int i = 0; i < _process.maquinas.count; i++) {
        Stage *stage = _process.maquinas[i];
        if (stage.type == type) {
            stage.mostrarId = YES;
        }
    }
}
-(void)hideMachines {
    for (int i = 0; i < _process.maquinas.count; i++) {
        Stage *stage = _process.maquinas[i];
        stage.mostrarId = NO;
    }
}

@end
