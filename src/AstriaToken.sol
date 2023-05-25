pragma solidity ^0.8.0;

import "openzeppelin-contracts/contracts/token/ERC20/ERC20.sol";

contract AstriaToken is ERC20 {
    constructor() ERC20("Astria", "AST") {
        _mint(msg.sender, 1000000000000000000000000000);
    }
}
