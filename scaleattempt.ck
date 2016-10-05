SinOsc s => dac;
//http://www.phy.mtu.edu/~suits/notefreqs.html for fq notes
//440 standard A note
440=> float initial;
initial=>s.freq;
2 => float whole;
1 => float half;
0 => float steps;
1 => float octaves;
1.059463 => float constant;
.1 =>s.gain;
//500=> float times;

1::minute/100/2 => dur T; //140 bpm eighth notes
T - (now % T) => now; //sync to beat
//500::ms => now;
//while(true){
major(initial,octaves);    
//minor(initial,octaves);   
//500::ms => now;      
                     
//}
fun void major(float initial,float octaves){
    while(true){
    // going up 
    for(0 => int i; i <octaves; i++){
        for(0 => int j; j <2; j++){
            wholestep(0);
          }
        halfstep(0);
          
        for(0 => int j; j <3; j++){
            wholestep(0);
          } 
        halfstep(0);
    }
    // going down
     for(0 => int i; i <octaves; i++){        
          halfstep(1);
         
          for(0 => int j; j <3; j++){
          wholestep(1);
          }  
          halfstep(1);
          
          for(0 => int j; j <2; j++){
             wholestep(1);
          }                                
    }
    
}
}

fun void minor(float initial,float octaves){
    // going up 
     for(0 => int i; i <octaves; i++){
    
        wholestep(0);
        halfstep(0);
                     
         for(0 => int j; j <2; j++){
             wholestep(0);
         }
        
         halfstep(0);
         
          for(0 => int j; j <2; j++){
             wholestep(0);
         }
     }
        // going down
     for(0 => int i; i <octaves; i++){
        for(0 => int j; j <2; j++){
           wholestep(1);
         }
         
         halfstep(1); 
         
         for(0 => int j; j <2; j++){
             wholestep(1);
         }
         halfstep(1);
         wholestep(1);
     }
}

fun void wholestep(int sign){
    //pos
    if(sign == 0){
       Math.pow(constant,steps)*initial => s.freq;;       
       steps + whole => steps;
       T => now;
    }
    //neg
    else if(sign == 1){
       Math.pow(constant,steps)*initial => s.freq;       
       steps - whole => steps;
       T => now;
    }
}

fun void halfstep(int sign){
    //pos
    if(sign == 0){
       Math.pow(constant,steps)*initial => s.freq;       
       steps + half => steps;
       T => now;
    }
    //neg
    else if(sign == 1){
       Math.pow(constant,steps)*initial => s.freq;       
       steps - half => steps;
       T=> now;
    }
}


        