pragma solidity >0.4.22;
contract Voting{
    bytes32[] public candidateList;
    mapping(bytes32 => uint8) public votesReceived;
    constructor(bytes32[] memory candiateName) public{
        candidateList = candiateName;
    }
    function validateCandidate(bytes32 candiateName)public returns(bool){
        for(uint8 i=0;i<candidateList.length;i++){
            if(candiateName==candidateList[i]){
                return true;
            }
        }
        return false;
    }
    function vote(bytes32 candiateName)public{
        require(validateCandidate(candiateName));
        votesReceived[candiateName]+=1;
    }
    function totalVotesFor(bytes32 candiateName)public  returns (uint8){
        require(validateCandidate(candiateName));
        return votesReceived[candiateName];
    }
    
}