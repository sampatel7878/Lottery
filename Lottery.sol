pragma solidity >= 0.5.0 < 0.9.0;

contract Lottery {
    address payable[] public players;
    address public manager;
    address demo;
    uint lotteryAmount;
    uint public noOfPlayer;
    uint deadline;
    uint public collectedAmount;
    constructor (uint _lotterAmount, uint _deadline) {
        manager = msg.sender;
        lotteryAmount = _lotterAmount;
        deadline = block.timestamp + _deadline;
    }

    function sendEth()public payable{
        require(block.timestamp <= deadline,"Deadline has passed");
        require(msg.value == lotteryAmount,"Minimum Amount not met");
        players.push(payable(msg.sender));
        collectedAmount += msg.value;
        noOfPlayer++;//just edit
    }
    function currentPoolBalance() view public returns(uint){
        return address(this).balance;
    }

    function pickWinner() public{
        require(msg.sender == manager,"Only manager can call this function");
        require(players.length >= 3,"3 Players required");
        uint random = uint(keccak256(abi.encodePacked(block.difficulty, block.timestamp, players.length)));

        address payable winner;
        uint index = random % players.length;
        winner= players[index];
        winner.transfer(address(this).balance);
    }
}
