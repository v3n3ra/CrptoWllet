

# CrptoWllet

UIKit • MVVM • Dependency Injection • DispatchGroup • Navigation with changing the root VC • UserDefaults • SnapKit

 [Figma](https://www.figma.com/file/HnRjRNfe2DfWYMsiSjkSyH/CryptoWallet?type=design&node-id=0%3A1&t=lyWJzjjt0lzG4l6H-1)

<p>
<img src="https://github.com/v3n3ra/CrptoWllet/blob/main/ScreenShots/Screenshot%202023-05-28%20at%2022.15.44.png" width="600"> <img src="https://github.com/v3n3ra/CrptoWllet/blob/main/ScreenShots/Screen.gif" width="200">
</p>

## Technical Specifications

3 View Controllers

• 1st VC — Authorization: 2 text fields and a button. 
Hardcoded creds are 1234/1234. 
Transitioning to the 2nd VC not through "push VC" but by changing the root VC (in a window or a
navigation controller).

• 2nd VC — Specific coins in a table view displayed only after all of them were fetched. 
Showing spinner while loading.
A button to sort price changes per day or per hour (the list is either ascending or descending).
Transitioning to the 3rd VC after tapping on the cell.

• 3rd VC — Detailed information about the coin. 


Adding a logout button in either 2nd or 3rd VC. Saving the state of authorisation and launching
with the 2nd VC if the user was logged in.

• The network layer:  
API: https://data.messari.io/api/v1/assets/_/metrics;
DispatchGroup;
Coins: btc, eth, tron, polkadot, dogecoin, tether, stellar, cardano, xrp.

• No Storyboards/xib's, no third-party libraries except SnapKit, no MVC architecture.
