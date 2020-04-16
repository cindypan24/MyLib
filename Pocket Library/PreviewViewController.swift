//
//  PreviewViewController.swift
//  Pocket Library
//
//  Created by Kinan Alsheikh on 4/26/18.
//  Copyright © 2018 Kinan Alsheikh. All rights reserved.
//

import UIKit

protocol SaveButtonDelegate {
    func saveButtonPressed(image: UIImage, title: String)
}

class PreviewViewController: UIViewController, CameraButtonDelegate {

    var picView: UIImageView!
    var delegate: CameraButtonDelegate!
    var saveButtonDelegate: SaveButtonDelegate!
    var picTitle: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(saveButtonPressed))
        
        picView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(picView)
        
        setUpConstraints()

        
    // Do any additional setup after loading the view.
    }

    func setUpConstraints() {
        NSLayoutConstraint.activate([
            picView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            picView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            picView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor),
            picView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, constant: 100)
            ])
    }
    
    func cameraButtonPressed(withImage image: UIImage) {
        picView = UIImageView(image: image)
    }
    
    @objc func saveButtonPressed(sender: UIButton){
        let alertController = UIAlertController(title: "Title", message: "What would you like to name this image?", preferredStyle: .alert)
            alertController.addTextField(configurationHandler: { (textField) in
            textField.placeholder = "Title"
        })
        let okButton = UIAlertAction(title: "OK", style: .default, handler: {(alert: UIAlertAction!) in
            self.saveButtonDelegate = libraryVC
            self.picTitle = alertController.textFields![0].text
            print(self.picTitle! + "1")
            self.saveButtonDelegate.saveButtonPressed(image: self.picView.image!, title: self.picTitle!)
            self.navigationController?.popViewController(animated: true)
        })
        alertController.addAction(okButton)
        self.present(alertController, animated: true, completion: nil)
//        navigationController?.popViewController(animated: true)
//        dismiss(animated: true, completion: nil)
//        saveButtonDelegate = MyLibraryViewController()
//        saveButtonDelegate.saveButtonPressed(image: picView.image!, title: picTitle!)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
