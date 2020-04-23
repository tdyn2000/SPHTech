//
//  Created by La Hy Tai on 4/23/20.
//

@testable import SPHTech
let dummyResponse: ResponseEntity = {
    let record0 = RecordEntity(id: 1, quarter: "Q1", year: 2008, volumeOfMobileData: 0.3)
    let record1 = RecordEntity(id: 2, quarter: "Q2", year: 2008, volumeOfMobileData: 0.5)
    let record2 = RecordEntity(id: 3, quarter: "Q1", year: 2010, volumeOfMobileData: 1.2)
    let record3 = RecordEntity(id: 4, quarter: "Q2", year: 2010, volumeOfMobileData: 3.4)
    let record4 = RecordEntity(id: 5, quarter: "Q1", year: 2014, volumeOfMobileData: 3.2)
    let record5 = RecordEntity(id: 6, quarter: "Q2", year: 2014, volumeOfMobileData: 6.0)
    return ResponseEntity(total: 6, records: [record0,record1,record2,record3,record4,record5], success: true)
}()

let emptyResponse: ResponseEntity = {
    return ResponseEntity(total: 0, records: [], success: true)
}()

let errorResponse: ResponseEntity = {
    let record0 = RecordEntity(id: 0, quarter: "Q1", year: 2009, volumeOfMobileData: 0.3)
    let record1 = RecordEntity(id: 0, quarter: "Q2", year: 2008, volumeOfMobileData: 0.5)
    return ResponseEntity(total: 2, records: [record0,record1], success: true)
}()
