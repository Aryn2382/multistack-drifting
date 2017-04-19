--in MultiStack.adb 
--package for UseMultiStack

with Ada.Text_IO; use Ada.Text_IO;
package body MultiStack is

   Stack : array (min..max) of Names := (others => Names'Last); -- Main Stack AKA StackSpace
   Base  : array (1..n+1) of integer; -- Base Array
   Top   : array (1..n) of integer; -- Top Array
  
--   type OneArray is array(1..n+1) of integer; -- memory optimization pass
--   OldTop : OneArray;

   OldTop : array(1..n) of integer;

-- Space Optimization:  The arrays OldTop, Growth, and Newbase can occupy the same physical 
-- space (OneArray): OldTop[J] = Growth[J-1] = Newbase[J] for 1 <= J <= N + 1. 
-- Once values from OldTop and Growth are used to calculate a newbase the oldtop value 
-- is no longer required. 

   package NameIO is new Ada.Text_IO.Enumeration_IO(Names); use NameIO;
   package IIO is new Ada.Text_IO.integer_IO(integer);
   use IIO;
   package FIIO is new Ada.Text_IO.Float_IO(Float);
   use FIIO;

   procedure Push( stkNum : integer; Value : Names) IS -- Push operation + Overflow Check
   begin
      -- I put this here to read the entire stack array hope is the second to last value to 
      -- be pushed into the array.
      
                  for j in base(1)+1..base(base'Last) loop
                     put("Location" & Integer'Image(j) & " is ");
                     put((stack(j)));
                     New_Line;
                     
                  end loop;
                  New_line;         

            Top(stkNum) := Top(stkNum) + 1;
            if Top(stkNum) > Base(StkNum + 1) then
               Put_Line("Overflow Detected, attempting to reallocate memory...");
                ReAllocate(stkNum, Value);
            else
               Stack(Top(stkNum)) := Value;
            end if;
         end Push;

 -- Pop Operation + Underflow Check
         procedure Pop(stkNum: integer; Value : out Names) is
            begin
            if Top(stkNum) = Base(stkNum) then
                  Put("Underflow Detected, Terminating Deletion.");
            else
               Value := Stack(top(stkNum));
               top(stkNum) := Top(Stknum) - 1;
            end if;
         end Pop;

-- Reallocate Operation + Movestack
     procedure ReAllocate( stkNum : in integer; Value : Names) is
           
            availSpace : integer := base(base'Last) - base(base'First);
            j : integer := base'Last-1; -- stack #s.
            TotalInc : integer := 0;
            sigma, tau, alpha, beta : Float := 0.0;
            equalAllocate : Float := 0.15;
            growthAllocate : float := 0.85;
            --minSpace : integer := Integer(Float'Ceiling(0.05 * float(AvailSpace)));
            minSpace : integer := 0;
            diff : integer := 0;
            temp : integer := n;

            --Growth : OneArray;
            --newBase : OneArray;
            growth : array(1..n) of integer;
            newbase : array(1..n) of integer;

         begin
                                
           -- Reallocate Algorithm from hymnal
           -- ReA1
           
           --J := n; --deprecated assignment
               
            totalInc := 0;
            Put("Current values of top, oldtop, and base:");
            New_Line;
            for i in 1..n loop
                  put("Top(");put(i,1);Put(") : "); put(top(i),1);
                  put(" , oldTop(");put(i,1);Put(") : "); put(oldTop(i),1);
                  put(" , Base(");put(i,1);Put(") : "); put(base(i),1);
                  New_Line;
            end loop;

               while J > 0 loop
                  Availspace := Availspace - (Top(j) - Base(j));
                  if Top(j) > oldTop(j) then
                     Growth(j) := Top(j) - oldTop(j);
                     TotalInc := TotalInc + Growth(j);
                  else
                     Growth(j) := 0;
               end if;
                  j := j-1;
               end loop;
            --ReA2
            New_Line;
            
            put("Available Space: " & Integer'Image(Availspace)); 
            put(" and minspace:" & Integer'Image(Minspace));
            
               if Availspace < (Minspace - 1) then
            
                  Put("Not Enough Memory for repacking, halting...");
                  New_Line;
                  
                  for j in base(1)+1..base(base'Last) loop
                     put("Location" & Integer'Image(j) & " is ");
                     put((stack(j)));
                     New_Line;
--                               
                  end loop;
                  
                  raise Program_Error;
               end if;
            --ReA3
               Alpha := equalAllocate * Float(Availspace);
               Alpha := float(alpha) / float(n);
               New_Line;
               Beta := GrowthAllocate * Float(Availspace);
               Beta := float(beta) / Float(TotalInc);

               newBase(1) := base(1);
               Sigma := 0.0;

               for J in 2..N loop
                  Tau := Sigma + Alpha + (float(Growth(J-1)) * Beta);
                  newBase(j):=newBase(j-1)+(top(j-1)-base(j-1)) + Integer(float'floor(tau)) - Integer(float'floor(sigma));
                  Sigma := Tau;
               end loop;

               Top(stkNum) := Top(stkNum) - 1;
         --MoA1               
               for j in 2..N loop
                  if newBase(j) < base(j) then
                        diff := base(j) - newBase(j);
                     for i in integer range(base(j) + 1)..(top(j)) loop
                           Stack(i - diff) := stack(i);
                        end loop;
                        base(j) := newBase(j);
                        top(j) := top(j) - diff;
                     end if;
                  end loop;
          
          --Moa2
               for j in reverse 2..N loop
                  if newBase(j) > Base(j) then
                     diff := newbase(j) - base(j);
                     for i in reverse integer range(top(j)-1)..(base(j)+1) loop
                        stack(i + diff) := stack(i);
                     end loop;
                     base(j) := newbase(j);
                     top(j) := top(j) + diff;
                  end if;
               end loop;

            top(stkNum) := Top(stkNum) + 1;
            Stack(Top(stkNum)) := value;
            Put("Setting up for next possible overflow, listing new base and top--");
            New_Line;
            for J in 1..N loop
               Put("Stack : "); put(j,1);
                  Put(" Base "); put(j,1); put(" : "); put(base(j),1);
                  Put(" ,Top "); put(j,1); put(" : "); put(top(j),1);
                  New_Line;
                  oldTop(J) := Top(J);
               end loop;

         end ReAllocate;

      begin
         Put("Stacks Initialized.");
         for j in 1..n+1 loop -- Initialize Top/Base
            if J = n + 1 then
               Base(n+1) := m;
            else
            Base(j) := integer(float'floor(float((j-1))/float(n)*float(m)))+l;
               Top(j) := Base(j);
               oldTop(j) := top(j);
            New_Line;
            Put("Stack Num: "); put(j,1); put(", Base: "); put(base(j),1); put(" , Top: "); put(top(j),1);
            end if;
            end loop;
         New_Line;
         

end MultiStack;