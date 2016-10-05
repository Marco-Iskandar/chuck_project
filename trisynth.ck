synth syn;
//syn.setGain(.2);

1::minute/120/2 => dur T; //140 bpm eighth notes
T - (now % T) => now; //sync to beat
T/2 => dur s;
T => dur e;
T*2 => dur q;
T*4 => dur h;
T*8 => dur w;

int notes[4];

//syn.setGain(.3);
//syn.noteOn();
while(true){
highlick();

}


0 => int countq;
0 => int counte;
0 => int counts;
0 => int total;
17 => int measure;


//bass();



fun void highlick(){
[96,95,93,91,93,91, 89,88,84,79,74,76,77,79] @=> int rhythm1n[];
[e,e,e,e,q,e,e,e,e,q,q,e,e] @=> dur rhythm1b[];

[96,95,93,91,93,91, 89,88,84,88,89,93,98,96] @=> int rhythm2n[];    
    
 .2=> float arpgain;
      0 => int count;
         for(0 => int i; i < rhythm1b.cap();i++){
           
            syn.setGain(arpgain);
            syn.playnote(rhythm1n[i],rhythm1b[i]);
             count++;         
            
        }
      w => now;
        
         for(0 => int i; i < rhythm1b.cap();i++){
           
            syn.setGain(arpgain);
            syn.playnote(rhythm2n[i],rhythm1b[i]);
             count++;         
            
        }
        w*2 => now;
           
    
}



fun void scaletest(){
    [84,86,88,89,91,93,95,96]  @=> int Cscale[];
    [s,e,q] @=> dur beats[];
    0 => int trues;
    1 => int falses;
    1 => int pass;
    0 => int temp;
    0 => int b;
    1 => int check;
    syn.setGain(.3);
  // 3 quarters 6 eithts 8 16th
  Math.random2(0,7) => int n;
    
    if(measure == total){
        0 => total;
        0 => counts;
        0 => counte;
        0 => countq;
        Math.random2(0,2) =>  b;
        convert(b) => temp;
        insert(temp);
        
          
    }
    else{
       
        while(pass != trues){
            Math.random2(0,2) =>  b; 
            convert(b) => temp;
            checkcount(temp) => check;
            
            if(check == 0) {
                insert(temp);
                0 => pass;
                1 => check;
            }
            else{
                1 => pass;
            }
        }
    }
    

      
      temp + total => total;
       // Math.random2(0,2) => int b;  
    .3 => float arpgain;
     syn.setGain(arpgain);
            syn.playnote(Cscale[n],beats[b]);
   
    
}




fun int convert(int beat){
    if(beat == 2){
        return 4;
    }
    else{
        if(beat == 1){
            return 2;
        }  
        else{
            return 1;
        }
    }
   
    
}


fun void insert(int beat){
    if(beat == 4){
       countq + 1 => countq;
    }
    else{
        if(beat == 2){
            counte + 1 => counte;
        }  
        else{
            counts + 1 => counts;
        }
    }
   
    
}

fun int checkcount(int beat){
    total + beat => int temp;
  
    
      if(beat == 4 && countq <= 3 && temp <= measure){
        return 0;
    }
    else{
        if(beat == 2 && counte <= 6 && temp <= measure){
           return 0;
        }  
        else{
            if(beat == 1 && counts <= 8 && temp <= measure){
                return 0;
            }
          
        }
        
    }
    return 1;
    
    
}


fun void arp(int init){
    init => notes[0];
    init + 4 => notes[1];
    init + 7=> notes[2];
    init + 12 => notes[3];
    .1 => float arpgain;
    e=> dur duration;
    syn.setGain(arpgain);
    syn.playnote(notes[0],duration);
    
    while(true){
    for(1 => int i; i < notes.cap(); i++){
        //syn.setFreq(notes[i]);
        syn.setGain(arpgain);
        syn.playnote(notes[i],duration);
        //T=> now;
        
    }
     for(2 => int i; i >= 0; i--){
        //syn.setFreq(notes[i]);
        syn.setGain(arpgain);
        syn.playnote(notes[i],duration);
        //T=> now;
        
    }
}
        
    
    
}
     


class synth{
    TriOsc osc1, osc2, osc3, osc4;
    ADSR adsr => Gain g => NRev rev => dac;
    osc1 => adsr;
    //osc2 => adsr;
    //osc3 => adsr;
    //osc4 => adsr;
    0.2 => g.gain;
    
              //a       d       s      r 
    adsr.set(0.5::ms, 0.3::ms, 1.0, 100::ms);
    0.2 =>rev.mix;
    
    //freq of each osc
    fun void setFreq(int noteNum){
        Std.mtof(noteNum) => float freq;
        freq => osc1.freq;
        2*freq =>osc2.freq;
        3*freq =>osc3.freq;
        4*freq =>osc4.freq;
    }
    
    // gain
    fun void setGain(float gain){
        gain =>osc1.gain;
        .5*gain =>osc2.gain;
        .3*gain => osc3.gain;
        .2*gain => osc4.gain;
    }
    
    fun void noteOn(){
        adsr.keyOn();
    }
    
    fun void noteOff(){
        adsr.keyOff();
    }
    
    fun void playnote(int noteNum, dur T){
        this.setFreq( noteNum);
        this.noteOn();
        T => now;
        this.noteOff();
                    
    }
    
}
