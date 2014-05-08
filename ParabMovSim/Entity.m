//
//  PhysicsEngine.m
//  PegaMaca
//
//  Created by Adriano Papa on 3/2/14.
//  Copyright (c) 2014 Adriano Papa. All rights reserved.
//

#import "Entity.h"

@implementation Entity

@synthesize s;

- (id)initWithKey:(NSString*)_key andAngle:(double)angleInDegree andVelocity:(double)velocity
{
    self = [super init];
    
    if (self)
    {
        // Initialization code
        s = [[Vector alloc] initWithZeros]; // Vetor de deslocamento do projetil
        
		key = _key;
        Vm = velocity;                      // Velocidade de saida do projetil (escalar)
        Alpha = angleInDegree;              // Angulo entre o canhão e o eixo Y
        Gamma = 0.0;                        // Angulo entre a projeção do canhão no eixo Z e o eixo X
        L = 12.0;                           // Tamanho do canhão
        Yb = 10.0;                          // Elevação do canhão
        time = 0.0;
        tInc = 0.05;                        // incremento de tempo
        g = 9.8;
    }
    
    return self;
}

- (void)update
{
    double cosX;
    double cosY;
    double cosZ;
    double xe, ze;
    double b, Lx, Ly, Lz;
    
    time += tInc;
    
    b = L * cos((90-Alpha) * M_PI/180);
    Lx = b * cos(Gamma * M_PI/180);
    Ly = L * cos(Alpha * M_PI/180);
    Lz = b * sin(Gamma * M_PI/180);
    
    cosX = Lx/L;
    cosY = Ly/L;
    cosZ = Lz/L;
    
    xe = L * cos((90-Alpha) * M_PI/180) * cos(Gamma * M_PI/180);
    ze = L * cos((90-Alpha) * M_PI/180) * sin(Gamma * M_PI/180);
    
    s.x = Vm * cosX * time + xe;
    s.y = (Yb + L * cos(Alpha * M_PI/180)) + (Vm * cosY * time) - (0.5 * g * time * time);
    s.z = Vm * cosZ * time + ze;

    return;
}


@end
