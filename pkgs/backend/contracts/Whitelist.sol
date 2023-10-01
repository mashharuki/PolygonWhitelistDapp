// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.4;

/**
 * Whitelist Contract
 */
contract Whitelist {
    // The address that can operate addAddressToWhitelist function
    address public owner;
    
    // Create a mapping of whitelistedAddresses
    // if an address is whitelisted, we would set it to true, it is false by default for all other addresses.
    mapping(address => bool) private _isWhitelisted;

    //Event: record the addresses added to the whitelist
    event AddToWhitelist(address indexed account);
    //Event: record whitelisted excluded addresses
    event RemoveFromWhitelist(address indexed account);

    /**
     * コンストラクター
     */
    constructor(address[] memory initialAddresses) {
        owner =msg.sender;
        for (uint256 i = 0; i < initialAddresses.length; i++) {
            addToWhitelist(initialAddresses[i]);
        }
    }

    /**
     * ホワイトリストに追加するためのメソッド
     */
    function addToWhitelist(address _address) public {
        // Check if the user is the owner
        require(owner == msg.sender, "Caller is not the owner");
        // Check if the user has already been whitelisted
        require(!_isWhitelisted[_address], "Address already whitelisted");
        // Add the address which called the function to the whitelistedAddress array
        _isWhitelisted[_address] = true;
        // Triggers AddToWhitelist event
        emit AddToWhitelist(_address);
    }

    /**
     * 指定したアドレスをホワイトリストから除外するためのメソッド
     */
    function removeFromWhitelist(address _address) public {
        // Check if the user is the owner
        require(owner == msg.sender, "Caller is not the owner");
        // Check if the user has not already been whitelisted    
        require(_isWhitelisted[_address], "Address not in whitelist");
        // Remove the address which called the function to the whitelistedAddress array
        _isWhitelisted[_address] = false;
        // Triggers RemoveFromWhitelist event
        emit RemoveFromWhitelist(_address);
    }

    /**
     * 指定したアドレスがホワイトリストに含まれているかどうかをチェックするメソッド
     */
    function whitelistedAddresses(address _address) public view returns (bool) {
        return _isWhitelisted[_address];
    }
}