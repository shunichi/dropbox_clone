user = User.create(email: 'user@example.com', password: 'password', confirmed_at: Time.now.utc)

def create_inode(path, inode)
  Dir::glob("#{path}/*").sort.each do |f|
    puts "#{f}"

    name = File.basename(f)

    if FileTest::directory?(f)
      directory = Inode.create(name: name, parent: inode, inode_type: 'directory')
      create_inode(f, directory)
    else
      Inode.create(name: name, parent: inode, inode_type: 'file', content: File.open(f))
    end
  end
end

create_inode(Rails.root.join('db', 'data', 'user'), user.inode)

10.times do |i|
  User.create(email: "user#{i}@example.com", password: 'password', confirmed_at: Time.now.utc)
end

other_user = User.create(email: 'user11@example.com', password: 'password', confirmed_at: Time.now.utc)
create_inode(Rails.root.join('db', 'data', 'user11'), other_user.inode)

user.follow(other_user.inode.children.first)
