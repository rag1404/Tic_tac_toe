// Code your testbench here
// or browse Examples
// Tic Tac toe game


// Assume we have 2 players and then in a 3x3 matrix, each player has to place a number in the matrix. 0 represent none of them played, 1 represents player 1 and -1 represents player 2.

class tic_tac_toe;
  rand int b[3][3] ;
 
  
  
  typedef enum bit [1:0] {player1, player2, draw} result_type_t;
  
  rand result_type_t result_type;
 
  //Then we want to set the value for each space. X can be represented by 1, O can be represented by -1, and 0 means space is not yet filled. We can have the first constraint to make sure the value of each space is either -1, 0, or 1.
  constraint c {foreach (b[i,j])
  {(b[i][j]) inside {[-1:1]};}
               }
    
    
    constraint c3 {
      result_type dist {player1:=4, player2:=4, draw := 2};
        }
    
    //We arbitrarily use X as the firsthand player. This means at any given time, the sum of array b is either 0, after both players have played, or 1, only X has played. This will give us the second constraint that the sum of the array b is either 0 or 1.

    constraint d {
    
      b.sum inside {-1,0,1};
    }
    
    
    constraint e {
    
      (result_type==player1) ->
      (b.sum() with (item.index(1)==0 ? item : 0) == 3) || //row0
      (b.sum() with (item.index(1)==1 ? item : 0) == 3) || //row1
      (b.sum() with (item.index(1)==2 ? item : 0) == 3) || //row2
      (b.sum() with (item.index(2)==0 ? item : 0) == 3) || //col0
      (b.sum() with (item.index(2)==1 ? item : 0) == 3) || //col1
      (b.sum() with (item.index(2)==2 ? item : 0) == 3) || //col2
      (b.sum() with (item.index(1) == item.index(2) ? item : 0) == 3)|| //diag1
      (b.sum() with ((item.index(1) + item.index(2) == 2) ? item : 0) == 3);
      
      //diag2
      
      
      (result_type==player2) ->
      (b.sum() with (item.index(1)==0 ? item : 0) == -3) || //row0
      (b.sum() with (item.index(1)==1 ? item : 0) == -3) || //row1
      (b.sum() with (item.index(1)==2 ? item : 0) == -3) || //row2
      (b.sum() with (item.index(2)==0 ? item : 0) == -3) || //col0
      (b.sum() with (item.index(2)==1 ? item : 0) == -3) || //col1
      (b.sum() with (item.index(2)==2 ? item : 0) == -3) || //col2
      (b.sum() with (item.index(1) == item.index(2) ? item : 0) == -3)|| //diag1
      (b.sum() with ((item.index(1) + item.index(2) == 2) ? item : 0) == -3);
      
      (result_type==draw) -> (!(b.sum inside {-3,3}));
}
      
    
    
    // 1 1 3
    // 1 3 1
    // 3 1 1
    
 //      constraint c2{ 
 //        b.sum(item1) with (item1.sum(item2) with (int'(item2==1))) == 3;
 // }
    
   
  
endclass
    
    module tb;
      tic_tac_toe a1;
            initial begin
        a1=new();
        repeat (10) begin
        if (!a1.randomize())
          $display ("Randomize Error");
        $display("=============================");
          $display("This is %s", a1.result_type.name());
        $display ("%p",a1.b);
        end
      end
      
      
   endmodule
                
