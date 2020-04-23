//
//  Created by La Hy Tai on 4/23/20.
//

public protocol DataUsageCellModelType {
    var year: UInt64 { get }
    var usage: Double { get }
    var isDecrease : Bool { get }
    
    static func isDecrease(_ records: [RecordEntity]) -> Bool
}

