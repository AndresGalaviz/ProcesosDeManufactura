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

#import "ViewController.h"
#import "AppDelegate.h"
#import "ResultsViewController.h"
#import "CustomView.h"
#import "CommunicationManager.h"

@interface MachineViewController : ViewController



@property (nonatomic, strong) AppDelegate *appDelegate;
@property (nonatomic, retain) NSString *updateCirculoLabel;
@property (nonatomic, retain) NSString *updateCuadradoLabel;
@property (nonatomic, retain) NSString *updateTrianguloLabel;



@property (nonatomic, retain) NSString *updateDineroLabel;

@property int numMachine;

-(void)didReceiveDataWithNotification:(NSNotification *)notification;
@property (strong, nonatomic) IBOutlet CustomView *vista;
@property CommunicationManager *comCommunicationManager;
- (IBAction)comprarMaterialUno:(id)sender;
- (IBAction)comprarMaterialDos:(id)sender;
- (IBAction)comprarMaterialTres:(id)sender;
- (IBAction)comprarMaterialCuatro:(id)sender;
- (IBAction)comprarMaterialCinco:(id)sender;

- (IBAction)encenderMaquina:(id)sender;
- (IBAction)apagarMaquina:(id)sender;

@end
