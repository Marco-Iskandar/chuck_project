synth2 syn;
//syn.setGain(.2);
// 2,2,1,2,2,2,1
1::minute/120/2 => dur T; //140 bpm eighth notes
T - (now % T) => now; //sync to beat

syn.setGain(.2);
T/2 => dur s;
T => dur e;
T*2 => dur q;
T*4 => dur h;
T*8 => dur w;

int notes[4];

//70,82,81,82,84,74,79,75,74,72,74
[70,82,81,82,79,74, 77,75,74,72,69] @=> int rhythm1n[];
[q,q,q,q,h,q,q,q,q,q,q] @=> dur rhythm1b[];

//arp(80);

//while(true){
//bass2();    
//}

rhythm1func();
//play1(70,q);

fun void play1(int note, dur beat){
    while(true){
    q => now;
    syn.playnote(note,beat);
    
    }
    
}

fun void bass2(){
[46,46,46,46] @=> int bass2n[];
[q+e,q+e,q+e,q+e] @=> dur bass2b[];

  1 => float arpgain;
    0 => int count;
       for(0 => int i; i < bass2b.cap();i++){
           
          syn.setGain(arpgain);
          syn.playnote(bass2n[i],bass2b[i]);//3,5,7
          count++;                     
        }    

}

fun void rhythm1func(){
    while(true){
        0 => int LR;
     .5 => float arpgain;
         for(0 => int i; i < rhythm1b.cap();i++){
             if(LR == 1){
                 syn.setPan(1);
              
                 LR--;
             }
             else{
             if(LR == 0){
                 syn.setPan(-1);
                 
                 LR++;
             }
         }
            syn.setGain(arpgain);
            syn.playnote(rhythm1n[i]+5,rhythm1b[i]);
         
            
        }
        
    }
    

}


fun void arp(int init){
    init => notes[0];
    init + 4 => notes[1];
    init + 7=> notes[2];
    init + 12 => notes[3];
    .2 => float arpgain;
    T*1.5 => dur duration;
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
class synth2{
    SinOsc osc1, osc2, osc3, osc4;
    ADSR adsr => Gain g =>  Pan2 p => Echo echo => NRev rev =>  dac;
    osc1 => adsr;  
    0.2 => g.gain;
    0 => p.pan;
    0::ms => echo.delay; 
              //a       d       s      r 
    adsr.set(0.5::ms, 0.3::ms, 1.0, 100::ms);
    0.2 =>rev.mix;
    
    //freq of each osc
    fun void setFreq(int noteNum){
        Std.mtof(noteNum) => float freq;
        freq => osc1.freq;
       // 1 => osc1.harmonics;

    }
    
    fun void setPan(float panning){
        panning => p.pan;
       
    
    }
    fun void setDelay(dur T){
        T=> echo.delay;
       
    } 
    
    // gain
    fun void setGain(float gain){
        gain =>osc1.gain;
 
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
