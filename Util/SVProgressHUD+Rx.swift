//
//  Created by La Hy Tai on 4/23/20.
//

import RxSwift
import RxCocoa
import SVProgressHUD

extension Reactive where Base: SVProgressHUD {
    var isLoading: Binder<Bool> {
        return Binder(UIApplication.shared) { sv, isShow in
            if isShow {
                SVProgressHUD.show()
            }else{
                SVProgressHUD.dismiss()
            }
        }
    }
}


