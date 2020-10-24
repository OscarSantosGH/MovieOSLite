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
    var sections = [Int:[UITableViewCell]]()
    let userDefaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableViewData()
        configure()
    }
    
    private func configure(){
        tableView = UITableView(frame: view.frame, style: .insetGrouped)
        tableView.showsVerticalScrollIndicator = false
        tableView.delegate = self
        tableView.dataSource = self
        
        view.addSubview(tableView)
        
    }
    
    private func configureTableViewData(){
        // language Cell
        let langCell = UITableViewCell.init(style: .value1, reuseIdentifier: "LangSetting")
        let globeImg = UIImage(systemName: "globe")
        langCell.imageView?.image = globeImg
        langCell.imageView?.tintColor = .systemBlue
        langCell.accessoryType = .disclosureIndicator
        langCell.textLabel?.text = NSLocalizedString("Language", comment: "The language")
        langCell.detailTextLabel?.text = MOLanguage.getCurrent()
        sections[1] = [langCell]
        
        // Appearance Cells
        let selectedApperance = userDefaults.integer(forKey: "appearance")
        
        let autoModeCell = UITableViewCell.init(style: .subtitle, reuseIdentifier: "AutoAppearanceSetting")
        autoModeCell.textLabel?.text = NSLocalizedString("Automatic", comment: "Automatic mode")
        autoModeCell.detailTextLabel?.text = NSLocalizedString("Match the appearance of the system", comment: "Match the appearance of the system")
        autoModeCell.detailTextLabel?.textColor = .secondaryLabel
        autoModeCell.accessoryType = selectedApperance != 0 ? .none : .checkmark
        
        let lightModeCell = UITableViewCell.init(style: .subtitle, reuseIdentifier: "LightAppearanceSetting")
        lightModeCell.textLabel?.text = NSLocalizedString("Light Mode", comment: "Light Mode")
        lightModeCell.detailTextLabel?.text = NSLocalizedString("Stays in light mode", comment: "Stays in light mode")
        lightModeCell.detailTextLabel?.textColor = .secondaryLabel
        lightModeCell.accessoryType = selectedApperance == 1 ? .checkmark : .none
        
        let darkModeCell = UITableViewCell.init(style: .subtitle, reuseIdentifier: "DarkAppearanceSetting")
        darkModeCell.textLabel?.text = NSLocalizedString("Dark Mode", comment: "Dark Mode")
        darkModeCell.detailTextLabel?.text = NSLocalizedString("Stays in dark mode", comment: "Stays in dark mode")
        darkModeCell.detailTextLabel?.textColor = .secondaryLabel
        darkModeCell.accessoryType = selectedApperance == 2 ? .checkmark : .none
        
        sections[2] = [autoModeCell, lightModeCell, darkModeCell]
    }

}

extension SettingsVC: UITableViewDelegate, UITableViewDataSource{
    //MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return 1
        }else{
            return 3
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        sections.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0{
            return sections[1]!.first!
        }else{
            return sections[2]![indexPath.row]
        }
    }
    
    
    //MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0{
            return NSLocalizedString("Preferred Language", comment: "The Preferred Language")
        }else{
            return NSLocalizedString("Appearance", comment: "The Appearance")
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0{
            UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
        }else{
            changeAppearance(selected: indexPath.row)
        }
        
    }
    
    private func changeAppearance(selected:Int){
        for cell in sections[2]!{
            cell.accessoryType = .none
            cell.setSelected(false, animated: true)
        }
        guard let scene = UIApplication.shared.connectedScenes.first,
            let windowSceneDelegate = scene.delegate as? UIWindowSceneDelegate,
            let window = windowSceneDelegate.window else {return}
        
        sections[2]![selected].accessoryType = .checkmark
        switch selected {
        case 1:
            window?.overrideUserInterfaceStyle = .light
            userDefaults.set(1, forKey: "appearance")
        case 2:
            window?.overrideUserInterfaceStyle = .dark
            userDefaults.set(2, forKey: "appearance")
        default:
            window?.overrideUserInterfaceStyle = .unspecified
            userDefaults.set(0, forKey: "appearance")
        }
        
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if section == sections.count - 1 {
            return TMDBattributionView()
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == sections.count - 1 {
            return 70
        }else{
            return tableView.sectionFooterHeight
        }
    }

    
}
