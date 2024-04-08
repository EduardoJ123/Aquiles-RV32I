typedef enum logic[1:0] {
    add = 2'h1,
    sub = 2'h2,
    nop = 2'h0
} op_type;

module alu #(
    parameter WIDTH = 6
)(
    input clk,
    input rst,
    input op_type       op_in,
    input [WIDTH-1:0]   a_in,
    input [WIDTH-1:0]   b_in,
    input               vld,
    output logic[WIDTH-1:0] out,
    output logic            out_vld
);

    op_type op_in_r;
    logic [WIDTH-1:0]   a_in_r;
    logic [WIDTH-1:0]   b_in_r;
    logic               vld_r;
    logic [WIDTH-1:0]   result;

    //Register all inputs
    always_ff @ (posedge clk, posedge rst) begin
        if(rst) begin
            op_in_r  <= nop;
            a_in_r   <= '0;
            b_in_r   <= '0;
            vld_r    <= '0;
        end
        else begin
            op_in_r  <= op_in;
            a_in_r   <= a_in;
            b_in_r   <= b_in;
            vld_r    <= vld;
        end
    end

    //Compute result
    always_comb begin
        result = 0;
        if(vld_r) begin
            case(op_in_r)
                add: result = a_in_r + b_in_r;
                sub: result = a_in_r + (~b_in_r + 1'b1);
                default: $error("Invalid operation");
            endcase
        end
    end

    //Register outputs
    always_ff @ (posedge clk, posedge rst) begin
        if(rst) begin
            out     <= '0;
            out_vld <= '0;
        end
        else begin
            out     <= result;
            out_vld <= vld_r;
        end
    end
    
endmodule
