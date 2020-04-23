//
//  Created by La Hy Tai on 4/23/20.
//

import Quick
import Nimble
@testable import SPHTech

class DataUsageCellModelSpec: QuickSpec {
    override func spec() {
        it("empty records") {
            let viewModel = DataUsageCellModel(_year: 2008, records: [])
            expect(viewModel).notTo(beNil())
            expect(viewModel.year) == 2008
            expect(viewModel.usage) == 0
            expect(viewModel.isDecrease) == false
        }
        
        describe("decrease records"){
            it("quarte increase") {
                var record: RecordEntity = RecordEntity.init()
                record.year = 2008
                record.volumeOfMobileData = 0.4
                record.quarter = "Q3"
                
                var recordNext: RecordEntity = RecordEntity.init()
                recordNext.year = 2008
                recordNext.volumeOfMobileData = 0.3
                recordNext.quarter = "Q4"
                
                let viewModel = DataUsageCellModel(_year: 2008, records: [record, recordNext])
                expect(viewModel).notTo(beNil())
                expect(viewModel.year) == 2008
                expect(viewModel.usage).to(beCloseTo(0.7))
                expect(viewModel.isDecrease).to(beTrue())
            }
            it("quarte decrease") {
                var record: RecordEntity = RecordEntity.init()
                record.year = 2006
                record.volumeOfMobileData = 0.1
                record.quarter = "Q4"
                
                var recordNext: RecordEntity = RecordEntity.init()
                recordNext.year = 2006
                recordNext.volumeOfMobileData = 0.2
                recordNext.quarter = "Q3"
                
                let viewModel = DataUsageCellModel(_year: 2006, records: [record, recordNext])
                expect(viewModel).notTo(beNil())
                expect(viewModel.year) == 2006
                expect(viewModel.usage).to(beCloseTo(0.3))
                expect(viewModel.isDecrease).to(beTrue())
            }
        }
        
        describe("increase records"){
            it("quarte increase") {
                var record: RecordEntity = RecordEntity.init()
                record.year = 2020
                record.volumeOfMobileData = 0.4
                record.quarter = "Q1"
                
                var recordNext: RecordEntity = RecordEntity.init()
                recordNext.year = 2020
                recordNext.volumeOfMobileData = 0.8
                recordNext.quarter = "Q2"
                
                let viewModel = DataUsageCellModel(_year: 2020, records: [record, recordNext])
                expect(viewModel).notTo(beNil())
                expect(viewModel.year) == 2020
                expect(viewModel.usage).to(beCloseTo(1.2))
                expect(viewModel.isDecrease).to(beFalse())
            }
            it("quarte decrease") {
                var record: RecordEntity = RecordEntity.init()
                record.year = 2011
                record.volumeOfMobileData = 15
                record.quarter = "Q4"
                
                var recordNext: RecordEntity = RecordEntity.init()
                recordNext.year = 2011
                recordNext.volumeOfMobileData = 10
                recordNext.quarter = "Q3"
                
                let viewModel = DataUsageCellModel(_year: 2011, records: [record, recordNext])
                expect(viewModel).notTo(beNil())
                expect(viewModel.year) == 2011
                expect(viewModel.usage).to(equal(25))
                expect(viewModel.isDecrease).to(beFalse())
            }
        }
    }
}
