//
//  Created by La Hy Tai on 4/23/20.
//

import RxSwift

protocol DataUsageSearchType {
    func getDataUsage() -> Observable<ResponseEntity>
}
