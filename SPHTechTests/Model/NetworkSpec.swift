//
//  Created by La Hy Tai on 4/23/20.
//

import Quick
import Nimble
import RxSwift
@testable import SPHTech

class NetworkSpec: QuickSpec {
    override func spec() {
        var network: Network!
        beforeEach {
            network = Network()
        }
        
        it("eventually gets JSON data as specified with parameters.") {
            var json: [String: Any]? = nil
            let url = "https://httpbin.org/get"
            network.requestJSON(url: url, parameters: ["a": "b", "x": "y"])
                .subscribe(onNext: {
                    json = $0 as? [String: Any]
                }).disposed(by: self.disposeBag)
            
            expect(json).toEventuallyNot(beNil(), timeout: 5)
            expect((json?["args"] as? [String: AnyObject])?["a"] as? String)
                .toEventually(equal("b"), timeout: 5)
            expect((json?["args"] as? [String: AnyObject])?["x"] as? String)
                .toEventually(equal("y"), timeout: 5)
        }
        
        it("eventually gets an error if the network has a problem.") {
            var error: NetworkError? = nil
            let url = "https://not.existing.server.comm/get"
            network.requestJSON(url: url, parameters: ["a": "b", "x": "y"])
                .subscribe ({ (e) in
                    error = e.error as? NetworkError
                }).disposed(by: self.disposeBag)
            
            expect(error).toEventually(equal(NetworkError.NotReachedServer), timeout: 5)
        }
    }
    
    private let disposeBag = DisposeBag()
}
