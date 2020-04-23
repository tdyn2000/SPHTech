//
//  Created by La Hy Tai on 4/23/20.
//

import Quick
import Nimble
@testable import SPHTech

class RecordEntitySpec: QuickSpec {
    override func spec() {
        it("2018-Q2") {
            let recordJSON = RecordJSON
            let record: RecordEntity? = RecordEntity.init(JSON: recordJSON)
            
            expect(record).notTo(beNil())
            expect(record?.id).to(equal(56))
            expect(record?.quarter) == "Q2"
            expect(record?.year).to(equal(2018))
            expect(record?.volumeOfMobileData).to(equal(18.47368))
        }
        
        it("empty json") {
            let recordJSON = [String:Any]()
            let record: RecordEntity? = RecordEntity.init(JSON: recordJSON)
            expect(record?.id) == 0
        }
        
        it("Error quarter") {
            let record: RecordEntity? = RecordEntity.init(JSON: ErrorRecordJSON_quarter)
            
            expect(record).notTo(beNil())
            expect(record?.id).to(equal(0))
        }
        
        it("Missing quarter") {
            let record: RecordEntity? = RecordEntity.init(JSON: ErrorRecordJSON_missing)
            
            expect(record).notTo(beNil())
            expect(record?.id).to(equal(0))
        }
        
        it("IncorrectRecordJSON"){
            let record: RecordEntity? = RecordEntity.init(JSON: IncorrectRecordJSON)
            
            expect(record).notTo(beNil())
            expect(record?.id).to(equal(0))
        }
    }
}
