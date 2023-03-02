//
//  LoadingView.swift
//  WTF - What's the Forecast
//
//  Created by janelle myers on 2/28/23.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        ProgressView.init().progressViewStyle(CircularProgressViewStyle(tint: .white))
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
