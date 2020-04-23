//
//  Created by La Hy Tai on 4/23/20.
//

import SwinjectStoryboard

extension SwinjectStoryboard {
    class func setup() {
        defaultContainer.register(NetworkType.self) { _ in Network() }
        defaultContainer.register(DataUsageSearchType.self) { r in DataUsageSearch(network: r.resolve(NetworkType.self)!)
        }
        defaultContainer.register(HomeViewControllerModelType.self) { r in HomeViewControllerModel(dataUsageSearch: r.resolve(DataUsageSearchType.self)!) }
        defaultContainer.storyboardInitCompleted(HomeViewController.self) { r, vc in
            vc.viewModel = r.resolve(HomeViewControllerModelType.self)
        }
    }
}
