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
//syn.setFreq(31);
//syn.setGain(.3);
//syn.noteOn();
//while(true){

//}


arp(50);
//spork ~arp(60);
//spork ~arp(34);
//bass();

        
fun void arp(int init){
    init => notes[0];
    init + 4 => notes[1];
    init + 7=> notes[2];
    init + 12 => notes[3];
    .2 => float arpgain;
    q => dur duration;
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


fun void bass(){
    synth bass;
    bass.setGain(0.1);
    while(true){
        bass.playnote(29,4*T);// original was 7*T
        8*T => now;// orig was 8*T
    }
}
        







class synth{
    SawOsc osc1, osc2, osc3, osc4;
    ADSR adsr => Gain g => NRev rev =>  dac;
    //osc1 => adsr;
    osc2 => adsr;
    osc3 => adsr;
    osc4 => adsr;
    0.4 => g.gain;
  
    
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
        .4*gain =>osc2.gain;
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
