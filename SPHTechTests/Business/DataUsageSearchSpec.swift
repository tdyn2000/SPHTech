//
//  Created by La Hy Tai on 4/23/20.
//

import Quick
import Nimble
import RxSwift
@testable import SPHTech

class DataUsageSearchSpec: QuickSpec {
    class stubNormalNetwork : NetworkType {
        func requestJSON(url: String, parameters: [String : Any]?) -> Observable<Any> {
            return Observable.create { (observer) -> Disposable in
                observer.onNext(ResponeJSON)
                observer.onCompleted()
                return Disposables.create()
            }
        }
    }
    
    class stubIncorrectDataNetwork : NetworkType {
        func requestJSON(url: String, parameters: [String : Any]?) -> Observable<Any> {
            return Observable.create { (observer) -> Disposable in
                observer.onNext("")
                observer.onCompleted()
                return Disposables.create()
            }
        }
    }
    
    class stubErrorNetwork : NetworkType {
        func requestJSON(url: String, parameters: [String : Any]?) -> Observable<Any> {
            return Observable.create { (observer) -> Disposable in
                observer.onError(NetworkError.Unknown)
                return Disposables.create()
            }
        }
    }
    
    override func spec() {
        var dataUsageSeach: DataUsageSearch?
        
        it("DataUsageSearch Success"){
            dataUsageSeach = DataUsageSearch(network: stubNormalNetwork())
            var response: ResponseEntity?
            dataUsageSeach?.getDataUsage().subscribe(onNext: { (ResponseEntity) in
                response = ResponseEntity
            }).disposed(by: self.disposeBag)
            
            expect(response).notTo(beNil())
            expect(response?.success).to(equal(true))
            expect(response?.total).to(equal(1))
            expect(response?.records.count).to(equal(2))
        }
        
        describe("DataUsageSearch Error"){
            it("Error data"){
                dataUsageSeach = DataUsageSearch(network: stubIncorrectDataNetwork())
                var error: NetworkError?
                var response: ResponseEntity?
                
                dataUsageSeach?.getDataUsage().subscribe(onNext: { (ResponseEntity) in
                    response = ResponseEntity
                }, onError: { (Error) in
                    error = Error as? NetworkError
                }).disposed(by: self.disposeBag)
                
                expect(response).to(beNil())
                expect(error).notTo(beNil())
                expect(error) == NetworkError.IncorrectDataReturned
            }
            it("Error Network"){
                dataUsageSeach = DataUsageSearch(network: stubErrorNetwork())
                var error: NetworkError?
                var response: ResponseEntity?
                
                dataUsageSeach?.getDataUsage().subscribe(onNext: { (ResponseEntity) in
                    response = ResponseEntity
                }, onError: { (Error) in
                    error = Error as? NetworkError
                }).disposed(by: self.disposeBag)
                
                expect(response).to(beNil())
                expect(error).notTo(beNil())
                expect(error) == NetworkError.Unknown
            }
        }
    }
    
    private let disposeBag = DisposeBag()
}
