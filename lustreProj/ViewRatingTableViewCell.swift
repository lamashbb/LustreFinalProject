import UIKit
import Cosmos
class ViewRatingTableViewCell: UITableViewCell {
    var delegate: ProgramCellDelegate?
    @IBOutlet weak var cosmosRating: CosmosView!
    
    @IBOutlet weak var firstName: UILabel!
    @IBOutlet weak var reviewText: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
