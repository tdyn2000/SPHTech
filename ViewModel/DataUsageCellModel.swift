//
//  Created by La Hy Tai on 4/23/20.
//

final class DataUsageCellModel : DataUsageCellModelType {
    let year: UInt64
    let usage: Double
    let isDecrease : Bool
    
    init(_year: UInt64, records: [RecordEntity]) {
        year = _year
        isDecrease = DataUsageCellModel.isDecrease(records)
        usage = records.reduce(0){ $0 + $1.volumeOfMobileData }
    }
    
    internal static func isDecrease(_ records: [RecordEntity]) -> Bool{
        if records.count > 0{
            for i in 0..<records.count-1 {
                let record = records[i]
                let recordNext = records[i+1]
                if  (record.quarter < recordNext.quarter) &&
                    (record.volumeOfMobileData > recordNext.volumeOfMobileData){
                    return true
                }
                if  (record.quarter > recordNext.quarter) &&
                    (record.volumeOfMobileData < recordNext.volumeOfMobileData){
                    return true
                }
            }
        }
        return false
    }
}
