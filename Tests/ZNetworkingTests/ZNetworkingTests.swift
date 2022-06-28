import XCTest
import Combine
@testable import ZNetworking

final class ZNetworkingTests: XCTestCase {
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(ZNetworking().text, "Hello, World!")
    }
    
    func testDemoAPI() {
        
        let apiKey = "1a9f16555bae86da5fd8d8563f8bf2fff68ac611"
        let baseURL = "api.nomics.com"
        let currencies = "v1/currencies/ticker"
        
        var cancellable = Set<AnyCancellable>()
        
        
        
        let endPoints = Endpoints(host: baseURL)
        let url = endPoints.constructURL(path: currencies, queryItems: [URLQueryItem(name: "key", value: apiKey)])
        print(url)
        let request = endPoints.constructURLRequest(for: url, httpMethod: .GET, header: [:])
        print(request)
        
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
            }
            
            guard let data = data else {
                print("data is nil")
                return
            }
            
            do {
                let welcomeArr = try JSONDecoder().decode(Welcome.self, from: data)
                
                print(welcomeArr)
            } catch {
                print(error.localizedDescription)
            }
            
        }.resume()
        
        
        
        
        
        
        
        
//
//        URLSession.shared.dataTaskPublisher(for: request)
//            .map{ $0.data }
//            .decode(type: Welcome.self, decoder: JSONDecoder())
//            .receive(on: DispatchQueue.main)
//            .sink { response in
//                switch response {
//                case .finished:
//                    print("Data task finished")
//                case .failure(let error):
//                    print(error)
//                }
//            } receiveValue: { welcome in
//                print(welcome)
//            }
//            .store(in: &cancellable)
//
//
        
//        ZAPIManager.shared.fetch(request: request) { (result: Result<WelcomeElement, Error>) in
//            switch result {
//            case .success(let elem):
//                print(elem)
//            case .failure(let error):
//                print(error)
//            }
//        }
    }
}


// MARK: - WelcomeElement
struct WelcomeElement: Codable {
    let currency, id, status, price: String
    let priceDate, priceTimestamp: Date
    let symbol, circulatingSupply, maxSupply, name: String
    let logoURL: String
    let marketCap, marketCapDominance, transparentMarketCap, numExchanges: String
    let numPairs, numPairsUnmapped: String
    let firstCandle, firstTrade, firstOrderBook, firstPricedAt: Date
    let rank, rankDelta, high, highTimestamp: String
    let the1D: The1D

    enum CodingKeys: String, CodingKey {
        case currency, id, status, price
        case priceDate = "price_date"
        case priceTimestamp = "price_timestamp"
        case symbol
        case circulatingSupply = "circulating_supply"
        case maxSupply = "max_supply"
        case name
        case logoURL = "logo_url"
        case marketCap = "market_cap"
        case marketCapDominance = "market_cap_dominance"
        case transparentMarketCap = "transparent_market_cap"
        case numExchanges = "num_exchanges"
        case numPairs = "num_pairs"
        case numPairsUnmapped = "num_pairs_unmapped"
        case firstCandle = "first_candle"
        case firstTrade = "first_trade"
        case firstOrderBook = "first_order_book"
        case firstPricedAt = "first_priced_at"
        case rank
        case rankDelta = "rank_delta"
        case high
        case highTimestamp = "high_timestamp"
        case the1D = "1d"
    }
}

// MARK: - The1D
struct The1D: Codable {
    let priceChange, priceChangePct, volume, volumeChange: String
    let volumeChangePct, marketCapChange, marketCapChangePct, transparentMarketCapChange: String
    let transparentMarketCapChangePct: String
    let volumeTransparency: [VolumeTransparency]

    enum CodingKeys: String, CodingKey {
        case priceChange = "price_change"
        case priceChangePct = "price_change_pct"
        case volume
        case volumeChange = "volume_change"
        case volumeChangePct = "volume_change_pct"
        case marketCapChange = "market_cap_change"
        case marketCapChangePct = "market_cap_change_pct"
        case transparentMarketCapChange = "transparent_market_cap_change"
        case transparentMarketCapChangePct = "transparent_market_cap_change_pct"
        case volumeTransparency = "volume_transparency"
    }
}

// MARK: - VolumeTransparency
struct VolumeTransparency: Codable {
    let grade, volume, volumeChange, volumeChangePct: String

    enum CodingKeys: String, CodingKey {
        case grade, volume
        case volumeChange = "volume_change"
        case volumeChangePct = "volume_change_pct"
    }
}

typealias Welcome = [WelcomeElement]
