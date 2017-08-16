pragma solidity ^0.4.15;

import "./StandardToken.sol";

library SafeMath {
  function mul(uint256 a, uint256 b) internal constant returns (uint256) {
    uint256 c = a * b;
    assert(a == 0 || c / a == b);
    return c;
  }

  function div(uint256 a, uint256 b) internal constant returns (uint256) {
    // assert(b > 0); // Solidity automatically throws when dividing by 0
    uint256 c = a / b;
    // assert(a == b * c + a % b); // There is no case in which this doesn't hold
    return c;
  }

  function sub(uint256 a, uint256 b) internal constant returns (uint256) {
    assert(b <= a);
    return a - b;
  }

  function add(uint256 a, uint256 b) internal constant returns (uint256) {
    uint256 c = a + b;
    assert(c >= a);
    return c;
  }
}

contract RSVPToken is StandardToken {
    
    //create tokens that represent meetup tickets
    //a way to redeem them, 
    //notify organizer that token has been redeemed 
    //a way to transfer tickets between holders
    //a way to initially sell tickets
    
    
     string public name;                   
    uint8 public decimals = 0;    
    uint UnsoldTickets;
    mapping (address => bool) admitted;
    
    function RSVPToken(  uint256 _initialAmount,
        string _tokenName) {
        balances[msg.sender] = _initialAmount;               // Give the creator all initial tokens
        totalSupply = _initialAmount;                        // Update total supply
        name = _tokenName;                                   // Set the name for display purposes
        UnsoldTickets = _initialAmount;         
    }
    
    function () payable {
        uint256 TicketsBought = SafeMath.div(msg.value,100000000000000000);
        if (UnsoldTickets < TicketsBought) {throw;}
        balances[msg.sender] += TicketsBought;
        UnsoldTickets -= TicketsBought;
        msg.sender.transfer(SafeMath.sub(msg.value,(TicketsBought*100000000000000000)));
        
    }
    
    function redeem() {
        if(balances[msg.sender] >= 1){
            balances[msg.sender] -= 1;
            admitted[msg.sender] = true;
        } else {
            admitted[msg.sender] = false;
        }
    }
    
      function IsAdmitted(address _owner) constant returns (bool) {
        return admitted[_owner];
    }
    
    
}
