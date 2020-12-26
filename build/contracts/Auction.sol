pragma solidity >0.5.0;

contract Auction {
   
    address payable public beneficiary;

    // Current state of the auction. You can create more variables if needed
    address public highestBidder;
    uint public highestBid;
    bool endOfAuction;
    bool bidFlag;
    // Allowed withdrawals of previous bids
    mapping(address => uint) pendingReturns;

    // Constructor
    constructor() public {
        beneficiary = msg.sender;
    }

    /// Bid on the auction with the value sent
    /// together with this transaction.
    /// The value will only be refunded if the
    /// auction is not won.
    
    function bid() public payable {
        

        require(!endOfAuction, "Auction has ended, New bids cannot be called.Thank you");
        require(
           msg.value > highestBid,
           "You are not the Highest Bidder, There is already Higest Bidder. Bid More"
        );
        bidFlag = true;


        // TODO If the bid is not higher than highestBid, send the
        // money back. Use "require"
        
        // TODO update state

        // TODO store the previously highest bid in pendingReturns. That bidder
        // will need to trigger withdraw() to get the money back.
        // For example, A bids 5 ETH. Then, B bids 6 ETH and becomes the highest bidder. 
        // Store A and 5 ETH in pendingReturns. 
        // A will need to trigger withdraw() later to get that 5 ETH back.
        if (highestBid != 0) {

            pendingReturns[highestBidder] += highestBid;
        }
        highestBidder = msg.sender;
        highestBid = msg.value;

        // Sending back the money by simply using
        // highestBidder.send(highestBid) is a security risk
        // because it could execute an untrusted contract.
        // It is always safer to let the recipients
        // withdraw their money themselves. 
        
    }

    /// Withdraw a bid that was overbid.
    function withdraw() public returns (bool) {
    // TODO send back the amount in pendingReturns to the sender. Try to avoid the reentrancy attack. Return false if there is an error when sending
    
         require(bidFlag, "You cannot use withdraw, before bids are placed ");
        address payable withdrawAccount = msg.sender;
        uint bidAmount = pendingReturns[withdrawAccount];
        if (bidAmount > 0) {
         pendingReturns[withdrawAccount] = 0;

         bool retAmountBol = withdrawAccount.send(bidAmount);
         
         if (!(retAmountBol)) {

                pendingReturns[withdrawAccount] = bidAmount;
              
                return false;
            }
        }
        return true;

        }

    /// End the auction and send the highest bid
    /// to the beneficiary.
    function auctionEnd() public {
        

        // TODO send money to the beneficiary account. Make sure that it can't call this auctionEnd() multiple times to drain money
        require(!endOfAuction, "Auction has ended, auctionEnd() has already been called");

       // TODO make sure that only the beneficiary can trigger this function. Use "require"
        require(beneficiary == msg.sender, "Only  beneficiary can end the auction");


        endOfAuction = true;
      
        beneficiary.transfer(highestBid);
        

        
    }
}
