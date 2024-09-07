module voting_machine_tb;

// Declare inputs as registers and outputs as wires
reg clk;
reg reset;
reg enable_vote;
reg vote_A;
reg vote_B;
reg vote_C;
reg confirm_vote;
wire [6:0] votes_A;
wire [6:0] votes_B;
wire [6:0] votes_C;
wire max_votes_A;
wire max_votes_B;
wire max_votes_C;
wire [1:0] winner;

// Instantiate the voting_machine module
voting_machine uut (
    .clk(clk),
    .reset(reset),
    .enable_vote(enable_vote),
    .vote_A(vote_A),
    .vote_B(vote_B),
    .vote_C(vote_C),
    .confirm_vote(confirm_vote),
    .votes_A(votes_A),
    .votes_B(votes_B),
    .votes_C(votes_C),
    .max_votes_A(max_votes_A),
    .max_votes_B(max_votes_B),
    .max_votes_C(max_votes_C),
    .winner(winner)
);

// Clock generation: 10 ns period
always #5 clk = ~clk;

// Test sequence
initial begin
    // Initialize inputs
    clk = 0;
    reset = 1;
    enable_vote = 0;
    vote_A = 0;
    vote_B = 0;
    vote_C = 0;
    confirm_vote = 0;

    // Dump waves for EPWave
    $dumpfile("voting_machine.vcd");  // Specifies the VCD file name
    $dumpvars(0, voting_machine_tb);   // Dumps all variables in the testbench

    // Reset the machine and wait
    #10 reset = 0;
    #10 enable_vote = 1;  // Enable voting

    // Case 1: Vote for A and confirm it
    #10 vote_A = 1; 
    #10 vote_A = 0; 
    #10 confirm_vote = 1; 
    #10 confirm_vote = 0; // Confirm the vote

    // Case 2: Vote for B but do not confirm it
    #10 vote_B = 1;
    #10 vote_B = 0;
    #10 confirm_vote = 0; // No confirmation

    // Case 3: Confirm the vote for B
    #10 confirm_vote = 1;
    #10 confirm_vote = 0;

    // Case 4: Vote for C and confirm it
    #10 vote_C = 1;
    #10 vote_C = 0;
    #10 confirm_vote = 1;
    #10 confirm_vote = 0;

    // End voting
    #50 enable_vote = 0;

    // Finish the simulation and dump waveform
    #100 $finish;
end

// Monitor votes and winner status
initial begin
    $monitor("Time: %0t | votes_A: %d | votes_B: %d | votes_C: %d | max_A: %b | max_B: %b | max_C: %b | Winner: %b", 
             $time, votes_A, votes_B, votes_C, max_votes_A, max_votes_B, max_votes_C, winner);
end

endmodule
