//
//  MyLibraryViewController.swift
//  Pocket Library
//
//  Created by Kinan Alsheikh on 4/27/18.
//  Copyright © 2018 Kinan Alsheikh. All rights reserved.
//

import UIKit

protocol PressedDelegate {
    func tableViewPressed(withImage image: UIImage)
}

class MyLibraryViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, SaveButtonDelegate{
    
    let cellReuseIdentifier = "imageCell"
    var delegate: PressedDelegate!
    var timer: Timer?
    var library: [TextPicture] = []
    var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "My Library"
        view.backgroundColor = .white
        // Do any additional setup after loading the view.
        tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.bounces = true
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(TextPictureTableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        
        view.addSubview(tableView)
        
        setUpConstraints()
    }
    
    func setUpConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Collection"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(library.count)
        return library.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as! TextPictureTableViewCell
        print("here")
        let title = library[indexPath.row].title
        let image = library[indexPath.row].image
        print("here!!")
        cell.textImage.image = image
        cell.titleText.text = title
        print("here!!!!!")
        cell.setNeedsUpdateConstraints()
        return cell
    }

    
    func saveButtonPressed(image: UIImage, title: String) {
        library.append(TextPicture(title: title, image: image))
        print(image)
        print(title)
        print(library)
        if (library.count > 1){
            self.tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        tableView.deselectRow(at: indexPath, animated: true)
        let pic = library[indexPath.row].image
        let destination = ImageViewController()
        delegate = destination
        delegate.tableViewPressed(withImage: pic)
        navigationController?.pushViewController(destination, animated: true)
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
