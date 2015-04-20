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

#import "DetailViewController.h"
#import "AppDelegate.h"

@interface DetailViewController ()
{
    

    int segundosInt;
    int minutosInt;
    
    int machine1[11];
    int machine2[11];
    int machine3[11];
    int machine4[11];
    int machine5[11];
    int machine6[11];
    int machine7[11];
    

}


@property (nonatomic, strong) AppDelegate *appDelegate;


@end

@implementation DetailViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initMachines];
    
    _appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didReceiveDataWithNotification2:)
                                                 name:@"MCDidReceiveDataNotification"
                                               object:nil];
    
    self.numMachine = [[self.datos valueForKey:@"numMachine"] intValue];
    segundosInt = [[self.datos valueForKey:@"segundosInt"] intValue];
    minutosInt = [[self.datos valueForKey:@"minutosInt"] intValue];
    
    self.numeroMaquinaLabel.text = [self.datos valueForKey:@"numMachine"];
    
    [self createTimer];
}

-(void)initMachines
{
    
    for (int x =0; x<11; x++)
    {
        machine1[x] =0;
        machine2[x] =0;
        machine3[x] =0;
        machine4[x] =0;
        machine5[x] =0;
        machine6[x] =0;
        machine7[x] =0;
        
    }
}

- (NSTimer*)createTimer {
    // create timer on run loop
    return [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerTicked:) userInfo:nil repeats:YES];
    
}

- (void)timerTicked:(NSTimer*)timer {
    if (machine1[0] == 1) {
        segundosInt ++;
        
        if (segundosInt >= 60) {
            segundosInt = 0;
            minutosInt ++;
        }
        if (segundosInt <= 9)
            self.segundosTotalLabel.text = [NSString stringWithFormat: @"0%d", segundosInt];
        else
            self.segundosTotalLabel.text = [@(segundosInt) stringValue];
        if (minutosInt <= 9)
            self.minutosTotalLabel.text = [NSString stringWithFormat: @"0%d", minutosInt];
        else
            self.minutosTotalLabel.text = [@ (minutosInt) stringValue];
        
    }
}

