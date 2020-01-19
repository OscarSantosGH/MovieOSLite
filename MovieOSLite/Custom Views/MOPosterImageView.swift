//
//  MOPosterImageView.swift
//  MovieOSLite
//
//  Created by Oscar Santos on 1/17/20.
//  Copyright © 2020 Oscar Santos. All rights reserved.
//

import UIKit

class MOPosterImageView: UIImageView {
    
    let imagePlaceHolder = UIImage(named: "posterPlaceholder")!
    let cache = NetworkManager.shared.cache
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure(){
        layer.cornerRadius = 10
        contentMode = .scaleAspectFill
        clipsToBounds = true
        image = imagePlaceHolder
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setPoster(from urlString:String) {
        let cacheKey = NSString(string: urlString)
        
        if let image = cache.object(forKey: cacheKey){
            self.image = image
            return
        }
        
        NetworkManager.shared.downloadPosterImage(from: urlString) { [weak self] (result) in
            guard let self = self else {return}
            
            switch result{
            case .success(let image):
                DispatchQueue.main.async {
                    self.image = image
                }
            case .failure(let error):
                print(error.rawValue)
            }
        }
    }

}
