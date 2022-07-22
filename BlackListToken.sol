// SPDX-License-Identifier: MIT
pragma solidity ^0.8.15;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract BlackListToken is ERC20, Ownable {
    uint256 public immutable finalTotalSupply = 10000 * 10**decimals();
    uint256 public immutable presaleMaxSupply = 1000 * 10**decimals();  // 10% from FTS
    uint256 public presaleTotalCounter = 0;                             // 0 < presaleTotalCounter < presaleMaxSupply
    uint256 public presaleStartPrice = 0.0001 ether;                    // cost1 for 1 * 10 ** decimals()
    bool private isPresaleStarted = false;                              // false/true
    mapping(address => bool) public userBlacklist;                      // 0 - nothing, 1 - white, 2 - black

    constructor() ERC20("BlackListToken", "BLT") {}

    function buyOnPresaleNotFromBlackList() public payable {
        require(
            isPresaleStarted,
            "Presale has not started yet or has already ended!"
        );

        require(!isBlacklisted(msg.sender), "User from blacklist!");

        uint256 cost = presaleTotalCounter==0 ? presaleStartPrice : (presaleTotalCounter/100*presaleStartPrice);

        uint256 amount = (msg.value * 10**decimals()) / cost;
        require(amount > 0, "Too little value!");

        uint256 newSupply = totalSupply() + amount;
        require(newSupply <= finalTotalSupply, "Final supply reached!");

        presaleTotalCounter += amount;
        require(
            presaleTotalCounter <= presaleMaxSupply,
            "Final presale supply reached!"
        );

        _mint(msg.sender, amount);
    }

    function changePresaleStatus(bool status) public onlyOwner {
        isPresaleStarted = status;
    }

    function mint(address to, uint256 amount) public onlyOwner {
        uint256 newSupply = totalSupply() + amount * 10**decimals();
        require(newSupply <= finalTotalSupply, "Final supply reached!");
        _mint(to, amount * 10**decimals());
    }

    function isBlacklisted(address _user) public view returns (bool) {
        return userBlacklist[_user];
    }

    function addToBlackList(address _user) public onlyOwner {
        userBlacklist[_user] = true;
    }

    function removeFromBlackList(address _user) public onlyOwner {
        userBlacklist[_user] = false;
    }

    function _beforeTokenTransfer(
        address from,
        address to,
        uint256 amount
    ) internal virtual override(ERC20) {
        super._beforeTokenTransfer(from, to, amount);
        require(!isBlacklisted(from), "User from is blacklisted!");
        require(!isBlacklisted(to), "User to is blacklisted!");
    }

    function withdraw() public onlyOwner {
        (bool os, ) = payable(owner()).call{value: address(this).balance}("");
        require(os);
    }
}
