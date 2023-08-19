// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.16;

import "forge-std/Test.sol";
import "../src/show/Show.sol";
import "../src/show/types/ShowTypes.sol";

contract ShowTest is Test {
    Show public show;

    string constant name = "Test Show";
    string constant description = "A test show description";
    address[] artists;
    ShowTypes.Venue venue;
    uint256 constant sellOutThreshold = 50;
    uint256 constant totalCapacity = 1000;
    ShowTypes.TicketPrice ticketPrice;

    function setUp() public {
        // Initialize the Show contract here
        show = new Show();

        // Set up artists
        artists = new address[](1);
        artists[0] = address(this);

        // Set up venue
        venue = ShowTypes.Venue("Test Venue", "40.730610,-73.935242", 100, totalCapacity);

        // Set up ticket price
        ticketPrice = ShowTypes.TicketPrice(1 ether, 2 ether);
    }

    function testProposeShow() public {
        bytes32 proposalId = show.proposeShow(name, description, artists, venue, sellOutThreshold, totalCapacity, ticketPrice);

        // Create the expected proposal ID by hashing the relevant parameters
        bytes32 expectedProposalId = keccak256(abi.encodePacked(name, description, artists, sellOutThreshold, totalCapacity));

        assertEq(proposalId, expectedProposalId, "Proposal ID mismatch");

        // Retrieve show details
        (
        string memory retrievedName,
        string memory retrievedDescription,
        address retrievedOrganizer,
        address[] memory retrievedArtists,
        ShowTypes.Venue memory retrievedVenue,
        ShowTypes.TicketPrice memory retrievedTicketPrice,
        uint256 retrievedSellOutThreshold,
        uint256 retrievedTotalCapacity,
        ShowTypes.Status retrievedStatus,
        bool retrievedIsActive
        ) = show.getShowDetails(proposalId);

        // Assert show details
        assertEq(retrievedName, name, "Name mismatch");
        assertEq(retrievedDescription, description, "Description mismatch");
        assertEq(retrievedOrganizer, address(this), "Organizer mismatch");
        assertEq(retrievedArtists[0], artists[0], "Artists mismatch");
        assertEq(retrievedVenue.name, venue.name, "Venue name mismatch");
        assertEq(retrievedVenue.location, venue.location, "Venue location mismatch");
        assertEq(retrievedVenue.radius, venue.radius, "Venue radius mismatch");
        assertEq(retrievedVenue.totalCapacity, venue.totalCapacity, "Venue total capacity mismatch");
        assertEq(retrievedTicketPrice.minPrice, ticketPrice.minPrice, "Min ticket price mismatch");
        assertEq(retrievedTicketPrice.maxPrice, ticketPrice.maxPrice, "Max ticket price mismatch");
        assertEq(retrievedSellOutThreshold, sellOutThreshold, "Sell-out threshold mismatch");
        assertEq(retrievedTotalCapacity, totalCapacity, "Total capacity mismatch");
        assertEq(uint(retrievedStatus), uint(ShowTypes.Status.Proposed), "Status mismatch");
        assertTrue(retrievedIsActive, "Show should be active");
    }
}
