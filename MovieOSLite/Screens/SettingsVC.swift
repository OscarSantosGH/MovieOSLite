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
        tableView.showsVerticalScrollIndicator = false
        tableView.delegate = self
        tableView.dataSource = self
        
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
    
    override func viewDidLayoutSubviews() {
        //Get content height & calculate new footer height.
        let cells = self.tableView.visibleCells
        var height: CGFloat = 0
        for i in 0..<cells.count {
             height += cells[i].frame.height
        }
        
        guard let tabbarHeight = tabBarController?.tabBar.frame.height else {return}
        guard let navbarHeight = navigationController?.navigationBar.frame.height else {return}
        height = self.tableView.bounds.height - ceil(height) - (tabbarHeight*2) - (navbarHeight*2) - 20

        //If the footer's new height is negative, we make it 0, since we don't need footer anymore.
        height = height > 0 ? height : 0

        //Create the footer
        let footerView = TMDBattributionView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: height))
        self.tableView.tableFooterView = footerView
    }
    
}
