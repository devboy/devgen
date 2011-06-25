require File.dirname(__FILE__) + '/devgen/buildr/buildr_reader'

class Devgen < Thor
  include Thor::Actions

  source_root File.join( File.dirname(__FILE__), "devgen", "templates" )

  argument :package_name, :type => :string, :desc => "package desciption"
  argument :class_name, :type => :string, :desc => "class desciption"

  method_option :test, :type => :boolean, :default => false, :aliases => "-t"
  desc "clazz PACKAGE CLASS_NAME", "Generates class"
  def clazz
    project = BuildrReader.current_project
    src_dir = project.compile.sources.first.to_str
    template( "ClassTemplate.erb", get_class_file( class_name, package_name, src_dir) )
    if options[:test]
      invoke :test
    end
  end

  desc "test PACKAGE CLASS_NAME", "Generates test"
  def test
    project = BuildrReader.current_project
    if project.test.compile.sources.length > 0
      src_dir = project.test.compile.sources.first.to_str
    else
      src_dir = project._(:source,:test,:as3)
    end
    template( "ClassTemplate.erb", get_class_file( class_name+"Test", package_name, src_dir) )
  end

  private

  def get_class_file( class_name, package, src_dir )
    File.join(src_dir,package.split("."),"#{class_name}.as")
  end

end