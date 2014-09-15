byte button[] = { 8, 1};
byte frames[] = { 1, 0};

#define clockInterrupt 0
#define latchInterrupt 1

#define dataShift 2
#define dataMask (1 << dataShift)

byte buttons = 0;
int frame = 0;
int index = 0;

int nextframe = frames[0];

void setup() {
  pinMode(A2, OUTPUT);

  attachInterrupt(latchInterrupt, latch, RISING);
  attachInterrupt(clockInterrupt, clock, RISING);

  PORTC |= dataMask;
}

void latch() {
  frame++;
  if(frame > nextframe && index < sizeof(frames)-1 ){
    index++;
    nextframe += frames[index];
  }
  buttons = ~button[index];
  PORTC = (PORTC & ~dataMask) | ((buttons & 1) << dataShift);
  buttons >>= 1;
}

void clock() {  
  PORTC = (PORTC & ~dataMask) | ((buttons & 1) << dataShift);
  buttons >>= 1;
}

void loop() {
}

