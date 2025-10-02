// top_ex1_4.sv - ex1_4用トップレベル記述

//! トップレベル記述
module top_ex1_4(
    input logic[9:0] SW, //! スイッチ入力
    output logic[6:0] HEX0_n //! 7セグメントLED出力
  );

  // 正論理用の信号
  logic[6:0] hex0; // 7セグメントLED出力
  assign HEX0_n = ~hex0;

  // ex1_4の回路
  ex1_4 target(
          .d(SW[7:0]),
          .y(hex0)
        );
endmodule
