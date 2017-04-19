--in multistack.ads

generic

   N : integer;
   M : integer;
   L : integer;
   min : integer;
   max : integer;
   type Names is ( <> );
   
package MultiStack is
   
   --function Floor( x : Float) return integer;
   
   procedure Push( stkNum : integer; Value : Names);
   procedure Pop( stkNum : integer; Value : out Names);
   procedure ReAllocate( stkNum : in integer; Value : Names);

end MultiStack;