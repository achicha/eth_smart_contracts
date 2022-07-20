const { ethers, upgrades } = require("hardhat");

const PROXY = "0x1Fb76BE42eBBbBBEcc01fF4b480F53Ce9590FC13";

async function main() {
    const MyERC20UpgradebleV3 = await ethers.getContractFactory("MyERC20UpgradebleV3");
    console.log("Upgrading MyERC20Upgradeble...");
    await upgrades.upgradeProxy(PROXY, MyERC20UpgradebleV3);
    console.log("MyERC20Upgradeble upgraded");
}

main();