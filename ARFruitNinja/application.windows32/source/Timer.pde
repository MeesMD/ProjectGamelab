class Timer { 
 float lasttimecheck = millis();
 boolean timeEnd = false;
 float begintimer = 3000;
 float interval = 0;
 float interval2 = 0;
 
 
 void timeDec() 
 {
   
   if(millis() > lasttimecheck + begintimer) 
   {
     lasttimecheck = millis();
     timeEnd = true;
      
     if(interval >= 3000 || interval2 >= 4000)
     {
       interval = 3000;
       interval2 = 4000;
     }
  
     begintimer = random(4000-interval,5000-interval2);
   }
   else 
   {
     timeEnd = false;
   }
 }
}
