//
//  Created by La Hy Tai on 4/23/20.
//

import RxSwift

protocol NetworkType {
    func requestJSON(url: String, parameters: [String: Any]?) -> Observable<Any>
}

