/*There are 40 cards of 4 colors RED,BLUE,GREEN,YELLOW and numbered from 0-9. I would like to pick set of 7 cards comprising of 2 sets.
Set 1 has to have a minimum of 3 cards in sequence. Cards have to be of the same color.
Set 2 has to have a minimum of 3 cards. Cards have to be of the same number but different color.*/
 

typedef enum {BLUE, GREEN, RED, YELLOW} colors_e;
typedef enum {zero, one, two, three, four, five, six, seven, eight, nine} numbers_e;
 
class cards;
  rand numbers_e number[7][2];
  rand colors_e color[7][2];
  rand int locOne;
  rand int locTwo;
  constraint locGen_c
  {
    locOne inside {[0:3]};
    locTwo inside {[0:3]};
  }
  
  constraint set1_c
  {
    foreach(color[i,j])
    {
      if(i==locOne && j==0)
      {
        color[i][j]==color[i+1][j];
        color[i][j]==color[i+2][j];
      }
    }
  }
  constraint set2_c
  {
    foreach(number[i,j])
    {
      if(i==locTwo && j==1)
      {
        number[i][j]==number[i+1][j];
        number[i][j]==number[i+2][j];
        color[i][j]!=color[i+1][j];
        color[i][j]!=color[i+2][j];
      }
    }
  }
  function void post_randomize();
    $display("Set One");
    for(int i=0;i<7;i++)
      $display("%s, %s",color[i][0].name(),number[i][0].name());
      $display("\nSet Two");
    for(int i=0;i<7;i++)
        $display("%s, %s",color[i][1].name(), number[i][1].name());
  endfunction
endclass
 
cards c = new;
 
module top;
  initial
    begin
      repeat(10)
        c.randomize();
    end
endmodule
