//
//  Created by La Hy Tai on 4/23/20.
//

import ObjectMapper

public struct ResponseEntity {
    public var total: Int64 = 0
    public var records: [RecordEntity] = []
    public var success: Bool = false
}

extension ResponseEntity: Mappable {
    public init?(map: Map) {}
    
    mutating public func mapping(map: Map) {
        total <- map["result.total"]
        records <- map["result.records"]
        success <- map["success"]
    }
}
