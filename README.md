
# BitDex

BitDex is a cryptocurrency app built using Flutter and Dart that allows you to view real-time prices of various cryptocurrencies. The app uses the CoinMarketCap API to fetch the latest market data, and displays it in a clean and easy-to-understand format.
## Features

- Real-time data: BitDex pulls data from the CoinMarketCap API every few seconds to ensure that you always have the latest market information.

- Multiple cryptocurrencies: The app supports a wide range of cryptocurrencies, so you can keep track of your favorite coins and tokens.

- Clean UI: BitDex features a sleek and modern design that is both easy on the eyes and easy to navigate.

- Light and Dark mode: The app offers both light and dark modes, so you can choose the look that works best for you.

## API Reference

This section provides detailed information on how the BitDex app integrates with the CoinMarketCap API. We've included documentation on how to authenticate with the API, how to structure requests, and how to handle responses.
Authentication

- To authenticate with the CoinMarketCap API you'll need to sign up for an account and obtain an API key. Once you have your API key, you can use it to authenticate your requests. We recommend storing your API key as an environment variable to keep it secure.
Request Structure

- To fetch data from the CoinMarketCap API, you'll need to structure your requests according to the API's documentation. The API supports a variety of endpoints for fetching different types of data, such as price data, volume data, and market cap data. You can structure your requests using query parameters to filter the results according to your needs.
Response Handling

- Once you've made a request to the API, you'll receive a response in JSON format. The response will contain the data you requested, as well as any metadata about the request itself. You'll need to parse the response in your app to extract the data you need and display it to the user. We recommend using a JSON parsing library, such as dart:convert, to handle the response data.
## How To Use?

To get started with BitDex, simply clone the repository and run it in Flutter. You will also need to create an account with CoinMarketCap and obtain an API key, which you can then use to fetch market data.
## Contribution

If you would like to contribute to BitDex, please feel free to submit a pull request. I am always looking for ways to improve the app and make it even more useful for cryptocurrency enthusiasts.
## Authors

- [@abhinav0915](https://www.github.com/abhinav0915)

BitDex was created by Abhinav Saxena. Special thanks to the developers of Flutter and Dart, as well as the team at CoinMarketCap for providing the API that powers the app.
