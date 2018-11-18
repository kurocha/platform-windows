
#
#  This file is part of the "Teapot" project, and is released under the MIT license.
#

teapot_version "1.0.0"

define_target "platform-windows" do |target|
	target.provides "Platform/windows" do
		default platform_name "windows"
		default platform_path Pathname.new("/")
		
		default architectures []
		
		buildflags [
			:architectures,
			"-fPIC"
		]
		
		linkflags []
		
		cflags [:buildflags]
		cxxflags [:buildflags]
		ldflags [:buildflags, lambda {linkflags.reverse}]
		
		configure []
	end
	
	target.depends :variant
	
	target.depends :compiler

	target.provides :platform => "Platform/windows"
end

define_target "compiler-gcc" do |target|
	target.priority = 5
	
	target.provides "Compiler/clang" do
		default cc ENV.fetch('CC', "gcc")
		default cxx ENV.fetch('CXX', "g++")
	end
	
	target.provides :compiler => "Compiler/clang"
end

define_target "compiler-clang" do |target|
	target.priority = 10
	
	target.provides "Compiler/clang" do
		default cc ENV.fetch('CC', "clang")
		default cxx ENV.fetch('CXX', "clang++")
		
		append cxxflags "-stdlib=libc++"
		append ldflags "-lc++"
	end
	
	target.provides :compiler => "Compiler/clang"
end
