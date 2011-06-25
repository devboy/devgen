require "buildr"

class Buildr::Application
  def only_load_buildfile
    standard_exception_handling do
      load_buildfile
    end
  end
end


class BuildrReader

  def self.read
    @init = true
    Buildr.application.only_load_buildfile
  end

  def self.projects
    read unless @init
    Buildr.projects
  end

  def self.current_project
    read unless @init
    c_project = nil
    projects.each do |project|
      c_project = project if project.base_dir == DEVGEN_WD
    end
    c_project
  end

end