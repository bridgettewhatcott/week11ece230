
module top(

input [3:0]sw,
input btnC,
output[5:0]led
);

dFlipFlop dFlip(
    .D(sw[0]),
    .store(btnC),
    .Q(led[0]),
    .NotQ(led[1])
);

jkFlipFlop jkFlip(
    .J(sw[1]),
    .K(sw[2]),
    .store(btnC),
    .Q(led[2]),
    .NotQ(led[3])
);

tFlipFlop tFlip(
    .T(sw[3]),
    .store(btnC),
    .Q(led[4]),
    .NotQ(led[5])
);
endmodule

module dFlipFlop (
    input D,
    input store,
    output reg Q, 
    output NotQ
);

    always @(posedge store)begin
        if(store)
            Q<=D;
        end
     assign NotQ = ~Q;
endmodule

module jkFlipFlop (
input J, K, store, D,
output Q,
output NotQ
);

assign D = (J&~Q)|(~K&Q);

dFlipFlop flip_inst(
    .D(D),
    .store(store),
    .Q(Q),
    .NotQ(NotQ)
);

endmodule

module tFlipFlop (
input T, store,
output reg Q,
output NotQ
);
    always @(posedge store)begin
        if(T)
            Q<=~Q;
    end
    assign NotQ=~Q;

endmodule