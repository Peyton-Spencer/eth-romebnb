// SPDX-License-Identifier: MIT
pragma solidity >=0.8.19;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";

/// @notice The Day Marketplace contract.
contract DayPlace is ERC1155 {
    // mapping (uint256 => uint256) public
    // OwnerHub

    /// @notice This is the time period for which the rate is charged.
    enum RatePeriod {
        DAILY,
        HOURLY
    }

    uint256 public constant DAYS_TOKEN_FT = 0 << 128;
    uint256 public constant PROPERTY_TOKEN_NFT = 1 << 128;
    uint256 public constant STAY_TOKEN_NFT = 2 << 128;
    uint128 public propertyTokenNftIndex = 1;

    struct PropertyMetadata {
        address owner;
        RatePeriod period;
        uint256 ratePerPeriod;
        uint256 securityDeposit;
        /// @notice map of unix timestamps to availability
        /// @dev days start at midnight UTC (12:00 AM)
        bytes calendar;
    }

    mapping(uint256 => PropertyMetadata) public metadataByPropertyID;
    Stay[][] public staysByPropertyID;

    constructor(string memory uri_) ERC1155(uri_) { }

    struct Stay {
        address[] guests;
        uint256 propertyID;
        uint256 startTime;
        uint256 endTime;
    }

    function mintProperty() external {
        bytes memory data;
        _mint(msg.sender, PROPERTY_TOKEN_NFT + propertyTokenNftIndex, 1, data);
        propertyTokenNftIndex++;
    }

    function mintDaysForProperty(uint256 propertyID, uint256 dayCount) external { }

    // function _ownerOf(uint256 propertyID) {
    //     balanceOf(msg.sender, propertyID);
    // }
}
