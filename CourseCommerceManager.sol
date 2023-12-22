// SPDX-License-Identifier: MIT
pragma solidity ^0.8.22;

// library CourseCommerceLibrary {
// }

contract CourseCommerceManager {
    address payable public owner;
    uint256 public numberSales;
    Product[] public allCourses;
    Sale[] public allSales;

    struct Product {
        uint256 id;
        address productAddress;
        string name;
        uint256 price;
    }

    struct Sale {
        string name;
        uint256 purchaseDate;
        address buyer;
    }

    Product englishCourse =
        Product({
            id: 24810,
            productAddress: 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4,
            name: "English Course",
            price: 1 ether
        });

    Product italianCourse =
        Product({
            id: 36912,
            productAddress: 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4,
            name: "Italian Course",
            price: 1 ether
        });

    modifier onlyOwner() {
        require(owner == msg.sender);
        _;
    }

    event saleAdded(string name, uint256 purchaseDate, address buyer);

    constructor() {
        owner = payable(msg.sender);
        allCourses.push(englishCourse);
        allCourses.push(italianCourse);
    }

    function withdraw() public payable onlyOwner {
        uint256 contractBalance = address(this).balance;
        require(contractBalance > 0, "Nothing to withdraw");
        owner.transfer(contractBalance);
    }

    function buyCourse(uint256 _idCourse) public payable {
        bool productFound = false;

        for (uint256 i = 0; i < allCourses.length; i++) {
            if (allCourses[i].id == _idCourse) {
                productFound = true;
                require(msg.value >= allCourses[i].price, "Insufficient funds");
                numberSales++;

                uint256 excessAmount = msg.value - allCourses[i].price;
                if (excessAmount > 0) {
                    payable(msg.sender).transfer(excessAmount);
                }

                allSales.push(
                    Sale({
                        name: allCourses[i].name,
                        purchaseDate: block.timestamp,
                        buyer: msg.sender
                    })
                );
                emit saleAdded(allCourses[i].name, block.timestamp, msg.sender);
                break;
            }
        }

        require(productFound, "ID course not found");
    }

    function addNewProduct(
        uint256 _idProduct,
        address _addressProduct,
        string memory _nameProduct,
        uint256 _priceProduct
    ) public onlyOwner {
        allCourses.push(
            Product({
                id: _idProduct,
                productAddress: _addressProduct,
                name: _nameProduct,
                price: _priceProduct
            })
        );
    }

    function searchId(uint256 _idProduct) public view returns (string memory) {
        for (uint256 i = 0; i < allCourses.length; i++) {
            if (allCourses[i].id == _idProduct) {
                return allCourses[i].name;
            }
        }
        revert("ID product not found");
    }

    function checkPurchase(address _addressBuyer) public view returns (string[] memory) {
        string[] memory purchase = new string[](allSales.length);

        for(uint256 i = 0; i < allSales.length; i++) {
            if(allSales[i].buyer == _addressBuyer) {
                purchase[i] = allSales[i].name;
            }
        }  
        require(purchase.length > 0, "This address does buy anithings");
        return purchase;
    }
}
