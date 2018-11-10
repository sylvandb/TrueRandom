/*
 * Upload that code to an Arduino Duemilanove and watch it on the
 * Serial Monitor at 9600 baud.
 *
 * The random() function returns the same value every time, but the
 * TrueRandom version is always different.
 *
 * Hit the reset button, and see what it does.
 */

#include <TrueRandom.h>

void setup() {
  Serial.begin(9600);
  Serial.print("I threw a random die and got ");
  Serial.print(random(1,7));
  Serial.print(". Then I threw a TrueRandom die and got ");
  Serial.println(TrueRandom.random(1,7));
}

void loop() {
  ; // Do nothing
}
