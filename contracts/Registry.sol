// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;
import "./Comptroller.sol";

contract Registry is Initializable {

    address public landNFT;

    address public estateNFT;

    address public comptroller;

    mapping(address => mapping(uint256 => uint256)) public getEstate;

    function initialize(address _comptroller, address _landNFT, address _estateNFT) public initializer {
        landNFT = _landNFT;
        estateNFT = _estateNFT;
        comptroller = _comptroller;
    }

    modifier isComptroller() {
        require(msg.sender == comptroller, "Not authorized");
        _;
    }

    function canCreateEstate(address _landAddress, uint256[] memory landId, address caller) isComptroller public view {
        require(landId.length >= 2, "Need atleast two land to form an estate");
        for(uint i = 0; i <= landId.length; i++) {
            require(IERC721(_landAddress).ownerOf(landId[i]) == caller);
        }
    }

    function canCreateUnit(address baseNFT, uint256 baseNFTID, address childNFT, bool subUnit) public view {
        Comptroller comp = Comptroller(comptroller);
        require(comp.hasSubUnit(baseNFT,baseNFTID) == subUnit, "No sub unit");
        // check area
    }
}