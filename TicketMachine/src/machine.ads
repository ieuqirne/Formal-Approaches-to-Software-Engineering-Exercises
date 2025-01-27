package Machine
with SPARK_Mode
is

   type Tickets is range 0..1000;
   serving : Tickets := 0;
   next : Tickets := 1;

   function Invariant return Boolean is
      (serving <= next);


   procedure takeTicket with
     Global => (In_Out => next, Input => serving),
     Pre => next < Tickets'Last and then Invariant,
     Post => Invariant;

   procedure serveCustomer with
     Global => (In_Out => serving, Input => next),
     Pre => serving < next and then Invariant,
     Post => Invariant and serving = serving'Old + 1;

   procedure returnTicket (k : Tickets) with
     Global => (In_Out => next, Input => serving),
     Pre => serving < next and then Invariant,
     Post => Invariant;
end Machine;
