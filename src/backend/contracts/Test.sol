// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

contract Test {
    uint64 public orderCount;

    struct Order {
        uint64 id;
        address producer;
        address holder;
        address consumer;
        string status;
        string timestamp;
    }

    Order[] public Orders;

    mapping(address => bool) isProducer;
    mapping(address => bool) isMiddleMan;
    mapping(address => uint64[]) consumerToOrders;

    modifier ifProducer() {
        require(isProducer[msg.sender] == true);
        _;
    }

    modifier ifMiddleMan() {
        require(isMiddleMan[msg.sender] == true);
        _;
    }

    function Prod() external view returns (bool) {
        return isProducer[msg.sender];
    }

    function Mid() external view returns (bool) {
        return isMiddleMan[msg.sender];
    }

    function makeProducer() external {
        isProducer[msg.sender] = true;
    }

    function makeMiddleMan() external {
        isMiddleMan[msg.sender] = true;
    }

    function placeOrder(address _producer, string memory _timestamp) external {
        orderCount++;
        Orders.push(
            Order(
                orderCount,
                _producer,
                address(0),
                msg.sender,
                "Placed Order",
                _timestamp
            )
        );
    }

    function acceptOrder(uint64 _id, string memory _timestamp)
        external
        ifProducer
    {
        _id--;
        Orders[_id].holder = msg.sender;
        Orders[_id].status = "Accepted Order";
        Orders[_id].timestamp = _timestamp;
    }

    function passOrder(uint64 _id, string memory _timestamp)
        external
        ifMiddleMan
    {
        _id--;
        Orders[_id].holder = msg.sender;
        Orders[_id].status = "Order Is Being Delivered";
        Orders[_id].timestamp = _timestamp;
    }

    function deliveredOrder(uint64 _id, string memory _timestamp) external {
        _id--;
        require(msg.sender == Orders[_id].consumer);

        Orders[_id].status = "Order Has Been Delivered";
        Orders[_id].timestamp = _timestamp;
    }
}
