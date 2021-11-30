x0 = 0;
x1 = 10;
Q = [rand(1);rand(1);rand(1);rand(1);rand(1);rand(1)];
dis_gl = GaussLegendreIntegration( x0,x1,Q )
dis_trap = TrapIntegration( x0,x1,Q )
