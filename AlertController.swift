//
//  AlertController.swift
//  Food Mood
//
//  Created by Nikita Kuznetsov on 02.06.2023.
//

import UIKit

class AlertController: UIAlertController {

    func actionWIthTaskList() {
                
        let saveAction = UIAlertAction(title: "Save", style: .default) { _ in
            guard let newValue = self.textFields?.first?.text else { return }
            guard !newValue.isEmpty else { return }
        
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive)
        
        addAction(saveAction)
        addAction(cancelAction) 
    }

}
