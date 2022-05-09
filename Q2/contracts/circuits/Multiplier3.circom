pragma circom 2.0.0;

/*This circuit template checks that c is the multiplication of a and b.*/  

template Multiplier2 () {  

   // Declaration of signals.  
   signal input a;  
   signal input b;  
   signal output c;
   // Constraints.  
   c <== a * b;  

}

// component main {public [a, b]}= Multiplier2();


template Multiplier3 () {  

   // Declaration of signals.  
   signal input a;  
   signal input b;  
   signal input c;
   signal output d;
   // Constraints.  
   component mult1 = Multiplier2(); 
   component mult2 = Multiplier2(); 

   mult1.a <== a;
   mult1.b <== b;
   mult2.a <== mult1.c;
   mult2.b <== c;
   d <== mult2.c;

}

component main = Multiplier3();