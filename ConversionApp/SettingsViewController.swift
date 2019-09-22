//
//  SettingsViewController.swift
//  ConversionApp
//
//  Created by Kyler Kupres on 9/22/19.
//  Copyright © 2019 cis.gvsu.edu. All rights reserved.
//

import UIKit

protocol SettingsViewControllerDelegate {
    func settingsChanged(fromUnits: LengthUnit, toUnits: LengthUnit)
    func settingsChanged(fromUnits: VolumeUnit, toUnits: VolumeUnit)
}

class SettingsViewController: UIViewController {

    @IBOutlet weak var settingsPickerView: UIPickerView!
       
       var pickerData: [String] = [String]()
       var selection = "Default"
       var defaultFromUnit = LengthUnit.Yards
       var defaultToUnits = LengthUnit.Meters
       var delegate : SettingsViewControllerDelegate?
       
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.pickerData = ["Meters","Yards","Miles","Liters","Gallons","Quarts"]
        self.settingsPickerView.delegate = self
        self.settingsPickerView.dataSource = self
        
    }
    
    override func viewWillDisappear(_ animated: Bool){
        super.viewWillDisappear(animated)
        if let d = self.delegate{
            d.settingsChanged(fromUnits: defaultFromUnit, toUnits: defaultToUnits)
        }
    }
    
   
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension SettingsViewController : UIPickerViewDataSource, UIPickerViewDelegate {
    //number of colums of data
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1  
    }
    
    //number of rows of data
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.pickerData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.selection = self.pickerData[row]
    }
}
