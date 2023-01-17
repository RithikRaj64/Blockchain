// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

contract Test {
    function add(uint256 _x) external returns (uint256) {
        return 100 + _x;
    }

    uint64 public orderCount;

    struct Order {
        uint64 id;
        address producer;
        address holder;
        address consumer;
        bool delivered;
        string status;
        string timestamp;
        //      timestamp
    }

    Order[] public Orders;

    mapping(address => bool) isProducer;
    mapping(address => bool) isMiddleMan;
    // mapping(uint64 => address) orderToConsumer;
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

    function placeOrder(address _consumer, string memory _timestamp)
        external
        ifProducer
    {
        orderCount++;
        Orders.push(
            Order(
                orderCount,
                msg.sender,
                msg.sender,
                _consumer,
                false,
                "Order Accepted",
                _timestamp
            )
        );
        // orderToConsumer[orderCount] = _consumer;
        consumerToOrders[_consumer].push(orderCount);
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

        Orders[_id].delivered = true;
        Orders[_id].status = "Order Has Been Delivered";
        Orders[_id].timestamp = _timestamp;
    }
}
