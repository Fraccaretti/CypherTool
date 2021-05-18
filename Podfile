platform :ios, '11.0'
workspace 'CypherTool.xcworkspace'
project 'CypherTool.xcodeproj'
inhibit_all_warnings!
use_frameworks!

Cocoapod = Struct.new(:name, :version, :git, :branch)

SwiftyBeaver = Cocoapod.new("SwiftyBeaver")
Swinject = Cocoapod.new("Swinject", "~> 2.6")
SwinjectStoryboard = Cocoapod.new("SwinjectStoryboard", "~> 2.2")

target 'CypherTool' do 
    pod SwiftyBeaver.name
    pod Swinject.name, Swinject.version
    pod SwinjectStoryboard.name, SwinjectStoryboard.version
end