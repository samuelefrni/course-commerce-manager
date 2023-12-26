<div align="center"><img src="/assets/solidity-logo-vector.svg" width="150px"></div>
<br />
<div align="center">
  <h2 align="center">Course Commerce Manager</h2>

  <p align="center">
    <br />
    <a href="https://sepolia.etherscan.io/address/0xd6d9dcca6f610818a360ee26378315391e488ed8"><strong>Contract on the blockchain</strong></a>
    <br />
    <br />
    <a href="./assets/Progetto Smart Contract con Solidity di Samuele Furnari.pdf">Presentation IT</a>
  </p>
</div>

## Introduction

IncluDO is a startup that creates inclusive online courses, real professional training paths for migrants and disadvantaged people to include them in the world of work.

To launch his latest courses, he decides to create an e-commerce site. To do this, they entrust you with the creation of a smart contract to record sales within their site.

The project involves the creation of a smart contract in Solidity that regulates the entire sales process.

## About the project

Create a CourseCommerceManager.sol file, with the following characteristics:

1. Address of the contract owner
2. A structure containing a product address, name, and price in Ether
3. An array containing all products
4. Total number of sales recorded
5. A structure containing information about a sale, such as product purchased, purchase data, and buyer
6. An array containing all sales
7. Event to track when a new sale is added to the sales array
8. Allow the contract owner to withdraw from the contract balance
9. Add a new product available for sale
10. Return information for a specified product via its identifier
11. Allow a customer to purchase a product and record the sale
12. Return information for a specific sale via its identifier.

Next, publish the smart contract on the blockchain.

Also create a Library in Solidity that allows the following operations, and use it within the CourseCommerceManager.sol contract:

13. Return the products purchased by a specific customer in the form of a data structure
14. Calculate the amount of ether sales given a certain period of time.

## About my choices

The choice of Solidity as the main language for the development of the CourseCommerceManager.sol smart contract was motivated by its specific nature for writing contracts on the Ethereum blockchain. Solidity offers a clear and robust syntax, facilitating the safe and reliable development of autonomous contracts that govern the sales process within our e-commerce site. Additionally, Solidity is widely adopted in the blockchain developer community, ensuring ongoing support and resources available for implementation and maintenance.

The choice to use smart contracts on Ethereum is driven by the robustness and decentralization offered by the Ethereum blockchain. Smart contracts allow secure management of transactions, ensuring transparency and trust in sales and purchase operations. The ability to publish the smart contract on the Ethereum blockchain provides an immutable record of all transactions, increasing the transparency and security of operations.

The choices I have adopted aim to guarantee the security, transparency and scalability of the system, allowing IncluDO to offer inclusive online courses and professional training paths in an effective and accessible way to all.

## Contributing

We welcome contributions! Follow these steps:

1. Fork the repository.
2. Create a new branch.
3. Make your changes.
4. Submit a pull request.

## License

This project is licensed under the [MIT License](https://opensource.org/licenses/MIT)

## Creator

- **Samuele Furnari**
  - Email: samuelefurnari9@gmail.com
  - GitHub: [samuelefrni](https://github.com/samuelefrni)
  - LinkedIn: [Samuele Furnari](https://www.linkedin.com/in/samuele-furnari-a37567220/)
