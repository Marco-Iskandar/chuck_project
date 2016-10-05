
1::minute/120/2 => dur T; //140 bpm eighth notes
T - (now % T) => now; //sync to beat
T/2 => dur s;
T => dur e;
T*2 => dur q;
T*4 => dur h;
T*8 => dur w;

Rhodes rhod;

[ 0, 2, 4, 7, 9 ] @=> int pentatonic[];

[70,82,81,82,79,74, 77,75] @=> int rhythm1n[];
[q,q,q,q,h,q,q,q] @=> dur rhythm1b[];


[70,82,81,82,79,74, 77,70] @=> int rhythm2n[];
[q,q,q,q,h,q,q,q] @=> dur rhythm2b[];

[34,34,34,34] @=> int bass1n[];
[w*2,w*2,w*2,w*2] @=> dur bass1b[];


while(true){
    
bass1();

    
}

fun void rhythm_combo(){
    rhythm1func();
    w*2 => now;
    rhythm2func();
    w*2=> now;
}

fun void lick(){
    [70,82,81,82,69,81, 80,81] @=> int lick1n[];
    [q,q,q,q,q,q,q,q] @=> dur lick1b[];
    .3 => float arpgain;
    0 => int count;
       for(0 => int i; i < lick1n.cap();i++){
           
          rhod.setGain(arpgain);
          rhod.playnote(lick1n[i]-24,lick1b[i],1);//3,5,7
          count++;                     
        }    

}


// use with echo
fun void bass1(){
    1 => float arpgain;
    0 => int count;
       for(0 => int i; i < bass1b.cap();i++){
           
          rhod.setGain(arpgain);
          rhod.playnote(bass1n[i]+7,bass1b[i],1);//3,5,7
          count++;                     
        }    
}

fun void bass2(){
[34,34,36,36,38,36,33] @=> int bass2n[];
[h,h,h,h,h,q,q,q] @=> dur bass2b[];

  .3 => float arpgain;
    0 => int count;
       for(0 => int i; i < bass2n.cap();i++){
           
          rhod.setGain(arpgain);
          rhod.playnote(bass2n[i],bass2b[i],1);//3,5,7
          count++;                     
        }    

}


fun void rhythm1func(){
   
     .8 => float arpgain;
      0 => int count;
         for(0 => int i; i < rhythm1b.cap();i++){
           
            rhod.setGain(arpgain);
            rhod.playnote(rhythm1n[i],rhythm1b[i],.5);
             count++;         
            
        }
       
        rhod.playnote(rhythm1n[count-2],w*2,.5);
            

}

fun void rhythm2func(){
   
     .8 => float arpgain;
      0 => int count;
     rhod.setGain(arpgain);
         for(0 => int i; i < rhythm2b.cap();i++){
           
           
            rhod.playnote(rhythm2n[i],rhythm2b[i],.5);
             count++;
         
            
        }
       
        rhod.playnote(rhythm2n[count-1],w*2,.5);   

}

class Rhodes{
    Rhodey voc => JCRev r => Echo a => Echo b => Echo c => dac;
    
    //220.0 => voc.freq;
    0.8 => voc.gain;
    .8 => r.gain;
    .2 => r.mix;
    1000::ms => a.max => b.max => c.max;// orig = 1000. set 0 = no echo
    750::ms => a.delay => b.delay => c.delay;// orig set = 750. ^
    .50 => a.mix => b.mix => c.mix;  
    
    fun void setFreq(int noteNum){
        Std.mtof(noteNum) => voc.freq;        
    }
    
      fun void setGain(float gain){
        gain => voc.gain;
    }
    
      fun void noteon(float vol){
        voc.noteOn(vol);
    }
    
    fun void noteoff(float vol){
        voc.noteOn(vol);
    }
    
     fun void playnote(int noteNum, dur T, float vol){
        this.setFreq( noteNum);
        this.noteon(vol);
        T => now;
        this.noteoff(vol);
                    
    }
    
    
}