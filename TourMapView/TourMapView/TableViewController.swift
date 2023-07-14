//
//  TableViewController.swift
//  TourMapView
//
//  Created by Yerlan Tleubayev on 02.07.2023.
//

import UIKit

class TableViewController: UITableViewController {
    
    var arrayPlans = [TourPlans(name: "Arashiyama     嵐山", cost: "Free", imagename: "arashiyama", latitude: 135.6668, longitude: 35.0094),
                      TourPlans(name: "Fushimi inari shrine     伏見稲荷大社",cost: "Free", imagename: "fushimi inari shrine", latitude: 135.7727, longitude: 34.9671),
                      TourPlans(name: "Ginkakuji temple     銀閣寺", cost: "Adults: 500円 , children: 300円" , imagename: "ginkakuji temple", latitude: 135.7982, longitude: 35.0270),
                      TourPlans(name: "Golden pavilion     金閣寺", cost: "Adults: 500円 , Students,children: 300円", imagename: "golden pavilion", latitude: 135.7292, longitude: 35.0394),
                      TourPlans(name: "Shibuya     渋谷区", cost: "No entrance fee", imagename: "shibuya", latitude: 139.7038, longitude: 35.6620)]

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
     
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return arrayPlans.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlaceCell", for: indexPath)
        
        // Configure the cell...
        let label = cell.viewWithTag (1000) as! UILabel
        label.text = arrayPlans [indexPath.row].name
        let labelCost = cell.viewWithTag (1001) as! UILabel
        labelCost.text = arrayPlans [indexPath.row].cost
        let imageview = cell.viewWithTag (1002) as! UIImageView
        imageview.image = UIImage (named: arrayPlans [indexPath.row].imagename)
//
//
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 386
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVc = storyboard?.instantiateViewController (withIdentifier:
                                                                "detailViewController") as! ViewController
        navigationController?.show(detailVc, sender: self)
        detailVc.names = arrayPlans [indexPath.row].name
        detailVc.Cost = arrayPlans [indexPath.row].cost
        detailVc.imageName = arrayPlans [indexPath.row].imagename
        detailVc.latitudeSecond = arrayPlans [indexPath.row].longitude
        detailVc.longitudeSecond = arrayPlans [indexPath.row].latitude
//
        /*
         // Override to support conditional editing of the table view.
         override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
         // Return false if you do not want the specified item to be editable.
         return true
         }
         */
        
        /*
         // Override to support editing the table view.
         override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
         if editingStyle == .delete {
         // Delete the row from the data source
         tableView.deleteRows(at: [indexPath], with: .fade)
         } else if editingStyle == .insert {
         // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
         }
         }
         */
        
        /*
         // Override to support rearranging the table view.
         override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
         
         }
         */
        
        /*
         // Override to support conditional rearranging of the table view.
         override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
         // Return false if you do not want the item to be re-orderable.
         return true
         }
         */
        
        /*
         // MARK: - Navigation
         
         // In a storyboard-based application, you will often want to do a little preparation before navigation
         override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         // Get the new view controller using segue.destination.
         // Pass the selected object to the new view controller.
         }
         */
        
    }
}

