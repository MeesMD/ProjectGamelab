class Timer {
 float interval = 2000; 
 float lasttimecheck = millis();
 boolean timeEnd = false;
 
 void timeDec() 
 {
   if(millis() > lasttimecheck + interval) 
   {
     lasttimecheck = millis();
     timeEnd = true;
   }
   else 
   {
     timeEnd = false;
   }
 }
 
   
}
