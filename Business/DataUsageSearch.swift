//
//  Created by La Hy Tai on 4/23/20.
//

import RxSwift
import ObjectMapper

final class DataUsageSearch: DataUsageSearchType {
    init(network: NetworkType) {
        self.network = network
    }
    
    func getDataUsage() -> Observable<ResponseEntity> {
        let url = Config.apiURL
        let parameters = [
            Config.resourceId_key: Config.resourceId,
            ] as [String : Any]
        
        return Observable.create { [weak self] (observer) -> Disposable in
            guard let self = self else {
                observer.onError(NetworkError.Unknown)
                return Disposables.create()
            }
            
            return self.network.requestJSON(url: url, parameters: parameters)
                .timeout(RxTimeInterval.milliseconds(3000), scheduler: MainScheduler.instance)
                .subscribe(onNext: { (json) in
                    if let response = Mapper<ResponseEntity>().map(JSONObject: json)
                    {
                        observer.onNext(response)
                        return
                    }
                    
                    observer.onError(NetworkError.IncorrectDataReturned)
                }, onError: { (e) in
                    observer.onError(e)
                })
        }
    }
    
    // MARK: - private variables
    
    private let network: NetworkType
    private let disposeBag = DisposeBag()
}
