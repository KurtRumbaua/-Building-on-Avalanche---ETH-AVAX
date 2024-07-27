// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract DegenToken is ERC20, Ownable {
    struct Item {
        string name;
        uint256 basePrice;
        uint256 dynamicPrice;
        uint256 demand; // Added demand to track item popularity
    }

    struct Referral {
        address referrer;
        uint256 reward;
    }

    Item[] public items;
    mapping(address => uint256) public purchaseCount;
    mapping(address => Referral) public referrals;
    mapping(address => uint256) public specialDiscounts;

    event ItemPurchased(address indexed buyer, string itemName, uint256 itemPrice);
    event ReferralReward(address indexed referrer, address indexed referee, uint256 reward);

    constructor(uint256 initialSupply) ERC20("Degen", "DGN") {
        _mint(msg.sender, initialSupply);

        addItem("Sword", 100); // index 0
        addItem("Shield", 150); // index 1
        addItem("Potion", 50); // index 2
    }

    function addItem(string memory name, uint256 price) internal onlyOwner {
        items.push(Item(name, price, price, 0));
    }

    function getItem(uint256 index) public view returns (string memory name, uint256 basePrice, uint256 dynamicPrice, uint256 demand) {
        require(index < items.length, "Item index out of bounds");
        Item storage item = items[index];
        return (item.name, item.basePrice, item.dynamicPrice, item.demand);
    }

    function mint(uint256 amount) public onlyOwner {
        _mint(msg.sender, amount);
    }

    function burn(uint256 amount) public {
        require(amount > 10, "Amount should be greater than 10");
        require(amount <= balanceOf(msg.sender), "Insufficient balance to burn");
        _burn(msg.sender, amount);
    }

    function buyItem(uint256 itemIndex) public {
        require(itemIndex < items.length, "Item index out of bounds");
        Item storage item = items[itemIndex];
        uint256 price = getItemPrice(msg.sender, item);

        require(balanceOf(msg.sender) >= price, "Insufficient balance to buy item");
        _burn(msg.sender, price);

        item.demand += 1;
        adjustItemPrice(itemIndex);
        purchaseCount[msg.sender] += 1;
        emit ItemPurchased(msg.sender, item.name, price);
    }

    function getItemPrice(address buyer, Item memory item) internal view returns (uint256) {
        uint256 price = item.dynamicPrice;

        if (purchaseCount[buyer] >= 5) {
            price = (price * 90) / 100; // 10% discount for frequent buyers
        }

        if (specialDiscounts[buyer] > 0) {
            price = (price * (100 - specialDiscounts[buyer])) / 100;
        }

        return price;
    }

    function adjustItemPrice(uint256 itemIndex) internal {
        Item storage item = items[itemIndex];
        item.dynamicPrice = item.basePrice + (item.demand * 2); // Increase price based on demand
    }

    function referUser(address referee) public {
        require(referee != msg.sender, "Cannot refer yourself");
        require(referrals[referee].referrer == address(0), "User already referred");

        referrals[referee] = Referral(msg.sender, 10); // 10 DGN reward for referrer
        emit ReferralReward(msg.sender, referee, 10);
    }

    function claimReferralReward() public {
        Referral storage referral = referrals[msg.sender];
        require(referral.reward > 0, "No referral reward available");

        uint256 reward = referral.reward;
        referral.reward = 0;

        _mint(referral.referrer, reward);
    }

    function setSpecialDiscount(address user, uint256 discount) public onlyOwner {
        require(discount <= 50, "Discount cannot exceed 50%");
        specialDiscounts[user] = discount;
    }

    function redeemTokens(uint256 amount) public {
        require(amount > 0, "Amount should be greater than 0");
        require(balanceOf(msg.sender) >= amount, "Insufficient balance to redeem tokens");

        // Example logic for redeeming tokens, such as transferring to a designated address
        address redemptionAddress = 0x1234567890123456789012345678901234567890; // Replace with actual address
        _transfer(msg.sender, redemptionAddress, amount);
    }

    function transfer(address to, uint256 amount) public override returns (bool) {
        _transfer(_msgSender(), to, amount);
        return true;
    }
}
