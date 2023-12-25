// SPDX-License-Identifier: MIT
pragma solidity ^0.8.22;

library CourseCommerceLibrary {
    struct Purchase {
        string name;
    }

    function getPurchase(
        address _customer,
        CourseCommerceManager.Sale[] storage _allSales
    ) internal view returns (Purchase[] memory) {
        uint256 count = 0;
        for (uint256 i = 0; i < _allSales.length; i++) {
            if (_allSales[i].buyer == _customer) {
                count++;
            }
        }

        Purchase[] memory purchases = new Purchase[](count);
        count = 0;
        for (uint256 i = 0; i < _allSales.length; i++) {
            if (_allSales[i].buyer == _customer) {
                purchases[count] = Purchase(_allSales[i].name);
                count++;
            }
        }

        return purchases;
    }

    function getEtherAmount(
        uint256 _initialPurchaseDate,
        uint256 _finalPurchaseDate,
        CourseCommerceManager.Sale[] storage _allSales
    ) internal view returns (uint256) {
        require(
            _initialPurchaseDate < _finalPurchaseDate,
            "Initial purchase date must be greater than the final purchase date"
        );
        uint256 totalEtherAmount = 0;

        for (uint256 i = 0; i < _allSales.length; i++) {
            if (
                _allSales[i].purchaseDate >= _initialPurchaseDate &&
                _allSales[i].purchaseDate <= _finalPurchaseDate
            ) {
                totalEtherAmount += 1 ether;
            }
        }
        return totalEtherAmount;
    }
}

contract CourseCommerceManager {
    address public owner;
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
            id: 2468,
            productAddress: 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4,
            name: "English Course",
            price: 5000000 gwei
        });

    Product italianCourse =
        Product({
            id: 36912,
            productAddress: 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4,
            name: "Italian Course",
            price: 5000000 gwei
        });

    modifier onlyOwner() {
        require(
            owner == msg.sender,
            "You don't have the permission to execute this function!"
        );
        _;
    }

    event saleAdded(string name, uint256 purchaseDate, address buyer);

    event etherAmountFromTo(
        uint256 startTime,
        uint256 endTime,
        uint256 saleAmount
    );

    constructor() {
        owner = payable(msg.sender);
        allCourses.push(englishCourse);
        allCourses.push(italianCourse);
    }

    function withdraw(uint256 _amount, address payable _toAddress)
        public
        payable
        onlyOwner
    {
        uint256 contractBalance = address(this).balance;
        require(
            contractBalance >= _amount,
            "You probably don't have the funds to effect this withdraw, check the amount and try again!"
        );
        _toAddress.transfer(_amount);
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

    function searchById(uint256 _idProduct)
        public
        view
        returns (string memory)
    {
        for (uint256 i = 0; i < allCourses.length; i++) {
            if (allCourses[i].id == _idProduct) {
                return allCourses[i].name;
            }
        }
        revert("ID product not found");
    }

    function checkPurchase(address _addressBuyer)
        public
        view
        returns (CourseCommerceLibrary.Purchase[] memory)
    {
        return CourseCommerceLibrary.getPurchase(_addressBuyer, allSales);
    }

    function getSalesEtherAmountFromDate(
        uint256 _initialPurchaseDate,
        uint256 _finalPurchaseDate
    ) public returns (uint256) {
        uint256 totalEtherAmount = CourseCommerceLibrary.getEtherAmount(
            _initialPurchaseDate,
            _finalPurchaseDate,
            allSales
        );

        emit etherAmountFromTo(
            _initialPurchaseDate,
            _finalPurchaseDate,
            totalEtherAmount
        );

        return totalEtherAmount;
    }

    function searchSaleByPurchaseDate(uint256 _purchaseDate, address _buyer)
        public
        view
        returns (string memory)
    {
        string memory sale;

        for (uint256 i = 0; i < allSales.length; i++) {
            if (
                allSales[i].purchaseDate == _purchaseDate &&
                allSales[i].buyer == _buyer
            ) {
                sale = allSales[i].name;
            }
        }

        return sale;
    }
}
