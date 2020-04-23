# Uncomment the next line to define a global platform for your project
 platform :ios, '11.0'

target 'SPHTech' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
  inherit! :search_paths
  pod 'Swinject','~> 2.6.0'
  pod 'SwinjectStoryboard','~> 2.2.0'
  pod 'RxSwift', '~> 5.1'
  pod 'RxCocoa', '~> 5.1'
  pod 'Alamofire', '~> 5.1'
  pod 'ObjectMapper', '~> 3.5'
  pod 'SVProgressHUD'
  
  pod 'SBTUITestTunnelServer'
  pod 'GCDWebServer', :inhibit_warnings => true
  
  # Pods for SPHTech

  target 'SPHTechTests' do
    inherit! :search_paths
    pod 'RxSwift', '~> 5.1'
    pod 'RxCocoa', '~> 5.1'
    pod 'Alamofire', '~> 5.1'
    pod 'ObjectMapper', '~> 3.5'
    pod 'Quick', '~> 2.2'
    pod 'Nimble', '~> 8.0'
  end

  target 'SPHTechUITests' do
    pod 'RxSwift', '~> 5.1'
    pod 'RxCocoa', '~> 5.1'
    pod 'Quick', '~> 2.2'
    pod 'Nimble', '~> 8.0'
    pod 'SBTUITestTunnelClient'
  end
end
