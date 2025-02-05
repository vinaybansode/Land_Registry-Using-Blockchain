// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
contract VotingSystem {
    // Owner of the contract
    address public owner;
    // Enum representing parties with special numbers
    enum Party {
        BJP,        // 0
        Congress,   // 1
        AamAadmi    // 2
    }
    // Mappings to store votes and voter data
    mapping(Party => uint) public votes;
    mapping(address => uint) public voterAadhar;
    mapping(uint => bool) public aadharHasVoted;
    // Event emitted when a vote is cast
    event Voted(address indexed voter, Party party, uint aadharNumber);
    // Constructor to initialize the contract
    constructor() {
        owner = msg.sender; // Set the contract deployer as the owner
        votes[Party.BJP] = 0;
        votes[Party.Congress] = 0;
        votes[Party.AamAadmi] = 0;
    }
    // Function to cast a vote
    function vote(Party party, uint aadharNumber) public {
        require(!aadharHasVoted[aadharNumber], "This Aadhar number has already voted!");
        // If the voter changes their Aadhar, update the mapping
        if (voterAadhar[msg.sender] != 0) {
            uint oldAadhar = voterAadhar[msg.sender];
            aadharHasVoted[oldAadhar] = false;
        }
        // Record the voter's Aadhar and their vote
        voterAadhar[msg.sender] = aadharNumber;
        votes[party]++;
        aadharHasVoted[aadharNumber] = true;
        // Emit the vote event for transparency
        emit Voted(msg.sender, party, aadharNumber);
    }
    // Function to get the total votes for a specific party
    function getVotes(Party party) public view returns (uint) {
        return votes[party];
    }
    // Individual functions to get votes for each party
    function getBJPVotes() public view returns (uint) {
        return votes[Party.BJP];
    }
    function getCongressVotes() public view returns (uint) {
        return votes[Party.Congress];
    }
    function getAamAadmiVotes() public view returns (uint) {
        return votes[Party.AamAadmi];
    }
    // Function to get the voter's Aadhar number
    function getVoterAadhar() public view returns (uint) {
        return voterAadhar[msg.sender];
    }
}