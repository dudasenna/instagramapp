//
//  PostagemTableViewCell.swift
//  Instagram
//
//  Created by Jamilton  Damasceno
//  Copyright © Curso IOS. All rights reserved.
//

import UIKit

class PostagemTableViewCell: UITableViewCell {
    
    @IBOutlet weak var descricaoPostagem: UILabel!
    @IBOutlet weak var fotoPostagem: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
