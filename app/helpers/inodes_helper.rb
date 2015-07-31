module InodesHelper
  def code_ray(inode)
    begin
      CodeRay.scan_file(inode.content.path).html.html_safe
    rescue ArgumentError
      inode.name
    end
  end
end
