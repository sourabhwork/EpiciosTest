//
//  ArticlesTableViewCell.swift
//  EpiciosTest
//
//  Created by Sourabh Kumbhar on 19/12/20.
//  Copyright © 2020 Sourabh Kumbhar. All rights reserved.
//

import UIKit

class ArticlesTableViewCell: UITableViewCell {

    @IBOutlet weak var backView         : UIView!
    @IBOutlet weak var userImageView    : UIImageView!
    @IBOutlet weak var userNameLabel    : UILabel!
    @IBOutlet weak var userDesignationLabel: UILabel!
    @IBOutlet weak var timeLabel        : UILabel!
    @IBOutlet weak var contentLabel     : UILabel!
    @IBOutlet weak var titleLabel       : UILabel!
    @IBOutlet weak var urlLabel         : UILabel!
    @IBOutlet weak var likeLabel        : UILabel!
    @IBOutlet weak var commentLabel     : UILabel!
    @IBOutlet weak var articleImageView : UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
        self.setupUI()
    }
    
    private func setupUI() {
        userImageView.setRadius(40.0)
        backView.addShadowToView()
    }
    
    func configureCell(article: Article) {
        // clear data from cell
        self.clearData()
        
        // Set data to views
        if article.user.count != 0 {
            let user = article.user[0]
            let userImage = user.avatar
            userImageView.downloaded(from: userImage, contentMode: .scaleAspectFit)
            userNameLabel.text = user.name
            userDesignationLabel.text = user.designation
            timeLabel.text = getConvertedDateString(stringDate: user.createdAt)                
        }
        contentLabel.text = article.content
        // Convert data into k(thousand) format
        commentLabel.text = DoubleHelper.formatNumber(article.comments) + ConstantKey.comment
        likeLabel.text =  DoubleHelper.formatNumber(article.likes) + ConstantKey.likes
        
        if article.media.count != 0 {
            let media = article.media[0]
            articleImageView.downloaded(from: media.image, contentMode: .scaleToFill)
            titleLabel.text = media.title
            urlLabel.text = media.url
        }
    }
    
    private func clearData() {
        userNameLabel.text = ""
        userDesignationLabel.text = ""
        timeLabel.text = ""
        contentLabel.text = ""
        titleLabel.text = ""
        urlLabel.text = ""
        likeLabel.text = ""
        commentLabel.text = ""
    }

    private func getConvertedDateString(stringDate: String)->String {
        var convertedString = ""
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        if let date = dateFormatter.date(from: stringDate) {
            convertedString = date.getElapsedInterval()
        }
        return convertedString
    }
}
