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

#import "ResultsViewController.h"

@interface ResultsViewController ()

@end

@implementation ResultsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.presupuestoInicial.text = [self.datos valueForKey:@"presupuestoInicial"];
    self.presupuestoFinal.text = [self.datos valueForKey:@"presupuestoFinal"];
    self.tiempoTotal.text = [self.datos valueForKey:@"tiempoTotal"];
    self.productosProcesados.text = [self.datos valueForKey:@"productosProcesados"];
    self.participantes.text = [self.datos valueForKey:@"participantes"];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void) setDatos:(id)datos
{
    _datos = datos;
    
}

@end
