//
//  ViewController.swift
//  ConversionApp
//
//  Created by Xcode User on 9/18/19.
//  Copyright © 2019 cis.gvsu.edu. All rights reserved.
//

import UIKit

class ViewController: UIViewController, SettingsViewControllerDelegate{
   
    
    @IBOutlet weak var fromLabel: UILabel!
    @IBOutlet weak var toLabel: UILabel!
    @IBOutlet weak var fromField: UITextField!
    @IBOutlet weak var toField: UITextField!
    var currentMode: CalculatorMode = .Length
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //Allows user to touch anywhere on screen to remove keyboard view
        let detectTouch = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        self.view.addGestureRecognizer(detectTouch)
        
    }
    
    //Function to dismiss the keyboard
    @objc func dismissKeyboard(){
        self.view.endEditing(true)
    }
    
    //Changes the settings for Length Units, sets placeholder value also
    func settingsChanged(fromUnits: LengthUnit, toUnits: LengthUnit) {
        self.fromLabel.text = fromUnits.rawValue
        self.toLabel.text = toUnits.rawValue
        fromField.placeholder = "Enter length in \(fromUnits.rawValue)"
        toField.placeholder = "Enter length in \(toUnits.rawValue)"
    }

    //Changes the settings for Volume Units, sets placeholder value also
    func settingsChanged(fromUnits: VolumeUnit, toUnits: VolumeUnit) {
        self.fromLabel.text = fromUnits.rawValue
        self.toLabel.text = toUnits.rawValue
        fromField.placeholder = "Enter volume in \(fromUnits.rawValue)"
        toField.placeholder = "Enter volume in \(toUnits.rawValue)"
    }
    
    //Prepares for segue tp Settings View
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if segue.identifier == "settingSegue"{
            if let d = segue.destination.childViewControllers[0] as? SettingsViewController {
                    d.delegate = self
                    d.mode = currentMode
                    d.fromUnitsString = fromLabel.text!
                    d.toUnitsString = toLabel.text!
                  }
            }
        }
    
    
    //Controls cancel functionality back to this view
    @IBAction func cancelSettingsViewController(_ segue: UIStoryboardSegue){
    }

    //Controls the funtionality of the calculator button. Need to pull conversion values
    //from the UnitsAndModes for conversion.
    @IBAction func calcButton(_ sender: Any) {
      let fromMode:Double? = Double(self.fromField.text!)
      let toMode:Double? = Double(self.toField.text!);
        var calcLengthAns: Double = 0.0
        var calcVolumeAns: Double = 0.0
        
        let fromText: String = fromLabel.text!
        let toText: String = toLabel.text!

        //Will only calculate when one field or the other is empty
        //Calculates based on VolumeUnits or LengthUnits
        if(self.fromField.text == "" && self.toField.text != ""){
            switch(currentMode){
            case .Length:
                let convKey =  LengthConversionKey(toUnits: LengthUnit(rawValue: fromText)!, fromUnits: LengthUnit(rawValue: toText)!)
                   print(convKey)
                   calcLengthAns = lengthConversionTable[convKey]! * toMode!
                   fromField.text = "\(calcLengthAns)"
            case .Volume:
                let convKey =  VolumeConversionKey(toUnits: VolumeUnit(rawValue: fromText)!, fromUnits: VolumeUnit(rawValue: toText)!)
                    calcVolumeAns = volumeConversionTable[convKey]! * toMode!
                    fromField.text = "\(calcVolumeAns)"
            }
        }
        else if(self.fromField.text != "" && self.toField.text == ""){
            switch(currentMode){
            case .Length:
                let convKey =  LengthConversionKey(toUnits: LengthUnit(rawValue: toText)!, fromUnits: LengthUnit(rawValue: fromText)!)
                   print(convKey)
                   calcLengthAns = lengthConversionTable[convKey]! * fromMode!
                   toField.text = "\(calcLengthAns)"
            case .Volume:
                let convKey =  VolumeConversionKey(toUnits: VolumeUnit(rawValue: toText)!, fromUnits: VolumeUnit(rawValue: fromText)!)
                    calcVolumeAns = volumeConversionTable[convKey]! * fromMode!
                    toField.text = "\(calcVolumeAns)"
            }
        }

        //This part gives the user a little message saying when trying to convert between
        //one type to the same type. Not sure if we should allow that or not so I checked
        //for it
        if(self.fromLabel.text == self.toLabel.text){
            let alert = UIAlertController(title: "Just an FYI", message: "You are trying to convert between two of the same type. Choose different settings!", preferredStyle: UIAlertControllerStyle.alert)
                   alert.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.default, handler: nil))
                   self.present(alert, animated: true, completion: nil)
        }
    }
    
    //Clears all text from the fields
    @IBAction func clearButton(_ sender: Any) {
        self.fromField.text = "";
        self.toField.text = "";
    }
    
    //Controls the default functionality of the mode button. Changes the mode that gets
    //sent to the settings view when called
    @IBAction func modeButton(_ sender: Any) {
        //implement this to send mode data to the settings display when needed
        if(currentMode == .Length){
            currentMode = .Volume
            self.fromLabel.text = VolumeUnit.Gallons.rawValue
            self.fromField.placeholder = "Enter Volume in Gallons"
            self.toLabel.text = VolumeUnit.Liters.rawValue
            self.toField.placeholder = "Enter volume in Liters"
        }
        else{
            currentMode = .Length
            self.fromLabel.text = LengthUnit.Yards.rawValue
            self.fromField.placeholder = "Enter length in Yards"
            self.toLabel.text = LengthUnit.Meters.rawValue
            self.toField.placeholder = "Enter length in Meters"
        }
    }
}

