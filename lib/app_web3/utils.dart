
enum Coins {
  Ethereum,
  Bitcoin,
  BitcoinSegwit,
  Litecoin,
  LitecoinSegwit,
  Dogecoin,
  Dash,
  Tron,
  EthereumClassic,
  VeChain,
  Ripple,
}

class BlockChains {
  static const ETHEREUM = 'ethereum';
}

double convertWeiToEther(double wei) => wei / 10e17;