-(void)didReceiveDataWithNotification2:(NSNotification *)notification
{
    
    MCPeerID *peerID = [[notification userInfo] objectForKey:@"peerID"];
    NSString *peerDisplayName = peerID.displayName;
    
    NSData *receivedData = [[notification userInfo] objectForKey:@"data"];
    NSString *receivedText = [[NSString alloc] initWithData:receivedData encoding:NSUTF8StringEncoding];
    
    [self decodeStringReceived:receivedText];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)decodeStringReceived:(NSString *)receivedInfo
{
    /*
     Pos0 = @"state" 1=Play; 2=Pause; 3=Stop,
     Pos1 =@"money",
     Pos2 =@"machine",
     Pos3 =@"currentMaterial" 1=Circulo; 2=Cuadrado; 3=Triangulo,
     Pos4 =@"power" 1=Off; 2=On; 3=Adjusting,
     Pos5 =@"materialInCirculo1",
     Pos6 =@"materialInCuadrado2",
     Pos7 =@"materialInTriangulo3",
     Pos8 =@"materialOutCirculo1",
     Pos9 =@"materialOutCuadrado2",
     Pos10 =@"materialOutTriangulo3",
     */
    
    
    NSArray *myReceivedInfo= [receivedInfo componentsSeparatedByString:@"_"];
    int receivedInfoInt[11];
    
    for (int x=0; x < 11; x++)
        receivedInfoInt[x] = [myReceivedInfo[x] intValue];
    switch (receivedInfoInt[2]) {
        case 1:
            for (int x =0; x<11; x++)
            {
                machine1[x] =receivedInfoInt[x];
            }

            break;
        case 2:
            for (int x =0; x<11; x++)
            {
                machine2[x] =receivedInfoInt[x];
            }

            break;
        case 3:
            for (int x =0; x<11; x++)
            {
                machine3[x] =receivedInfoInt[x];
            }

            break;
        case 4:
            for (int x =0; x<11; x++)
            {
                machine4[x] =receivedInfoInt[x];
            }

            break;
        case 5:
            for (int x =0; x<11; x++)
            {
                machine5[x] =receivedInfoInt[x];
            }

            break;
        case 6:
            for (int x =0; x<11; x++)
            {
                machine6[x] =receivedInfoInt[x];
            }

            break;
        case 7:
            for (int x =0; x<11; x++)
            {
                machine7[x] =receivedInfoInt[x];
            }
            break;
            
            
    }
    /*
     Pos0 = @"state" 1=Play; 2=Pause; 3=Stop,
     Pos1 =@"money",
     Pos2 =@"machine",
     Pos3 =@"currentMaterial" 1=Circulo; 2=Cuadrado; 3=Triangulo,
     Pos4 =@"power" 1=Off; 2=On; 3=Adjusting,
     Pos5 =@"materialInCirculo1",
     Pos6 =@"materialInCuadrado2",
     Pos7 =@"materialInTriangulo3",
     Pos8 =@"materialOutCirculo1",
     Pos9 =@"materialOutCuadrado2",
     Pos10 =@"materialOutTriangulo3",
     */
    self.numMachine = [[self.datos valueForKey:@"numMachine"] intValue];
    switch (self.numMachine) {
        case 1: {
            dispatch_async(dispatch_get_main_queue(), ^{
                self.dineroLabel.text = [@(machine1[1]) stringValue];
            });
            if(machine1[4] == 1) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.estadoMaquina.image = [UIImage imageNamed:@"powerRed.png"];
                    self.estadoMaquinaLabel.text =@"Apagada";
                });
                

                
            }
            else if (machine1[4] == 2) {
                
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.estadoMaquina.image = [UIImage imageNamed:@"powerGreen.png"];
                    self.estadoMaquinaLabel.text =@"Encendida";
                });

                
            }
            else if (machine1[4] == 3) {
                
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.estadoMaquina.image = [UIImage imageNamed:@"powerYellow.png"];
                    self.estadoMaquinaLabel.text =@"Ajustando";
                });

                
            }
            
            if(machine1[3] == 1) {
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.ciruclo.image = [UIImage imageNamed:@"circleGreen.png"];
                });
                
            }
            else if (machine1[3] == 2) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.cuadrado.image = [UIImage imageNamed:@"squareGreen.png"];

                });
                
            }
            else if (machine1[3] == 3) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.triangulo.image = [UIImage imageNamed:@"triangleGreen.png"];

                });
                
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                self.minutosAjusteLabel.text = @"00";
                self.segundosAjusteLabel.text = @"05";
            });

            break;
            
        }
            
            
            
        case 2: {
            dispatch_async(dispatch_get_main_queue(), ^{
                self.dineroLabel.text = [@(machine2[1]) stringValue];
            });
            if(machine2[4] == 1) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.estadoMaquina.image = [UIImage imageNamed:@"powerRed.png"];
                    self.estadoMaquinaLabel.text =@"Apagada";
                });
                
                
                
            }
            else if (machine2[4] == 2) {
                
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.estadoMaquina.image = [UIImage imageNamed:@"powerGreen.png"];
                    self.estadoMaquinaLabel.text =@"Encendida";
                });
                
                
            }
            else if (machine2[4] == 3) {
                
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.estadoMaquina.image = [UIImage imageNamed:@"powerYellow.png"];
                    self.estadoMaquinaLabel.text =@"Ajustando";
                });
                
                
            }
            
            if(machine2[3] == 1) {
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.ciruclo.image = [UIImage imageNamed:@"circleGreen.png"];
                });
                
            }
            else if (machine2[3] == 2) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.cuadrado.image = [UIImage imageNamed:@"squareGreen.png"];
                    
                });
                
            }
            else if (machine2[3] == 3) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.triangulo.image = [UIImage imageNamed:@"triangleGreen.png"];
                    
                });
                
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                self.minutosAjusteLabel.text = @"00";
                self.segundosAjusteLabel.text = @"10";
            });
            
            break;
            
        }
            
            
            
            
        case 3: {
            dispatch_async(dispatch_get_main_queue(), ^{
                self.dineroLabel.text = [@(machine3[1]) stringValue];
            });
            if(machine3[4] == 1) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.estadoMaquina.image = [UIImage imageNamed:@"powerRed.png"];
                    self.estadoMaquinaLabel.text =@"Apagada";
                });
                
                
                
            }
            else if (machine3[4] == 2) {
                
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.estadoMaquina.image = [UIImage imageNamed:@"powerGreen.png"];
                    self.estadoMaquinaLabel.text =@"Encendida";
                });
                
                
            }
            else if (machine3[4] == 3) {
                
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.estadoMaquina.image = [UIImage imageNamed:@"powerYellow.png"];
                    self.estadoMaquinaLabel.text =@"Ajustando";
                });
                
                
            }
            
            if(machine3[3] == 1) {
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.ciruclo.image = [UIImage imageNamed:@"circleGreen.png"];
                });
                
            }
            else if (machine3[3] == 2) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.cuadrado.image = [UIImage imageNamed:@"squareGreen.png"];
                    
                });
                
            }
            else if (machine3[3] == 3) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.triangulo.image = [UIImage imageNamed:@"triangleGreen.png"];
                    
                });
                
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                self.minutosAjusteLabel.text = @"00";
                self.segundosAjusteLabel.text = @"03";
            });
            
            break;
            
        }
            
            
            
            
            
        case 4: {
            dispatch_async(dispatch_get_main_queue(), ^{
                self.dineroLabel.text = [@(machine4[1]) stringValue];
            });
            if(machine4[4] == 1) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.estadoMaquina.image = [UIImage imageNamed:@"powerRed.png"];
                    self.estadoMaquinaLabel.text =@"Apagada";
                });
                
                
                
            }
            else if (machine4[4] == 2) {
                
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.estadoMaquina.image = [UIImage imageNamed:@"powerGreen.png"];
                    self.estadoMaquinaLabel.text =@"Encendida";
                });
                
                
            }
            else if (machine4[4] == 3) {
                
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.estadoMaquina.image = [UIImage imageNamed:@"powerYellow.png"];
                    self.estadoMaquinaLabel.text =@"Ajustando";
                });
                
                
            }
            
            if(machine4[3] == 1) {
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.ciruclo.image = [UIImage imageNamed:@"circleGreen.png"];
                });
                
            }
            else if (machine4[3] == 2) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.cuadrado.image = [UIImage imageNamed:@"squareGreen.png"];
                    
                });
                
            }
            else if (machine4[3] == 3) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.triangulo.image = [UIImage imageNamed:@"triangleGreen.png"];
                    
                });
                
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                self.minutosAjusteLabel.text = @"00";
                self.segundosAjusteLabel.text = @"07";
            });
            
            break;
            
        }
            
            
            
            
            
        case 5: {
            dispatch_async(dispatch_get_main_queue(), ^{
                self.dineroLabel.text = [@(machine5[1]) stringValue];
            });
            if(machine5[4] == 1) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.estadoMaquina.image = [UIImage imageNamed:@"powerRed.png"];
                    self.estadoMaquinaLabel.text =@"Apagada";
                });
                
                
                
            }
            else if (machine5[4] == 2) {
                
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.estadoMaquina.image = [UIImage imageNamed:@"powerGreen.png"];
                    self.estadoMaquinaLabel.text =@"Encendida";
                });
                
                
            }
            else if (machine5[4] == 3) {
                
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.estadoMaquina.image = [UIImage imageNamed:@"powerYellow.png"];
                    self.estadoMaquinaLabel.text =@"Ajustando";
                });
                
                
            }
            
            if(machine5[3] == 1) {
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.ciruclo.image = [UIImage imageNamed:@"circleGreen.png"];
                });
                
            }
            else if (machine5[3] == 2) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.cuadrado.image = [UIImage imageNamed:@"squareGreen.png"];
                    
                });
                
            }
            else if (machine5[3] == 3) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.triangulo.image = [UIImage imageNamed:@"triangleGreen.png"];
                    
                });
                
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                self.minutosAjusteLabel.text = @"00";
                self.segundosAjusteLabel.text = @"04";
            });
            
            break;
            
        }
            
            
            
            
        case 6: {
            dispatch_async(dispatch_get_main_queue(), ^{
                self.dineroLabel.text = [@(machine6[1]) stringValue];
            });
            if(machine6[4] == 1) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.estadoMaquina.image = [UIImage imageNamed:@"powerRed.png"];
                    self.estadoMaquinaLabel.text =@"Apagada";
                });
                
                
                
            }
            else if (machine6[4] == 2) {
                
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.estadoMaquina.image = [UIImage imageNamed:@"powerGreen.png"];
                    self.estadoMaquinaLabel.text =@"Encendida";
                });
                
                
            }
            else if (machine6[4] == 3) {
                
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.estadoMaquina.image = [UIImage imageNamed:@"powerYellow.png"];
                    self.estadoMaquinaLabel.text =@"Ajustando";
                });
                
                
            }
            
            if(machine6[3] == 1) {
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.ciruclo.image = [UIImage imageNamed:@"circleGreen.png"];
                });
                
            }
            else if (machine6[3] == 2) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.cuadrado.image = [UIImage imageNamed:@"squareGreen.png"];
                    
                });
                
            }
            else if (machine6[3] == 3) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.triangulo.image = [UIImage imageNamed:@"triangleGreen.png"];
                    
                });
                
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                self.minutosAjusteLabel.text = @"00";
                self.segundosAjusteLabel.text = @"06";
            });
            
            break;
            
        }
            
            
            
            
            
        case 7: {
            dispatch_async(dispatch_get_main_queue(), ^{
                self.dineroLabel.text = [@(machine7[1]) stringValue];
            });
            if(machine7[4] == 1) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.estadoMaquina.image = [UIImage imageNamed:@"powerRed.png"];
                    self.estadoMaquinaLabel.text =@"Apagada";
                });
                
                
                
            }
            else if (machine7[4] == 2) {
                
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.estadoMaquina.image = [UIImage imageNamed:@"powerGreen.png"];
                    self.estadoMaquinaLabel.text =@"Encendida";
                });
                
                
            }
            else if (machine7[4] == 3) {
                
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.estadoMaquina.image = [UIImage imageNamed:@"powerYellow.png"];
                    self.estadoMaquinaLabel.text =@"Ajustando";
                });
                
                
            }
            
            if(machine7[3] == 1) {
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.ciruclo.image = [UIImage imageNamed:@"circleGreen.png"];
                });
                
            }
            else if (machine7[3] == 2) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.cuadrado.image = [UIImage imageNamed:@"squareGreen.png"];
                    
                });
                
            }
            else if (machine7[3] == 3) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.triangulo.image = [UIImage imageNamed:@"triangleGreen.png"];
                    
                });
                
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                self.minutosAjusteLabel.text = @"00";
                self.segundosAjusteLabel.text = @"02";
            });
            
            break;
            
        }

            
            
    }
    
    
    
    
    
    
}
-(void) setDatos:(id)datos
{
    _datos = datos;

}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
