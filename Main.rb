# encoding: UTF-8
require 'fileutils'
require_relative 'lib'
def creerDirectory(i)
	parent = File.dirname(i)
	unless File.exist?(i)
		if File.exist?(parent)
			Dir.mkdir(i)
		else
			creerDirectory(parent)
			creerDirectory(i)
		end
	end
end
if File.exist?("Output")
	FileUtils.rm_r ("Output")
end
Dir.mkdir("Output")
chemins = Dir["Input/**/*"].select{|i|File.file?(i)}
chemins.each do |i|
	new_chem = i.sub("Input", "Output")
	creerDirectory(File.dirname(new_chem))
	contenu = File.open(i,'r').read
	if File.extname(i) == ".txt"
		contenu = to_html(i)
		new_chem = new_chem.sub(".txt", ".html")
	end
	f = File.open(new_chem ,'w')
	f.write(contenu)
	f.close
end
