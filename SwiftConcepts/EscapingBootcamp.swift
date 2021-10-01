//
//  EscapingBootcamp.swift
//  SwiftConcepts
//
//  Created by Vong Nyuksoon on 02/10/2021.
//

import SwiftUI

class EscapingVM: ObservableObject {
    @Published var text: String = "Hello"
    
    func getData() {
        
        //        let newData = downloadData()
        //        text = newData
        
        //        downloadData2 { (returnedData) in
        //            text = returnedData
        //        }
        
        //        downloadData3 { [weak self] (returnedData) in
        //            self?.text = returnedData
        //        }
        
        //        downloadData4 { [weak self] (returnedData) in
        //            self?.text = returnedData.data
        //        }
        
        downloadData5 { [weak self] (returnedData) in
            self?.text = returnedData.data
        }
    }
    
    // synchronous
    func downloadData() -> String {
        return "New data"
    }
    
    func downloadData2(completionHandler: (_ data: String) -> ()) {
        completionHandler("New data2")
    }
    
    // @escaping
    // - make func asynchronous
    // - will not immediately return
    func downloadData3(completionHandler: @escaping (_ data: String) -> ()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            completionHandler("New data3")
        }
    }
    
    func downloadData4(completionHandler: @escaping (DownloadResult) -> ()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            let result = DownloadResult(data: "New data4")
            completionHandler(result)
        }
    }
    
    func downloadData5(completionHandler: @escaping DownloadCompletion ) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            let result = DownloadResult(data: "New data5")
            completionHandler(result)
        }
    }
}

struct DownloadResult {
    let data: String
}

typealias DownloadCompletion = (DownloadResult) -> ()

struct EscapingBootcamp: View {
    
    @StateObject private var vm: EscapingVM = EscapingVM()
    
    var body: some View {
        Text(vm.text)
            .font(.largeTitle)
            .fontWeight(.semibold)
            .foregroundColor(.blue)
            .onTapGesture {
                vm.getData()
            }
    }
}

struct EscapingBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        EscapingBootcamp()
    }
}
