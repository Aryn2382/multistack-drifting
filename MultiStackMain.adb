with Ada.Text_IO, MultiStack;
use Ada.Text_IO;

procedure MultiStackMain IS
   package IIO is new Ada.Text_IO.Integer_IO(integer);
   use IIO;
   --array generation input 
   low : integer;
   high : integer;
   
   --Stack setup
   n : integer;
   m : integer;
   l : integer;

begin
   put("Enter the lower bound for the array: ");
   get(low);
   put("Enter the upper bound for the array: ");
   get(high);
   put("Enter the lower bound for the stacks: ");
   get(L);
   put("Enter the Upper Bound for the stacks: ");
   Get(M);
   put("Enter the number of stacks to allocate in array: ");
   get(n);

   declare
      type Names is (Pop, Push, Switch, Burris, Zhou, Shashidhar, Shannon, Yang, 
                     Smith, Wei, Rabieh, Song, Cho, Varol, Karabiyik, Cooper, 
                     McGuire, Najar, An, Deering, Hope, Pray, NoHope, Empty);
      --Empty is a value to populate the portions that are simply not used of the ENTIRE set for debugging        
      package Stack is new MultiStack(n,m,l,low,high, Names ); use Stack;
      package NameIO is new Ada.Text_IO.Enumeration_IO(Names); use NameIO;
      Temp : Names := pop;
      stkNum : integer;

   begin
   -- I1 Burris, I2 Zhou, I2 Shashidhar, I3 Shannon, I1 Yang, I3 Smith, D2, I1 Wei, 
   -- I2 Rabieh, D1, D1, I2 Song, I2 Cho, D3, I2 Varol, I3 Karabiyik, I1 Cooper, I1 Smith, 
   -- I1 McGuire , I3 Najar, I2 An, I1 Zhou, D2,  I2 Deering, I1 Burris, I2 Cho, I2 McGuire, 
   -- I3 Hope, I3 Pray, I3 NoHope
   
            push(1,Burris); push(2,Zhou); push(2,Shashidhar); push(3,Shannon); push(1,Yang); 
            push(3,Smith); pop(2,Temp); push(1,Wei);
            push(2,Rabieh); pop(1,Temp); pop(1,Temp); push(2,Song); push(2,Cho); pop(3,temp);
            push(2,Varol); push(3,Karabiyik); push(1,Cooper); push(1,Smith);
            push(1,McGuire); push(3,Najar); push(2,An); push(1,Zhou); pop(2,temp);
            push(2,Deering); push(1,Burris); push(2,Cho); push(2,McGuire);
            push(3,Hope);            push(3,Pray);            push(3,NoHope);

-- The following section is for user input, also for testing and debugging purposes. 

      loop 
      put("Select Stack Number: ");
      loop
      Get(stkNum);
         if stkNum < 1 or stkNum > n then
            put("Incorrect Stack, try again: ");
            end if;
         exit when (Stknum >= 1 AND Stknum <= n);
      end loop;
      put("Enter a name to enter into stack "); put(stkNum,1); put(" , or"); New_Line;
         put("enter pop to pop out of stack "); put(stkNum,1); put(" , or enter SWITCH to switch stacks");
         loop
            New_Line;
            put("Input a command: ");
            get(temp);
            exit when temp = switch;
            if temp = pop then
               Pop(StkNum,temp);
               if temp /= pop and temp /= Switch then
                  put("Result of pop on stack ");
                  put(stkNum,1);
                  put(" : "); 
                  put(temp);
                  end if;
            else
               push(stkNum,Temp);
               put("Value: "); put(temp); put(" pushed onto stack: "); put(stkNum,1);
            end if;
      end loop;
      end loop;
      
   end;
end MultiStackMain;