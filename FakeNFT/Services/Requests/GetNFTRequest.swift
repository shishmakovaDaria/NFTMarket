import Foundation

struct GetNFTRequest: NetworkRequest {
    let NFTID: String
    var endpoint: URL? {
        Constants.endpoint.appendingPathComponent("/nft/\(NFTID)")
    }
    var httpMethod: HttpMethod { .get }
}
