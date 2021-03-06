//
//  VCScreen2.swift
//  BabySitter
//
//  Created by Mina Shehata Gad on 1/29/17.
//  Copyright © 2017 Mina Shehata Gad. All rights reserved.
//

import UIKit

class GridViewController: UIViewController ,UICollectionViewDelegate,UICollectionViewDataSource{

    @IBOutlet var CVList: UICollectionView!
    
    var loadDataBase = [Employee]()

    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        LoadFromURL()
        
    }
    ////////collection view
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "emp1", for: indexPath) as! CollectionViewEmpCell
        
        cell.emImage.image = UIImage(named: "white_tiger")
        cell.empID.text = loadDataBase[indexPath.row].TransferID
        cell.empName.text = loadDataBase[indexPath.row].FromAddress
        
        return cell
        
        
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return loadDataBase.count
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "ShowDetails1", sender: loadDataBase[indexPath.row])
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dis=segue.destination as?  MapViewController {
            if let emp = sender as? Employee {
                
                dis.employee = emp
                
            }
            
            
        }
        
    }
    
    
    /////////////////**************************************
    
    
    
    func LoadFromURL(){
        
        
        let parameters = ["un":"userName","up":"userPassword","name":"test","password":"123"]
        
        
        let url = URL(string: "http://qtech-system.com/interview/index.php/apis/login")!
        
        
        let session = URLSession.shared
        
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
            
        } catch let error {
            print(error.localizedDescription)
        }
        
        
        let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
            
            guard error == nil else {
                return
            }
            
            guard let data = data else {
                return
            }
            
            DispatchQueue.global().async {

                do {
                    
                    let json = try JSONSerialization.jsonObject(with: data) as! [String: Any]
                    
                    let message = json["message"] as! [[String:String]]
                    
                    DispatchQueue.global().async {
                    
                    for info in message {
                        self.loadDataBase.append(Employee(TransferID: "transferID: \(info["TransferID"]!)", FromAddress: "Address: \(info["FromAddress"]!)", ToAddress: info["ToAddress"]!, ToLat: info["ToLat"]!, FromLat: info["FromLat"]!, ToLong: info["ToLong"]!, FromLong: info["FromLong"]!))
                       // print(info)
                    }
                        self.CVList.reloadData()
                        
                }
                } catch let error {
                    print(error.localizedDescription)
                }
            }
            
        })
        task.resume()
        
    }

}
    
    

    


