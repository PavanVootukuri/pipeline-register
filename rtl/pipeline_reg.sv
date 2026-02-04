module pipeline_reg #(
    parameter int WIDTH = 32
)(
    input  logic              clk,
    input  logic              rst_n,

    input  logic [WIDTH-1:0]  in_data,
    input  logic              in_valid,
    output logic              in_ready,

    output logic [WIDTH-1:0]  out_data,
    output logic              out_valid,
    input  logic              out_ready
);

    logic [WIDTH-1:0] data_q;
    logic             valid_q;

    assign in_ready  = ~valid_q || out_ready;
    assign out_data  = data_q;
    assign out_valid = valid_q;

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            data_q  <= '0;
            valid_q <= 1'b0;
        end else begin
            if (in_valid && in_ready) begin
                data_q  <= in_data;
                valid_q <= 1'b1;
            end else if (out_ready && valid_q) begin
                valid_q <= 1'b0;
            end
        end
    end


// Assertions for verification 

`ifdef ASSERTIONS
  assert property (@(posedge clk)
    disable iff (!rst_n)
    out_valid && !out_ready |=> out_valid
  );

  assert property (@(posedge clk)
    disable iff (!rst_n)
    out_valid && out_ready |-> in_ready
  );

`endif
endmodule






