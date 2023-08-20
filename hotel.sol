//SPDX-License-Identifier:MIT
pragma solidity ^0.8.1;

contract HotelStatus {
    address payable public owner;

    enum HotelSta {
        vacant,
        occupied
    }

    HotelSta public currentStatus;

    constructor() {
        owner = payable(msg.sender);
        currentStatus = HotelSta.vacant;
    }

    modifier onlyWhileVacant() {
        require(currentStatus == HotelSta.vacant, "not vacant");
        _;
    }

    modifier cost(uint _amount) {
        require(msg.value >= _amount, "not enough");
        _;
    }

    function roomBooking() public payable onlyWhileVacant cost(2 ether) {
        owner.transfer(msg.value);

        currentStatus = HotelSta.occupied;
    }
}
