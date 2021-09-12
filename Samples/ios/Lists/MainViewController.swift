//
//  MainViewController.swift
//  Lists
//
//  Created by ahmedalnaami on 12/09/2021.
//

import UIKit
import SwiftUI
import Telereso

class MainStoryboardViewController : UIViewController {

    @IBOutlet weak var label: UILabel!

    @IBOutlet weak var button: UIButton!

    @IBOutlet weak var textFeild: UITextField!

}

struct MainStoryBoardView : View {
    var body: some View {
        MainViewController()
    }
}

struct MainViewController : UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> MainStoryboardViewController {
        UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(identifier: "main") as! MainStoryboardViewController
    }
    
    func updateUIViewController(_ uiViewController: MainStoryboardViewController, context: Context) {
        uiViewController.label.text = Telereso.getRemoteString("Manga")
        uiViewController.button.setTitle(Telereso.getRemoteString("Manga"),for: UIControl.State.normal)
        uiViewController.textFeild.text = Telereso.getRemoteString("Manga")

    }
}
