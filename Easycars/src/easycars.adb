package body Easycars with SPARK_Mode is

   procedure StartCar is
   begin
      BatMobile.Ignition := On;
   end StartCar;

   procedure KeyIn is
   begin
      BatMobile.CarKey := Present;
   end KeyIn;

end Easycars;
