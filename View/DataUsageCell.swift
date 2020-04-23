//
//  Created by La Hy Tai on 4/23/20.
//

import UIKit

class DataUsageCell: UITableViewCell {
    static let identifier = "DataUsageCell"
    static let cellHeight : CGFloat = 60.0
    
    @IBOutlet var yearLable: UILabel!
    @IBOutlet var dataUsageLable: UILabel!
    
    internal var viewModel: DataUsageCellModelType? {
        didSet {
            if let viewModel = viewModel {
                yearLable.text = String(format: "%d", viewModel.year)
                dataUsageLable.text = String(format: "%.6f",viewModel.usage)
                self.accessoryType = viewModel.isDecrease ? .checkmark : .none
                self.selectionStyle =  viewModel.isDecrease ? .gray : .none
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
