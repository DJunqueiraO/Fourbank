import Foundation
import Alamofire

protocol ApiViewModel {
    
    func networkCoins(completion: @escaping (([Rates],[String])?, Error?) -> Void)
}

extension ApiViewModel {
    
    func networkCoins(completion: @escaping (([Rates],[String])?, Error?) -> Void) {
        
        let baseURL = "https://rest.coinapi.io/v1/"
        let apiKey = "30C2E940-B534-4E6B-8BE1-2E20AA28F25F"
        let usd = "USD"
        
        let url = "\(baseURL)exchangerate/\(usd)?invert=true&apikey=\(apiKey)"
        
        AF.request(url).responseJSON {response in
            
            if let data = response.data {
                
                do {
                    let result: Coins = try JSONDecoder().decode(Coins.self, from: data)
                    
                    let coinArray: [String] = ["BTC",
                                               "ETH",
                                               "USDT",
                                               "XRP",
                                               "ADA",
                                               "DOGE",
                                               "LTC",
                                               "DASH"]
                    var ratesArray: [Rates] = []
                    
                    for coin in coinArray {
                        
                        let selectedCoin = result.rates.filter {$0.asset_id_quote == coin}
                        if selectedCoin.count > 0 {
                            
                            ratesArray.append(selectedCoin[0])
                        }
                    }
                    
                    completion((ratesArray,coinArray), nil)
                }
                catch {
                    
                    completion(nil, error)
                }
            }
        }
    }
}
