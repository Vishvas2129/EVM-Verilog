// Code your design here
module voting_machine (
    input clk,                   // Clock signal
    input reset,                 // Reset signal
    input enable_vote,           // Enable voting signal
    input vote_A,                // Vote for contestant A
    input vote_B,                // Vote for contestant B
    input vote_C,                // Vote for contestant C
    input confirm_vote,          // Confirm vote signal
    output reg [6:0] votes_A,    // 7-bit vote count for contestant A (0-127)
    output reg [6:0] votes_B,    // 7-bit vote count for contestant B (0-127)
    output reg [6:0] votes_C,    // 7-bit vote count for contestant C (0-127)
    output reg max_votes_A,      // Max votes reached for A
    output reg max_votes_B,      // Max votes reached for B
    output reg max_votes_C,      // Max votes reached for C
    output reg [1:0] winner      // 2-bit winner declaration (00 = None, 01 = A, 10 = B, 11 = C)
);

// Internal signals to track pending votes
reg pending_vote_A, pending_vote_B, pending_vote_C;

// Initialize vote counts and winner signal
always @(posedge clk or posedge reset) begin
    if (reset) begin
        votes_A <= 7'd0;         // Reset contestant A votes to 0
        votes_B <= 7'd0;         // Reset contestant B votes to 0
        votes_C <= 7'd0;         // Reset contestant C votes to 0
        max_votes_A <= 0;        // Max votes not reached for A
        max_votes_B <= 0;        // Max votes not reached for B
        max_votes_C <= 0;        // Max votes not reached for C
        winner <= 2'b00;         // No winner at start
        pending_vote_A <= 0;
        pending_vote_B <= 0;
        pending_vote_C <= 0;
    end 
    else if (enable_vote) begin  // Enable voting
        // Set pending votes based on inputs
        if (vote_A && votes_A < 7'd127) begin
            pending_vote_A <= 1;
        end
        if (vote_B && votes_B < 7'd127) begin
            pending_vote_B <= 1;
        end
        if (vote_C && votes_C < 7'd127) begin
            pending_vote_C <= 1;
        end

        // Confirm vote and update the vote counts
        if (confirm_vote) begin
            if (pending_vote_A) begin
                votes_A <= votes_A + 1;
                pending_vote_A <= 0;
            end
            if (pending_vote_B) begin
                votes_B <= votes_B + 1;
                pending_vote_B <= 0;
            end
            if (pending_vote_C) begin
                votes_C <= votes_C + 1;
                pending_vote_C <= 0;
            end
        end

        // Check if maximum votes have been reached for any contestant
        if (votes_A == 7'd127) begin
            max_votes_A <= 1;
        end
        if (votes_B == 7'd127) begin
            max_votes_B <= 1;
        end
        if (votes_C == 7'd127) begin
            max_votes_C <= 1;
        end
    end
end

// Declare the winner after voting is done
always @(posedge clk or posedge reset) begin
    if (reset) begin
        winner <= 2'b00; // No winner at reset
    end else begin
        // Determine the winner when voting ends
        if (votes_A > votes_B && votes_A > votes_C) begin
            winner <= 2'b01;  // Contestant A wins
        end else if (votes_B > votes_A && votes_B > votes_C) begin
            winner <= 2'b10;  // Contestant B wins
        end else if (votes_C > votes_A && votes_C > votes_B) begin
            winner <= 2'b11;  // Contestant C wins
        end else begin
            winner <= 2'b00;  // No clear winner or tie
        end
    end
end

endmodule
