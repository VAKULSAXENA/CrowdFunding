# CROWDFUNDING

This project demonstrates the functioning of how crowdfunding can be achieved by some organization by creating multiple crowdfunding project.

## Installation

Install this project with npm for all dependencies to install(like openzeppelin,hardhat etc.)

```bash

  npm  i

```

## Deployment

After using hardhat compile command mentioned below, first deploy Spider.sol with thirdweb command mentioned below and then deploy Crowdfund with thirdweb command mentioned below as Crowdfund need Spider.sol address while deploying with thirdweb.Through thirdweb we can deploy on any testnet and check the functionality of this project.

```bash

  npx hardhat compile
  npx thirdweb@latest deploy

```
