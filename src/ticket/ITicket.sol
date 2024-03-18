// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

/// @title ITicket
/// @notice Interface for the Ticket contract
interface ITicket {
    /// @notice Emitted when a ticket is purchased
    /// @param buyer Address of the buyer
    /// @param showId ID of the show for which tickets were purchased
    /// @param ticketId ID of the ticket purchased
    /// @param amount Amount of tickets purchased
    /// @param tierIndex Index of the ticket tier from which the tickets were purchased
    event TicketPurchased(address indexed buyer, bytes32 indexed showId, uint256 indexed ticketId, uint256 amount, uint256 tierIndex);

    /// @notice Purchase multiple tickets for a specific show from a specific tier
    /// @param showId ID of the show
    /// @param tierIndex Index of the ticket tier from which to purchase tickets
    /// @param amount Amount of tickets to purchase
    function purchaseTickets(bytes32 showId, uint256 tierIndex, uint256 amount) external payable;

    /// @notice Burns a specific amount of tokens, removing them from circulation
    /// @param tokenId ID of the token to be burned
    /// @param amount Amount of tokens to be burned
    /// @param owner Owner of the tokens being burned
    function burnTokens(uint256 tokenId, uint256 amount, address owner) external;


    /// @notice Sets the URI for a given token ID
    /// @param showId ID of the show for which to set the URI
    /// @param tokenId Token ID for which to set the URI
    /// @param newURI New URI to set for the token
    function setTokenURI(bytes32 showId, uint256 tokenId, string calldata newURI) external;

    /// @notice Sets the default URI for all tokens
    /// @param newDefaultURI New default URI to be set
    /// @param showId ID of the show for which the default URI is set
    function setDefaultURI(string calldata newDefaultURI, bytes32 showId) external;

/// @notice Retrieves the price paid for a specific ticket and its tier index.
/// @param showId The unique identifier of the show.
/// @param ticketId The unique identifier of the ticket.
/// @return price The price paid for the ticket.
/// @return tierIndex The index of the ticket tier.
    function getTicketPricePaidAndTierIndex(bytes32 showId, uint256 ticketId) external view returns (uint256 price, uint256 tierIndex);

}
