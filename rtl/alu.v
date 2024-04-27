typedef enum logic[2:0] {
    ADD = 3'h1,
    SUB = 3'h2,
    AND = 3'h3,
    OR  = 3'h4,
    SLT = 3'h5,
    NOP = 3'h0
} op_type_t;

module alu #(
    parameter WIDTH = 32
)(
    input clk,
    input rst,
    input op_type_t     op_in,
    input [WIDTH-1:0]   a_in,
    input [WIDTH-1:0]   b_in,
    output logic[WIDTH-1:0] out
);

    op_type_t op_in_r;
    logic [WIDTH-1:0]   a_in_r;
    logic [WIDTH-1:0]   b_in_r;
    logic [WIDTH-1:0]   result;

    //Register all inputs
    always_ff @ (posedge clk, posedge rst) begin
        if(rst) begin
            op_in_r  <= NOP;
            a_in_r   <= '0;
            b_in_r   <= '0;
        end
        else begin
            op_in_r  <= op_in;
            a_in_r   <= a_in;
            b_in_r   <= b_in;
        end
    end

    //Compute result
    always_comb begin
        result = 0;
        case(op_in_r)
            NOP: //No operation
	    ADD: result = a_in_r + b_in_r;
            SUB: result = a_in_r + (~b_in_r + 1'b1);
	    AND: result = a_in_r & b_in_r;
	    OR: result = a_in_r | b_in_r;
	    SLT: result = a_in_r > b_in_r ? 0 : 1;
            default: $error("Invalid operation");
        endcase
    end

    //Register outputs
    always_ff @ (posedge clk, posedge rst) begin
        if(rst) begin
            out     <= '0;
        end
        else begin
            out     <= result;
        end
    end
    
endmodule
