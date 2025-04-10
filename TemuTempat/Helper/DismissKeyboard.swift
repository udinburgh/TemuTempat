//
//  DismissKeyboard.swift
//  TemuTempat
//
//  Created by Akbar Febry on 29/03/25.
//
import SwiftUI
import UIKit

func dismissKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder),
                                      to: nil,
                                      from: nil,
                                      for: nil)
    }
