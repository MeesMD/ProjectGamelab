class Timer {
 float startTimer = 2000; 
 float lasttimecheck = millis();
 
 void timeDec() 
 {
   if(millis() > lasttimecheck + startTimer) 
   {
     lasttimecheck = millis();
   }
 }
 
 
 
}
