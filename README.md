# EVM-Verilog
This project is a Verilog-based design of an Electronic Voting Machine (EVM) with 3 contestants representing 3 different parties. The design includes multiple key features such as vote confirmation, a maximum vote limit of 127 per contestant, and the ability to declare a winner based on the vote count. The project also includes a testbench that generates a waveform for verification using EPWave or other waveform viewers.

Key Features
1. Vote Confirmation Mechanism:
Each vote is counted only after the voter confirms their choice using a confirm_vote signal. This helps prevent unintentional votes or multiple votes being counted for a single action.
2. Enable/Disable Voting:
The voting process can be enabled or disabled using the enable_vote signal. When disabled, no votes can be cast, ensuring that the voting period is controlled.
3. Maximum Vote Limit:
Each contestant can receive a maximum of 127 votes (7-bit counter). If the maximum is reached, no further votes are accepted for that contestant, and a max_votes flag is raised for that contestant.
4. Winner Declaration:
At the end of the voting process, the contestant with the highest number of votes is declared the winner. The result is displayed using a 2-bit signal:
2'b01 - Contestant A is the winner.
2'b10 - Contestant B is the winner.
2'b11 - Contestant C is the winner.
2'b00 - No winner or tie.
5. Waveform Generation for Simulation:
The testbench generates a .vcd (Value Change Dump) file that can be viewed using waveform viewers like EPWave or GTKWave. This helps in verifying the functionality and performance of the EVM.
6. Multiple Voting Sessions and Flexibility:
The EVM design can handle multiple voting sessions. The design is flexible and can be modified for larger numbers of contestants or different voting rules.


Design Components:

Voting Machine Module (voting_machine.v):
Implements the logic for casting, confirming, and counting votes.
Tracks the vote counts for each contestant and checks for the maximum limit.
Declares the winner based on the final vote counts.

Testbench (voting_machine_tb.v):
Simulates various voting scenarios, including vote confirmation, voting for multiple contestants, and the maximum vote limit.
Generates a waveform (voting_machine.vcd) for debugging and visualization.


Advantages of This Design:
Reliability and Accuracy: The vote confirmation mechanism ensures that votes are accurately counted, preventing accidental or unauthorized votes.
Control and Flexibility: Voting can be enabled or disabled as needed, and the design can be extended to accommodate more contestants or customized voting rules.
Maximum Vote Protection: Each contestant has a maximum vote limit (127 in this case), ensuring that no contestant exceeds this limit, providing robustness in the voting process.
Waveform-Based Verification: The generated waveforms allow for detailed analysis and debugging of the voting process during the design and testing phases.
Modular and Expandable: The design is modular, making it easy to expand to handle more contestants or different voting rules with minimal modifications.
