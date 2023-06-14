pragma solidity ^0.8.0;

import "@openzeppelin4.9.0/contracts/token/ERC20/ERC20.sol";

contract AstriaToken is ERC20 {
    constructor() ERC20("Astria", "RIA") {
        _mint(msg.sender, 1000000000000000000000000000);
    }
}
