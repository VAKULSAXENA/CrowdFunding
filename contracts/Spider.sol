// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract Spider is ERC20, Ownable {
    constructor() ERC20("Spider", "SP") {}

    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }
}
