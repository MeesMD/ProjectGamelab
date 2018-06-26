class Timer { 
 float lasttimecheck = millis();
 boolean timeEnd = false;
 float interval = 0;
 
 void timeDec() 
 {
   
   if(millis() > lasttimecheck + interval) 
   {
     lasttimecheck = millis();
     timeEnd = true;
     interval = random(1000, 2000);
   }
   else 
   {
     timeEnd = false;
   }
 }
}
