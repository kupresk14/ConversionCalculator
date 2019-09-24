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
    @IBOutlet weak var fromUnitSelection: UILabel!
    @IBOutlet weak var toUnitSelection: UILabel!
    
    
    var pickerData: [String] = [String]()
    var selection = ""
    var fromUnitsString: String = "Yards"
    var toUnitsString: String = "Meters"
    var delegate : SettingsViewControllerDelegate?
    var mode: CalculatorMode = .Length

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //setting initial UILabel text and mode
        self.fromUnitSelection.text = fromUnitsString
        self.toUnitSelection.text = toUnitsString
        
        // Setting picker Data (Need to figure out how to get mode settings to this class.)
        switch (mode) {
        case .Length:
            LengthUnit.allCases.forEach{
                pickerData.append($0.rawValue)
            }
        case .Volume:
            VolumeUnit.allCases.forEach{
                pickerData.append($0.rawValue)
            }
            
        }
        
        self.settingsPickerView.delegate = self
        self.settingsPickerView.dataSource = self
        
              //Instanciate fromUnitSelection tap function
              let fromUnitTap = UITapGestureRecognizer(target: self, action: #selector(SettingsViewController.fromUnitTapped))
              fromUnitSelection.addGestureRecognizer(fromUnitTap)
              
              //Instanciate toUnitSelection tap function
              let toUnitTap = UITapGestureRecognizer(target: self, action: #selector(SettingsViewController.toUnitTapped))
              toUnitSelection.addGestureRecognizer(toUnitTap)
    }
    
    //Uses the settings button to send delegate information to the View Controller class.
    //It then calls dismiss in order to close the window when saved.
    @IBAction func settingsButton(_ sender: Any) {
        if let d = self.delegate{
            if(mode == .Length){
                d.settingsChanged(fromUnits: LengthUnit(rawValue: fromUnitsString)!, toUnits: LengthUnit(rawValue: toUnitsString)!)
            }
            else if(mode == .Volume){
                d.settingsChanged(fromUnits: VolumeUnit(rawValue: fromUnitsString)!, toUnits: VolumeUnit(rawValue: toUnitsString)!)
            }
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
        }
    }
    

    //Function to control fromUnit UILabel Tap and shows settings picker
    //when the text is tapped
    @objc func fromUnitTapped(sender:UITapGestureRecognizer){
        settingsPickerView.isHidden = false
         fromUnitSelection.text = selection
         fromUnitsString = selection
    }
    
    //Function to control toUnit UILabel Tap and shows settings picker
    //when the text is tapped
    @objc func toUnitTapped(sender:UITapGestureRecognizer){
        settingsPickerView.isHidden = false
        toUnitSelection.text = selection
        toUnitsString = selection
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
