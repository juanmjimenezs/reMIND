//
//  IconsViewController.swift
//  reMIND
//
//  Created by Juan Manuel Jimenez Sanchez on 29/01/17.
//  Copyright © 2017 Juan Manuel Jimenez Sanchez. All rights reserved.
//

import UIKit

class IconsViewController: UICollectionViewController {

    var iconList: [[String:String]] = [[String:String]]()
    
    var icons: [String] = [String]()
    
    var headerTitleString: String?
    
    var selectedTask: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.iconList.append(["icon":"img_icono_compra", "title":"Compra"])
        self.iconList.append(["icon":"img_icono_economia", "title":"Economía"])
        self.iconList.append(["icon":"img_icono_amor", "title":"Amor"])
        self.iconList.append(["icon":"img_icono_amigos", "title":"Amigos"])
        self.iconList.append(["icon":"img_icono_lugares", "title":"Lugares"])
        self.iconList.append(["icon":"img_icono_fechas", "title":"Fechas"])
        self.iconList.append(["icon":"img_icono_webs", "title":"Webs"])
        self.iconList.append(["icon":"img_icono_archivos", "title":"Archivos"])
        self.iconList.append(["icon":"img_icono_musica", "title":"Musica"])
        self.iconList.append(["icon":"img_icono_vacaciones", "title":"Vacaciones"])
        self.iconList.append(["icon":"img_icono_ideas", "title":"Ideas"])
        self.iconList.append(["icon":"img_icono_deportes", "title":"Deportes"])
    }
}

extension IconsViewController: UICollectionViewDelegateFlowLayout {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.iconList.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "iconCellIdentifier", for: indexPath)
        
        let icon = iconList[indexPath.row]
        
        if let cell = cell as? IconCell {
            if let icon = icon["icon"] {
                cell.icon.image = UIImage(named: icon)
            }
            if let title = icon["title"] {
                cell.title.text = title
            }
        }
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "headerView", for: indexPath) as! HeaderView
        
        headerView.taskName.text = self.headerTitleString
        
        return headerView
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let icon = iconList[indexPath.row]
        
        if let selectedTask = self.selectedTask {
            TaskManager.sharedInstance.tasks[selectedTask]["icon"] = icon["icon"]
            let _ = navigationController?.popViewController(animated: true)
        }
    }
    
    //Con esta función calculamos el ancho de cada item sin importar las dimensiones del dispositivo
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let maxWidth = collectionView.frame.size.width / 3.5
        
        return CGSize(width: maxWidth, height: maxWidth)
    }
}
