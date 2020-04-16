//
//  TextPictureTableViewCell.swift
//  Pocket Library
//
//  Created by Kinan Alsheikh on 4/27/18.
//  Copyright © 2018 Kinan Alsheikh. All rights reserved.
//

import UIKit

class TextPictureTableViewCell: UITableViewCell {
    
    var textImage: UIImageView!
    var titleText: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        textImage = UIImageView()
        textImage.translatesAutoresizingMaskIntoConstraints = false
        
        titleText = UILabel()
        titleText.font = .boldSystemFont(ofSize: 18)
        titleText.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(textImage)
        contentView.addSubview(titleText)
    }
    
    override func updateConstraints() {
        NSLayoutConstraint.activate([
            textImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            textImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            textImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            textImage.widthAnchor.constraint(equalTo: textImage.heightAnchor)
            ])
        
        NSLayoutConstraint.activate([
            titleText.leadingAnchor.constraint(equalTo: textImage.trailingAnchor, constant: 16),
            titleText.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8)
            ])
        
        super.updateConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
