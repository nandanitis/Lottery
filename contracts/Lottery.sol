// SPDX-License-Identifier: MIT
pragma solidity ^0.8.11;

contract Lottery{
    address public owner;
    address payable[] public players;
    uint public lotteryId;
    mapping(uint => address payable) public lotteryHistory; 
    mapping(address => bool ) public playerCheck;

    constructor(){
        owner=msg.sender;
    }

    function getWinnerByHistory(uint _lotteryId) public view returns(address payable) {
        return lotteryHistory[_lotteryId];
    }

    function enter() public payable {
        require(msg.value == 0.1 ether);
        require(msg.sender != owner, "Owner Cannot Particpate in the Lottery ");
        players.push(payable(msg.sender));
        playerCheck[msg.sender]=true;
    }

    function getBalance() public view returns (uint){
        return address(this).balance;
    }

    function getPlayers() public view returns (address payable[] memory){
        return players;
    }

    function getRandomNumber() public view returns (uint){
        return uint(keccak256(abi.encodePacked(owner, block.timestamp)));
    }

    function pickWinner() public onlyOwner {
        uint index = getRandomNumber() % players.length;
        players[index].transfer(address(this).balance);
        lotteryHistory[lotteryId]= players[index];
        lotteryId++;

        // reset the state of the  contract //
        players = new address payable[](0);
    }

    modifier onlyOwner(){
        require(msg.sender == owner);
        _;
    }
}