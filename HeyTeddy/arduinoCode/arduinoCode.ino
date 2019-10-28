/*
	Auto-Generated Code by HeyTeddy
	2019-10-24T20:26:20.179
*/

void setup() {
	pinMode(11, OUTPUT);
	pinMode(6, OUTPUT);
	//[3] Pulse D10 every 1.0 seconds 10 times
	pinMode(10, OUTPUT);
	int period = 1000.0; 
	int times = 10; 
	for(int i=0; i<10; i++) { 
	  delay(period); 
	  digitalWrite(10, HIGH);
	  delay(period); 
	  digitalWrite(10, LOW);
	}


}

void loop() {
	//[1] if ( A2 > 300 ) then { [0] Write D11 high }
	if(analogRead(2) > 300)
	{
	//[0] Write D11 high
	digitalWrite(11, HIGH);
	}
	
	//[2] Pass data from A2 to D6
	int inputValue = 0;
	inputValue = analogRead(2);
	analogWrite(6, inputValue);
	
}
