//
//  XCTestCase+SnapshotTestingHelpers.swift
//  CursoSnapshotsTests
//
//  Created by Mario Alberto Barragán Espinosa on 03/04/22.
//

import XCTest
import UIKit
import SnapshotTesting

extension XCTestCase {
  
  enum Device: String {
    case iPhoneX
    case iPhone8
    case iPhoneSe
  }
  
  func assert(_ viewController: UIViewController,
              identifier: String = "",
              mode: UIUserInterfaceStyle = .light,
              device: Device,
              orientation: ViewImageConfig.Orientation = .portrait,
              testName: String = #function,
              isRecordingMode: Bool = false,
              file: StaticString = #filePath,
              line: UInt = #line) {

    viewController.overrideUserInterfaceStyle = mode

    verifyViewController(
      viewController,
      named: identifier + (mode == .light ? "light" : " dark"),
      isRecordingMode: isRecordingMode, 
      device: device,
      orientation: orientation,
      testName: testName,
      file: file,
      line: line)
  }

  func record(_ viewController: UIViewController,
              identifier: String = "",
              mode: UIUserInterfaceStyle = .light,
              device: Device,
              orientation: ViewImageConfig.Orientation = .portrait,
              testName: String = #function,
              file: StaticString = #filePath,
              line: UInt = #line) {
    assert(viewController,
           identifier: identifier,
           mode: mode, 
           device: device,
           orientation: orientation,
           testName: testName,
           isRecordingMode: true,
           file: file,
           line: line)
  }

  private func verifyViewController(_ viewController: UIViewController,
                                    named: String,
                                    isRecordingMode: Bool = false,
                                    device: Device,
                                    orientation: ViewImageConfig.Orientation,
                                    testName: String,
                                    file: StaticString = #filePath,
                                    line: UInt = #line) {
    let devices: [String: ViewImageConfig] = ["iPhoneX": .iPhoneX(orientation),
                                              "iPhone8": .iPhone8(orientation),
                                              "iPhoneSe": .iPhoneSe(orientation)]

    let deviceViewConfig = devices[device.rawValue]
    
    assertSnapshot(matching: viewController, 
                   as: .image(on: deviceViewConfig!),
                   named: "\(named)-\(device.rawValue)", 
                   record: isRecordingMode,
                   file: file,
                   testName: testName, 
                   line: line)
  }
}
