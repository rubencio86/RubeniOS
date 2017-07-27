
//

import UIKit

class RecipeDetailViewCellTableViewCell: UITableViewCell {
    
    @IBOutlet var keyNameRecipeDetail: UILabel!
    @IBOutlet var nameRecipeDetail: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
