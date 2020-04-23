//
//  Created by La Hy Tai on 4/23/20.
//

import Quick
import Nimble
import RxSwift
@testable import SPHTech

class HomeViewControllerModelSpec: QuickSpec {
    class stubDataUsageSearch : DataUsageSearchType {
        func getDataUsage() -> Observable<ResponseEntity> {
            return Observable.create { (observer) -> Disposable in
                observer.onNext(dummyResponse)
                observer.onCompleted()
                return Disposables.create()
            }
        }
    }
    
    class stubDataUsageSearchEmpty : DataUsageSearchType {
        func getDataUsage() -> Observable<ResponseEntity> {
            return Observable.create { (observer) -> Disposable in
                observer.onNext(emptyResponse)
                observer.onCompleted()
                return Disposables.create()
            }
        }
    }
    
    class stubDataUsageSearchError : DataUsageSearchType {
        func getDataUsage() -> Observable<ResponseEntity> {
            return Observable.create { (observer) -> Disposable in
                observer.onError(NetworkError.Unknown)
                observer.onCompleted()
                return Disposables.create()
            }
        }
    }
    
    class stubDataUsageSearchErrorData : DataUsageSearchType {
        func getDataUsage() -> Observable<ResponseEntity> {
            return Observable.create { (observer) -> Disposable in
                observer.onNext(errorResponse)
                observer.onCompleted()
                return Disposables.create()
            }
        }
    }
    
    override func spec() {
        it("success records") {
            let viewModel = HomeViewControllerModel(dataUsageSearch: stubDataUsageSearch())
            var isLoading = false
            var errorMessage = ""
            var cellModes = [DataUsageCellModelType]()
            
            viewModel.getDataUsage()
            viewModel.isLoading.asObservable()
                .subscribe(onNext: { (loading) in
                    isLoading = loading
                }).disposed(by: self.disposeBag)
            
            viewModel.errorMessage.subscribe(onNext: { (error) in
                errorMessage = error
            }).disposed(by: self.disposeBag)
            
            viewModel.cellModels.asObservable()
                .subscribe(onNext: { (models) in
                    cellModes = models
                }).disposed(by: self.disposeBag)
            
            expect(isLoading).to(beFalse())
            expect(errorMessage) == ""
            expect(cellModes.count).toEventually(equal(3))
            expect(cellModes[0].year) < cellModes[1].year
        }
        it("empty records") {
            let viewModel = HomeViewControllerModel(dataUsageSearch: stubDataUsageSearchEmpty())
            var isLoading = false
            var errorMessage = ""
            var cellModes = [DataUsageCellModelType]()
            
            viewModel.getDataUsage()
            viewModel.isLoading.asObservable()
                .subscribe(onNext: { (loading) in
                    isLoading = loading
                }).disposed(by: self.disposeBag)
            
            viewModel.errorMessage.subscribe(onNext: { (error) in
                errorMessage = error
            }).disposed(by: self.disposeBag)
            
            viewModel.cellModels.asObservable().subscribe(onNext: { (models) in
                cellModes = models
            }).disposed(by: self.disposeBag)
            
            expect(isLoading).to(beFalse())
            expect(errorMessage) == ""
            expect(cellModes.count) == 0
        }
        describe("Error"){
            it("error exception") {
                let viewModel = HomeViewControllerModel(dataUsageSearch: stubDataUsageSearchError())
                var isLoading = false
                var errorMessage = ""
                var cellModes = [DataUsageCellModelType]()
                
                viewModel.getDataUsage()
                viewModel.isLoading.asObservable()
                    .subscribe(onNext: { (loading) in
                        isLoading = loading
                    }).disposed(by: self.disposeBag)
                
                viewModel.errorMessage
                    .subscribe(onNext: { (error) in
                        errorMessage = error
                    }).disposed(by: self.disposeBag)
                
                viewModel.cellModels.asObservable().subscribe(onNext: { (models) in
                    cellModes = models
                }).disposed(by: self.disposeBag)
                
                expect(isLoading).to(beFalse())
                expect(errorMessage).to(equal("Unknown Error. Please check again."))
                expect(cellModes.count) == 0
            }
            it("error data") {
                let viewModel = HomeViewControllerModel(dataUsageSearch: stubDataUsageSearchErrorData())
                var isLoading = false
                var errorMessage = ""
                var cellModes = [DataUsageCellModelType]()
                
                viewModel.getDataUsage()
                viewModel.isLoading.asObservable()
                    .subscribe(onNext: { (loading) in
                        isLoading = loading
                    }).disposed(by: self.disposeBag)
                
                viewModel.errorMessage.subscribe(onNext: { (error) in
                    errorMessage = error
                }).disposed(by: self.disposeBag)
                
                viewModel.cellModels.asObservable().subscribe(onNext: { (models) in
                    cellModes = models
                }).disposed(by: self.disposeBag)
                
                expect(isLoading).to(beFalse())
                expect(errorMessage) == ""
                expect(cellModes.count) == 0
            }
        }
    }
    
    private let disposeBag = DisposeBag()
}
