//
//  SwiftUIView.swift
//
//
//  Created by Satyam Tripathi on 22/12/23.
//

import SwiftUI

public struct MQLSettingsView: View {
    
    @EnvironmentObject var theme : Theme
    @StateObject private var viewModel = SettingsViewModel()
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Binding var isLoginModalPresented: Bool
    
    public init(isLoginModalPresented: Binding<Bool>) {
        _isLoginModalPresented = isLoginModalPresented
    }
    
    public var body: some View {
        ZStack {
            theme.colors.backGroundPrimary
                .ignoresSafeArea()
            
            ScrollView(.vertical) {
                VStack(alignment: .leading){
                    
                    //Heading Text
                    Text("settings", bundle: .module)
                        .modifier(theme.typography.h1Style(color: theme.colors.secondary))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.top, 30)
                        .padding(.bottom, 25)
                    // Account Section
                    IconNameView(title: "account", icon: Icon.account)
                    
                    //Accounts button
                    NavigationLink(
                        destination: EditProfileView(),
                        isActive: $viewModel.isEditProfileActive
                    ) {
                        SettingsButton(title: "editProfile") {
                            viewModel.isEditProfileActive = true
                        }
                    }
                    
                    //Change Password
                    NavigationLink(
                        destination: ChangePasswordView(),
                        isActive: $viewModel.isChangePasswordActive
                    ) {
                        SettingsButton(title: "changePassword") {
                            viewModel.isChangePasswordActive = true
                        }
                    }

                    // Privacy
                    NavigationLink(
                        destination: WebView(url: $viewModel.webViewURL, title: $viewModel.webViewTitle),
                        isActive: $viewModel.isWebViewActive
                    ) {
                        SettingsButton(title: "privacy") {
                            viewModel.webViewURL = SettingsLinks.privacy
                            viewModel.isWebViewActive = true
                            viewModel.webViewTitle = "privacy"
                        }
                    }
                   
                    //Logout
                    SettingsButton(title: "logout") {
                        debugPrint("logout")
                        SecureUserDefaults.removeValue(forKey: LocalStorageKeys.token)
                        MQLAppState.shared.token = nil
                        isLoginModalPresented = true
                    }
                    
                    // Other Section
                    IconNameView(title: "other", icon: Icon.other)
                        .padding(.top, 30)
                    
                    //Help
                    NavigationLink(
                        destination: WebView(url: $viewModel.webViewURL, title: $viewModel.webViewTitle),
                        isActive: $viewModel.isWebViewActive
                    ) {
                        SettingsButton(title: "help") {
                            viewModel.webViewURL = SettingsLinks.help
                            viewModel.isWebViewActive = true
                            viewModel.webViewTitle = "help"
                        }
                    }
                    //About Us
                    NavigationLink(
                        destination: WebView(url: $viewModel.webViewURL, title: $viewModel.webViewTitle),
                        isActive: $viewModel.isWebViewActive
                    ) {
                        SettingsButton(title: "aboutUs") {
                            viewModel.webViewURL = SettingsLinks.aboutUs
                            viewModel.isWebViewActive = true
                            viewModel.webViewTitle = "aboutUs"
                        }
                    }
                    
                    Spacer()
                }
                .padding(.horizontal, 29)
                .loader(isLoading: $viewModel.isLoading)
            }
        }
        .fullScreenCover(isPresented: $isLoginModalPresented) {
            MQLSignInView(isModalPresented: $isLoginModalPresented)
        }
        
    }
}

