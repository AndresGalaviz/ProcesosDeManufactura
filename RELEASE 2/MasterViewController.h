//
//  MCManager.h
//  Prototipo para simulador de procesos de manufactura
//  Juan Paulo Lara, Manuel Calzado y Andrés López De León
//
//  Fecha de creación: 10/24/14
//  Fecha de última actualización: 11/17/14
//  Descripción general: Archivo que se encarga de manejar las conexiones
//  a traves de multipeer connectivity
//
//  Copyright (c) 2014 ITESM. All rights reserved.
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
// Code retrived from Gabriel Theodoropoulos tutorial
// <http://www.appcoda.com/intro-multipeer-connectivity-framework-ios-programming/>
//
//  Authors:
//
//  ITESM representatives
//  Ing. Martha Sordia Salinas  <msordia@itesm.mx>
//  Ing. Mario de la Fuente     <mario.delafuente@itesm.mx>
//
//  ITESM students
//  Juan Paulo Lara Rodríguez   <jplarar@gmail.com>
//  Manuel Calzado              <mcm_maycod@hotmail.com>
//  Andrés López De León        <agldeleon@gmail.com>
//

#import <UIKit/UIKit.h>
#import "DetailViewController.h"


@interface MasterViewController : UITableViewController
@property (strong, nonatomic) IBOutlet UIImageView *estadoMaquina1;
@property (strong, nonatomic) IBOutlet UIImageView *estadoMaquina2;
@property (strong, nonatomic) IBOutlet UIImageView *estadoMaquina3;
@property (strong, nonatomic) IBOutlet UIImageView *estadoMaquina4;
@property (strong, nonatomic) IBOutlet UIImageView *estadoMaquina5;
@property (strong, nonatomic) IBOutlet UIImageView *estadoMaquina6;
@property (strong, nonatomic) IBOutlet UIImageView *estadoMaquina7;

@property (strong, nonatomic) IBOutlet UIImageView *materialMaquina1;
@property (strong, nonatomic) IBOutlet UIImageView *materialMaquina2;
@property (strong, nonatomic) IBOutlet UIImageView *materialMaquina3;
@property (strong, nonatomic) IBOutlet UIImageView *materialMaquina4;
@property (strong, nonatomic) IBOutlet UIImageView *materialMaquina5;
@property (strong, nonatomic) IBOutlet UIImageView *materialMaquina6;
@property (strong, nonatomic) IBOutlet UIImageView *materialMaquina7;

- (IBAction)stopAll:(id)sender;

- (IBAction)verDetalle1:(id)sender;
- (IBAction)verDetalle2:(id)sender;
- (IBAction)verDetalle3:(id)sender;
- (IBAction)verDetalle4:(id)sender;
- (IBAction)verDetalle5:(id)sender;
- (IBAction)verDetalle6:(id)sender;
- (IBAction)verDetalle7:(id)sender;


@end
