//
//  OmdbMoviesCellTableViewCell.swift
//  OmdbMovieApp
//
//  Created by Şafak Can Baş on 26.07.2021.
//

import UIKit

class OmdbMoviesCellTableViewCell: UITableViewCell {
    static let identifier = "OmdbMoviesCellTableViewCell"
    @IBOutlet var movieTitleLabel : UILabel!
    @IBOutlet var movieYearLabel : UILabel!
    @IBOutlet var moviepPosterImage : UIImageView!
    @IBOutlet weak var containerView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }
    
    func configureUI() {
        containerView.layer.cornerRadius = 5
        movieTitleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        movieYearLabel.font = UIFont.boldSystemFont(ofSize: 15)
    }
    func configure(with model: OmdbMovies) {
        movieTitleLabel.text = model.Title
        movieYearLabel.text = model.Year
      //  moviepPosterImage.image = UIImage(named: model.Poster ?? "")
        let data = try? Data(contentsOf: URL(string: model.Poster!)!)
        moviepPosterImage.image = UIImage(data: data!)
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    static func nib() -> UINib {
        return UINib(nibName: "OmdbMoviesCellTableViewCell", bundle: nil)
    }
}
