//
//  Created by La Hy Tai on 4/23/20.
//

import RxSwift
import RxCocoa

protocol HomeViewControllerModelType {
    var cellModels: Driver<[DataUsageCellModelType]> { get }
    var isLoading: Driver<Bool> { get }
    var errorMessage: BehaviorRelay<String> { get }
    
    func getDataUsage()
    func mapToDataUsageCellViewModels(records:[RecordEntity]) -> [DataUsageCellModelType]
}
