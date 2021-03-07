//
//  ViewController.swift
//  UIcollectionViewTest
//
//  Created by Дмитрий Подольский on 05.03.2021.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var titles = [String?]()
    var iconsJ = [String?]()

    @IBOutlet weak var horizontalCollectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    
    let urlString = "https://www.breakingbadapi.com/api/characters"

    private func parsJSON() {
    let url = URL(string: urlString)
    URLSession.shared.dataTask(with:url!) { (data, response, error) in
        if error != nil {
            print(error!.localizedDescription)
        } else {
            do {

                let parsedData = try JSONSerialization.jsonObject(with: data!) as! [[String : Any]]
                for item in parsedData
                {
                    let id = item["name"] as! String
                    let photo = item["img"] as! String
                    print(id)
                    
                    self.titles.append(id)
                    self.iconsJ.append(photo)
                }

                DispatchQueue.main.async{
                    self.horizontalCollectionView.reloadData()
                    self.tableView.reloadData()
                }

            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
        }.resume()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        horizontalCollectionView.dataSource = self
        horizontalCollectionView.delegate = self
        tableView.dataSource = self
        tableView.delegate = self
        self.horizontalCollectionView.showsHorizontalScrollIndicator = false
        parsJSON()
        }
    }

extension ViewController:UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell", for: indexPath) as! ContentCellTableViewCell
            let title = titles[indexPath.item]
            let iconJ = iconsJ[indexPath.item]
            cell.label.text = title
            cell.icon.image = UIImage(data: NSData(contentsOf: NSURL(string: iconJ! )! as URL)! as Data)
   
       return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ImageCollectionViewCell
        let title = titles[indexPath.item]
        let iconJ = iconsJ[indexPath.item]
            cell.label.text = title
        cell.icon.image = UIImage(data: NSData(contentsOf: NSURL(string: iconJ! )! as URL)! as Data)
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowOpacity = 1
        cell.layer.shadowOffset = CGSize.zero
      
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return titles.count
    }
   
}



