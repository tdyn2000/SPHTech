//
//  Created by La Hy Tai on 4/23/20.
//

import UIKit
import RxSwift
import Alamofire

public final class Network: NetworkType {
    
    private let queue = DispatchQueue(label: "client.Network.Queue")
    
    public init() {}
    
    public func requestJSON(url: String, parameters: [String : Any]?) -> Observable<Any> {
        return Observable.create { (observer) -> Disposable in
            AF.request(url,
                       method: .get,
                       parameters: parameters,
                       encoding: URLEncoding.default,
                       headers: nil,
                       interceptor: nil
            ).responseJSON(queue: self.queue) { (response) in
                switch response.result {
                case .success(let value):
                    observer.onNext(value)
                    observer.onCompleted()
                case .failure(let error):
                    let error = error.underlyingError as NSError?
                    observer.onError(NetworkError(error: error ?? NSError.init()))
                }
            }
            
            return Disposables.create()
        }
    }
}

