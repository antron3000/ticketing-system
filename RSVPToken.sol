pragma solidity ^0.4.15;

import "./StandardToken.sol";

//Safe math library to make sure calculations always go right
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

contract RSVPToken {

    //create tokens that represent meetup tickets
    //a way to redeem them,
    //notify organizer that token has been redeemed
    //a way to transfer tickets between holders
    //a way to initially sell tickets


     string public eventName;
    uint8 public decimals = 0;
    uint UnsoldTickets;

    //list of ticket holders
    mapping (address => uint256) public holders;

    //list of admitted event attendees
    mapping (address => bool) admitted;

    //set number of tickets and event name when you deploy the contract
    function RSVPToken(uint _numTickets,
        string _eventName) {
        UnsoldTickets = _numTickets;                        // Update total supply
        eventName = _eventName;                                   // Set the name for display purposes
    }


    //when someone sends ether to the contract, they get tickets! Leftover ether gets sent back.
    function () payable {
        uint256 TicketsBought = SafeMath.div(msg.value,10**17);
        if (UnsoldTickets < TicketsBought) {throw;}
        holders[msg.sender] += TicketsBought;
        UnsoldTickets -= TicketsBought;
        msg.sender.transfer(SafeMath.sub(msg.value,(TicketsBought*10**17)));

    }



    //redeem a ticket to gain entry to the event.
    function redeem() {
        if(holders[msg.sender] >= 1){
            holders[msg.sender] -= 1;
            admitted[msg.sender] = true;
        } else {
            admitted[msg.sender] = false;
        }
    }


    //Check if a particular person's address has been admitted to the event
      function IsAdmitted(address _owner) constant returns (bool) {
        return admitted[_owner];
    }


}
