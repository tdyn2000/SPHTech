//
//  Created by La Hy Tai on 4/23/20.
//

import RxSwift
import RxCocoa

final class HomeViewControllerModel : HomeViewControllerModelType {
    let cellModels: Driver<[DataUsageCellModelType]>
    let isLoading: Driver<Bool>
    let errorMessage = BehaviorRelay<String>(value:"")
    
    fileprivate let items = BehaviorRelay(value: [DataUsageCellModelType]())
    fileprivate let isLoadingVariable = BehaviorRelay(value: false)
    fileprivate let dataUsageSearch: DataUsageSearchType
    fileprivate let disposeBag: DisposeBag = DisposeBag()
    
    init(dataUsageSearch: DataUsageSearchType) {
        self.dataUsageSearch = dataUsageSearch
        cellModels = items.asDriver()
        isLoading = isLoadingVariable.asDriver()
    }
    
    func getDataUsage() {
        isLoadingVariable.accept(true)
        
        dataUsageSearch.getDataUsage()
            .map { response in
                self.mapToDataUsageCellViewModels(records: response.records)
        }.subscribe(
            onNext: {[weak self] (models) in
                let _models = models.sorted(by: { $0.year < $1.year })
                self?.items.accept(_models)
                self?.isLoadingVariable.accept(false)
            },
            onError: { [weak self] Error in
                self?.isLoadingVariable.accept(false)
                self?.errorMessage.accept(Error.localizedDescription)
                self?.items.accept([])
        }).disposed(by: disposeBag)
    }
    
    func mapToDataUsageCellViewModels(records:[RecordEntity]) -> [DataUsageCellModelType] {
        return Dictionary(grouping: records.filter({$0.id != 0}), by: { $0.year }).map({ record in
            DataUsageCellModel(_year: record.key, records: record.value)
        })
    }
}
