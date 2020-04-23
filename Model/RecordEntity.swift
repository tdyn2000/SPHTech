//
//  Created by La Hy Tai on 4/23/20.
//

import ObjectMapper

public struct RecordEntity {
    public var id: Int64 = 0
    public var quarter: String = ""
    public var year: UInt64 = 0
    public var volumeOfMobileData: Double = 0
}

extension RecordEntity: Mappable {
    public init?(map: Map) {}
    
    mutating public func mapping(map: Map) {
        var _volumeOfMobileData: String?
        var _quarter: String?
        
        _quarter <- map["quarter"]
        _volumeOfMobileData <- map["volume_of_mobile_data"]
        
        if let _volumeOfMobileData = _volumeOfMobileData {
            volumeOfMobileData = NumberFormatter().number(from: _volumeOfMobileData)!.doubleValue
        }
        
        if let _quarter = _quarter {
            let element = _quarter.split(separator: "-")
            if (element.count == 2){
                year = UInt64((element[0] as NSString).longLongValue)
                quarter = String(element[1])
                id <- map["_id"]
            }
        }
    }
}
