## RailwayBooking Smart Contract
This smart contract facilitates the booking and cancellation of railway tickets. It ensures secure transactions and maintains a record of booked tickets.

## Features
Book Ticket: Users can book a ticket by paying the specified ticket price.
Cancel Ticket: Users can cancel their booking and get a refund if they own the ticket.
View Booked Seats: Users can view the total number of booked seats.
Withdraw Funds: The owner can withdraw all funds collected from ticket sales.
## Key Concepts
# require
Used to ensure conditions are met before executing the rest of the function.
Example: Ensuring the correct ticket price is paid, seat number is valid, seat is not already booked, and the caller is the ticket owner.
# revert
Used to undo all state changes if a certain condition is not met.
Example: If the seat is still marked as booked after attempting to cancel, the transaction is reverted.
# assert
Used to verify that an internal condition is true. It should only be used to test for conditions that should never occur.
Example: Asserting that a seat is booked after the booking process.
## Functions
constructor(uint256 _totalSeats, uint256 _ticketPrice)
Initializes the contract with the total number of seats and the ticket price. The contract owner is set to the address that deploys the contract.

bookTicket(uint256 seatNumber) public payable
Allows users to book a ticket by paying the ticket price.

Requires the ticket price to be paid.
Requires the seat number to be valid and not already booked.
Books the seat for the caller and increases the count of booked seats.
Asserts that the seat is successfully booked.
cancelTicket(uint256 seatNumber) public
Allows users to cancel their booking and get a refund.

Requires the seat number to be valid and booked.
Requires the caller to be the ticket owner.
Cancels the booking and decreases the count of booked seats.
Refunds the ticket price to the caller.
Reverts if the cancellation fails.
# getBookedSeats() public view returns (uint256)
Returns the total number of booked seats.

# withdrawFunds() public
Allows the contract owner to withdraw all collected funds.

Requires the caller to be the contract owner.
Transfers the contract balance to the owner's address.
