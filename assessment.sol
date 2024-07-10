// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract RailwayBooking {
    struct Ticket {
        address passenger;
        uint256 seatNumber;
        bool isBooked;
    }

    address public owner;
    uint256 public ticketPrice;
    uint256 public totalSeats;
    uint256 public bookedSeats;
    mapping(uint256 => Ticket) public tickets;

    constructor(uint256 _totalSeats, uint256 _ticketPrice) {
        owner = msg.sender;
        totalSeats = _totalSeats;
        ticketPrice = _ticketPrice;
        bookedSeats = 0;
    }

    // Function to book a ticket
    function bookTicket(uint256 seatNumber) public payable {
        // Ensure the ticket price is paid
        require(msg.value == ticketPrice, "Incorrect ticket price");

        // Ensure the seat number is valid
        require(seatNumber > 0 && seatNumber <= totalSeats, "Invalid seat number");

        // Ensure the seat is not already booked
        require(!tickets[seatNumber].isBooked, "Seat already booked");

        // Book the seat
        tickets[seatNumber] = Ticket(msg.sender, seatNumber, true);
        bookedSeats++;

        // Assert that the seat is booked
        assert(tickets[seatNumber].isBooked);
    }

    // Function to cancel a ticket
    function cancelTicket(uint256 seatNumber) public {
        // Ensure the seat number is valid
        require(seatNumber > 0 && seatNumber <= totalSeats, "Invalid seat number");

        // Ensure the seat is booked
        require(tickets[seatNumber].isBooked, "Seat not booked");

        // Ensure the caller is the one who booked the seat
        require(tickets[seatNumber].passenger == msg.sender, "Not the ticket owner");

        // Cancel the booking
        tickets[seatNumber].isBooked = false;
        bookedSeats--;

        // Refund the ticket price
        payable(msg.sender).transfer(ticketPrice);

        // Revert if the seat is still booked after cancellation
        if (tickets[seatNumber].isBooked) {
            revert("Ticket cancellation failed");
        }
    }

    // Function to get the total booked seats
    function getBookedSeats() public view returns (uint256) {
        return bookedSeats;
    }

    // Function to withdraw all funds by the owner
    function withdrawFunds() public {
        // Ensure only the owner can withdraw funds
        require(msg.sender == owner, "Only the owner can withdraw funds");

        // Transfer the balance to the owner
        uint256 amount = address(this).balance;
        payable(owner).transfer(amount);
    }
}
