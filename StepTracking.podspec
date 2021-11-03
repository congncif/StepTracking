#
# Be sure to run `pod lib lint StepTracking.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'StepTracking'
  s.version          = '0.4.0'
  s.swift_versions    = ["5.4", "5.5"]
  s.summary          = '[StepTracking] Track code behavior follow step by step.'

  s.description      = <<-DESC
  Core Tracking to implement tracking layer which independent with Analytics agencies.
  Your flow will be abstracted to steps. Each step has some default values. All events was sent in step included available values of the step.
                       DESC

  s.homepage         = 'https://github.com/congncif/StepTracking'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'NGUYEN CHI CONG' => 'congnc.if@gmail.com' }
  s.source           = { :git => 'https://github.com/congncif/StepTracking.git', :tag => s.version.to_s }
   s.social_media_url = 'https://twitter.com/congncif'

  s.ios.deployment_target = '10.0'

  s.default_subspec = 'Default'
  
  s.subspec 'Default' do |co|
      co.dependency 'StepTracking/Core'
  end
  
  s.subspec 'Core' do |co|
      co.source_files = 'StepTracking/StepTracking/**/*.swift'
  end
end
