module InodesHelper
  def code_ray(inode)
    begin
      CodeRay.scan_file(inode.content.path).html.html_safe
    rescue ArgumentError
      inode.name
    end
  end

  def breadcrumb(inode, share = nil)
    content_tag :ol, class: 'breadcrumb' do
      if (owner = @inode.root.user) != current_user
        s = content_tag :li do
          owner.email
        end
        concat s
      end

      inode.path.each do |i|
        s = content_tag :li do
          if i != inode
            if share
              concat link_to i.name, share_inode_path(share, i)
            else
              concat link_to i.name, i
            end
          else
            concat i.name
          end
        end

        concat s
      end
    end
  end
end
