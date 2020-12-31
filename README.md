# Auction-System---Solidity

Smart contract on Ethereum for auction functionality

To run this you require - Node v8.9.4 or later, Truffle (can be installed with npm install -g truffle,providing a development environment), and Ganache ( a personal blockchain that allows developers to create smart contracts)

To run,

truffle compile

truffle migrate

Make sure ports are configured properly in truffle-config.js and in the Ganache consoles respectively

Create objects instance and accounts let instance = await Auction.deployed()

let accounts = await web3.eth.getAccounts()

you can call the bid functionalities in the smart contract solidity code (for eg: instance.bid({from: accounts[2],value: web3.utils.toWei('3','ether')} )
