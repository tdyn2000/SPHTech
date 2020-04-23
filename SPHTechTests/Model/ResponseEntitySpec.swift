//
//  Created by La Hy Tai on 4/23/20.
//

import Quick
import Nimble
@testable import SPHTech

class ResponseEntitySpec: QuickSpec {
    override func spec() {
        it("Parse") {
            let response: ResponseEntity? = ResponseEntity.init(JSON: ResponeJSON)
            
            expect(response).notTo(beNil())
            expect(response?.success).to(equal(true))
            expect(response?.total).to(equal(1))
            expect(response?.records.count).to(equal(2))
            
        }
    }
}
