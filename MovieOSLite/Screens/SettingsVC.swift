//
//  SettingsVC.swift
//  MovieOSLite
//
//  Created by Oscar Santos on 10/9/20.
//  Copyright © 2020 Oscar Santos. All rights reserved.
//

import UIKit

class SettingsVC: UIViewController {
    
    var tableView:UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    private func configure(){
        tableView = UITableView(frame: view.frame, style: .insetGrouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableHeaderView = TMDBattributionView(frame: CGRect(x: tableView.frame.origin.x, y: tableView.frame.origin.y, width: tableView.frame.width, height: 55))
        
        view.addSubview(tableView)
        
        
        
    }

}

extension SettingsVC: UITableViewDelegate, UITableViewDataSource{
    //MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell.init(style: .value1, reuseIdentifier: "Setting")
        let globeImg = UIImage(systemName: "globe")
        cell.imageView?.image = globeImg
        cell.imageView?.tintColor = .systemBlue
        cell.accessoryType = .disclosureIndicator
        cell.textLabel?.text = NSLocalizedString("Language", comment: "The language")
        cell.detailTextLabel?.text = MOLanguage.getCurrent()
        return cell
    }
    
    
    //MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        NSLocalizedString("Preferred Language", comment: "The Preferred Language")
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
    }
    
}
