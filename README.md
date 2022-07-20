# eth_smart_contracts

### hardhat
```shell
cd project_folder

# install
brew install node
npx hardhat # run with all default settings
npx ci      # or install from package-lock.json

# deploy
env $(cat .env) npx hardhat run --network rinkeby scripts/deploy-V1.js
env $(cat .env) npx hardhat verify --network rinkeby 0x1Fb76BE42eBBbBBEcc01fF4b480F53Ce9590FC13
```
### Links:
- [remix IDE](https://remix.ethereum.org/) with plugins: flattener, solidity static analysis
- add ETH to test wallet in [network rinkeby](https://faucets.chain.link/rinkeby)
- [ERC20 templates](https://github.com/OpenZeppelin/openzeppelin-contracts) 
- [ERC20 contracs wizard](https://docs.openzeppelin.com/contracts/4.x/wizard)
- [TransparentUpgradeableProxy contract](https://docs.openzeppelin.com/contracts/4.x/api/proxy#TransparentUpgradeableProxy)