class CreateNewsletters < ActiveRecord::Migration
  def self.up
    create_table :newsletters, :force => true do |t|
      t.string :name
      t.string :email
      t.boolean :situation,:default => true

      t.timestamps
    end

    m = Menu.find_or_create_by_name("Newsletters")
    Menu.transaction do
      s1 = m.sub_menus.create!(:menu_id => m.id, :name => "Listar Newsletter", :url => "/admin/newsletters",
          :title => "Clique aqui para listar os(as) newsletter", :position => 0) rescue nil
    end
  end

  def self.down
    m = Menu.find_by_name("Newsletters")
    m.destroy
    drop_table :newsletters
  end
end

